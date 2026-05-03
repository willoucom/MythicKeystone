// Build-time content generator.
// Reads MythicDungeonNotes Lua files and produces JSON consumed by Astro pages.
//
// - Parses Locales/{enUS,frFR}.lua via regex (AceLocale format)
// - Evaluates Guide/Dungeons/*.lua in a Lua VM (wasmoon) with stubs for ns.Spell / ns.NPC / ns.L
// - Post-processes htmlContent strings: WoW color codes, texture escapes, spell/npc markers
// - Copies dungeon images from MythicDungeonNotes/Guide/Dungeons/Images to web/public/images
//
// Outputs:
//   src/content/locales/{en,fr}.json
//   src/content/guides/{en,fr}/<id>.json
//   src/content/index.json
//   public/images/*.png

import { readFile, writeFile, mkdir, readdir, copyFile, stat } from 'node:fs/promises';
import { existsSync } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { LuaFactory } from 'wasmoon';
import sharp from 'sharp';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const WEB_ROOT = path.resolve(__dirname, '..');
const REPO_ROOT = path.resolve(WEB_ROOT, '..');
const ADDON_ROOT = path.join(REPO_ROOT, 'MythicDungeonNotes');
const LOCALES_DIR = path.join(ADDON_ROOT, 'Locales');
const DUNGEONS_DIR = path.join(ADDON_ROOT, 'Guide', 'Dungeons');
const IMAGES_SRC_DIR = path.join(DUNGEONS_DIR, 'Images');

const OUT_LOCALES = path.join(WEB_ROOT, 'src', 'data', 'locales');
const OUT_GUIDES = path.join(WEB_ROOT, 'src', 'data', 'guides');
const OUT_INDEX = path.join(WEB_ROOT, 'src', 'data', 'index.json');
const OUT_IMAGES = path.join(WEB_ROOT, 'public', 'images');
const OUT_ASSETS = path.join(WEB_ROOT, 'src', 'assets');

// Max width (px) for dungeon map images served on the web.
// Source images are 1000-1600px; we don't need more than ~1000 for retina display at 500px CSS width.
const DUNGEON_IMG_MAX_WIDTH = 1000;
const WEBP_QUALITY = 82;

// Must match astro.config.mjs `base`. Hardcoded to /MythicKeystone so dev URLs match prod.
// Local dev URL: http://localhost:4321/MythicKeystone/en/
const BASE_PATH = '/MythicKeystone';

const LOCALES = [
  { code: 'en', file: 'enUS.lua' },
  { code: 'fr', file: 'frFR.lua' },
];

// ---------------------------------------------------------------------------
// Locale parsing — AceLocale format: L["KEY"] = "value"
// ---------------------------------------------------------------------------

function parseLocaleFile(content) {
  const dict = {};
  // Match L["KEY"] = "value" (handles \" inside value, no multi-line strings here).
  const re = /L\["([^"]+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"/g;
  let m;
  while ((m = re.exec(content)) !== null) {
    const key = m[1];
    const raw = m[2];
    // Unescape Lua string escapes we actually use.
    const value = raw
      .replace(/\\n/g, '\n')
      .replace(/\\t/g, '\t')
      .replace(/\\"/g, '"')
      .replace(/\\\\/g, '\\');
    dict[key] = value;
  }
  return dict;
}

// ---------------------------------------------------------------------------
// Guide evaluation — run each .lua via wasmoon with stubs.
// ---------------------------------------------------------------------------

const SPELL_OPEN = 'SPELL:';
const NPC_OPEN = 'NPC:';
const MARKER_END = '';

function makeStubLua(localeDict) {
  // Lua prelude that simulates the addon environment for a single guide file.
  // Variadic args (myname, ns) will be supplied via the loaded chunk's argument list.
  // We expose a global `__capture` table to capture the appended guide.
  const localeEntries = Object.entries(localeDict)
    .map(([k, v]) => {
      const escaped = v
        .replace(/\\/g, '\\\\')
        .replace(/"/g, '\\"')
        .replace(/\n/g, '\\n')
        .replace(/\r/g, '\\r');
      const escKey = k.replace(/\\/g, '\\\\').replace(/"/g, '\\"');
      return `  ["${escKey}"] = "${escaped}"`;
    })
    .join(',\n');

  return `
local __locale = {
${localeEntries}
}
local __L_mt = { __index = function(_, key) return __locale[key] or ("[L:" .. tostring(key) .. "]") end }
local L = setmetatable({}, __L_mt)

local ns = {
  L = L,
  guideData = {},
  Spell = function(id) return "${SPELL_OPEN}" .. tostring(id) .. "${MARKER_END}" end,
  NPC = function(id, name) return "${NPC_OPEN}" .. tostring(id) .. "|" .. (name or "") .. "${MARKER_END}" end,
}

__captureNs = ns
local myname = "MythicDungeonNotes"
__captureMyname = myname
__captureL = L

-- The actual guide chunk follows.
`;
}

async function evaluateGuideFile(lua, prelude, guideSource) {
  // Reset captures.
  await lua.doString('__captureNs = nil; __captureMyname = nil');
  // Wrap: prelude defines L/ns, then we redefine `local myname, ns = ...`-style locals
  // so the guide file's own `local myname, ns = ...` line works.
  // To make the guide's `local myname, ns = ...` resolve correctly, we run it as a chunk
  // with two varargs.
  const wrapped = `
${prelude}
local function __runGuide(...)
${guideSource}
end
__runGuide(__captureMyname, __captureNs)
return __captureNs.guideData[1]
`;
  const result = await lua.doString(wrapped);
  return result;
}

// ---------------------------------------------------------------------------
// Post-processing of htmlContent strings — WoW escape codes → HTML.
// ---------------------------------------------------------------------------

function sanitize(s) {
  // We only escape <script tags as a defensive measure; the rest is our own content.
  return s.replace(/<script\b/gi, '&lt;script');
}

// Wowhead language subdomain per locale. Empty/unknown → 'www' (English).
const WOWHEAD_SUBDOMAIN = {
  en: 'www',
  fr: 'fr',
  de: 'de',
  es: 'es',
  ru: 'ru',
  pt: 'pt',
  it: 'it',
};

function wowToHtml(input, basePath, locale) {
  const sub = WOWHEAD_SUBDOMAIN[locale] ?? 'www';
  let s = sanitize(input);

  // 1. Spell markers: \x01SPELL:ID\x02
  s = s.replace(new RegExp(SPELL_OPEN.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + '(\\d+)' + MARKER_END, 'g'),
    (_, id) => `<a href="https://${sub}.wowhead.com/spell=${id}" class="wow-link" data-wh-icon-size="small" data-wowhead="spell=${id}"></a>`);

  // 2. NPC markers: \x01NPC:ID|NAME\x02
  s = s.replace(new RegExp(NPC_OPEN.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + '(\\d+)\\|([^]*)' + MARKER_END, 'g'),
    (_, id, name) => `<a href="https://${sub}.wowhead.com/npc=${id}" class="wow-link" data-wowhead="npc=${id}">${escapeHtml(name)}</a>`);

  // 3. Texture escapes: |T<path>:W:H[:...]|t
  s = s.replace(/\|T([^:|]+):(\d+):(\d+)(?::[^|]*)?\|t/g, (_, p, w, h) => {
    const url = textureToUrl(p);
    if (!url) return '';
    return `<img class="wow-icon" src="${url}" width="${w}" height="${h}" alt="" />`;
  });

  // 4. Color codes: |cffRRGGBB...|r — apply iteratively to handle innermost first.
  let prev;
  do {
    prev = s;
    s = s.replace(/\|c([fF][fF])([0-9a-fA-F]{6})((?:(?!\|c)(?!\|r).)*)\|r/g,
      (_, alpha, color, body) => `<span style="color:#${color}">${body}</span>`);
  } while (s !== prev);

  // 5. Embedded <img src='Interface/Addons/.../Images/<NAME>' ... /> → /images/<NAME>.webp
  // Source images are pre-optimized to WebP at build time (see processDungeonImages).
  s = s.replace(/<img\s+src=['"]Interface\/Addons\/[^'"\/]+\/Guide\/Dungeons\/Images\/([^'".]+)['"]([^>]*?)\s*\/?>/gi,
    (_, name, rest) => `<img src="${basePath}/images/${name}.webp" loading="lazy" decoding="async"${rest} />`);

  return s;
}

function textureToUrl(texPath) {
  // Normalize backslashes and case.
  const norm = texPath.replace(/\\/g, '/').toLowerCase();
  const m = norm.match(/^interface\/icons\/(.+)$/);
  if (m) {
    return `https://wow.zamimg.com/images/wow/icons/medium/${m[1]}.jpg`;
  }
  // Other Interface/* paths are in-game UI textures with no public web equivalent — drop them.
  return null;
}

function escapeHtml(s) {
  return String(s).replace(/[&<>"']/g, c => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;',
  }[c]));
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

async function main() {
  // 1. Parse locales.
  const locales = {};
  for (const { code, file } of LOCALES) {
    const content = await readFile(path.join(LOCALES_DIR, file), 'utf8');
    locales[code] = parseLocaleFile(content);
    console.log(`[locales] ${code}: ${Object.keys(locales[code]).length} keys`);
  }

  await mkdir(OUT_LOCALES, { recursive: true });
  for (const code of Object.keys(locales)) {
    await writeFile(path.join(OUT_LOCALES, `${code}.json`), JSON.stringify(locales[code], null, 2));
  }

  // 2. Init Lua VM (one factory, reused).
  const factory = new LuaFactory();

  // 3. Discover dungeon files (skip _demo.lua).
  const allFiles = await readdir(DUNGEONS_DIR);
  const dungeonFiles = allFiles.filter(f => f.endsWith('.lua') && !f.startsWith('_'));
  console.log(`[guides] found ${dungeonFiles.length} dungeon files`);

  const indexEntries = []; // [{ id, shortName, groups, name: { en, fr } }]

  for (const code of Object.keys(locales)) {
    await mkdir(path.join(OUT_GUIDES, code), { recursive: true });
  }

  for (const file of dungeonFiles) {
    const fullPath = path.join(DUNGEONS_DIR, file);
    const guideSource = await readFile(fullPath, 'utf8');

    let firstId = null;
    let firstShortName = null;
    let firstGroups = null;
    const namesByLocale = {};

    for (const code of Object.keys(locales)) {
      const lua = await factory.createEngine();
      try {
        const prelude = makeStubLua(locales[code]);
        const guide = await evaluateGuideFile(lua, prelude, guideSource);
        if (!guide) {
          console.warn(`[guides] ${file} did not register a guide entry`);
          continue;
        }

        // Convert Lua table → plain JS object.
        const out = {
          id: guide.id,
          name: guide.name,
          shortName: guide.shortName,
          groups: tableToArray(guide.groups),
          icon: guide.icon ?? null,
          background: guide.background ?? null,
          vignette: guide.vignette ?? null,
          mapIds: tableToArray(guide.mapIds),
          spellportalid: guide.spellportalid ?? null,
          sections: tableToArray(guide.sections).map(sec => ({
            name: sec.name,
            html: wowToHtml(sec.htmlContent ?? '', BASE_PATH, code),
          })),
        };

        firstId = firstId ?? out.id;
        firstShortName = firstShortName ?? out.shortName;
        firstGroups = firstGroups ?? out.groups;
        namesByLocale[code] = out.name;

        await writeFile(
          path.join(OUT_GUIDES, code, `${out.id}.json`),
          JSON.stringify(out, null, 2),
        );
      } finally {
        lua.global.close();
      }
    }

    if (firstId) {
      indexEntries.push({
        id: firstId,
        shortName: firstShortName,
        groups: firstGroups,
        name: namesByLocale,
      });
    }
  }

  // 4. Write index of all dungeons.
  await writeFile(OUT_INDEX, JSON.stringify({ dungeons: indexEntries }, null, 2));
  console.log(`[index] ${indexEntries.length} dungeons indexed`);

  // 5. Process dungeon map images: resize + convert to WebP, output to public/images/.
  await mkdir(OUT_IMAGES, { recursive: true });
  if (existsSync(IMAGES_SRC_DIR)) {
    const imgs = await readdir(IMAGES_SRC_DIR);
    let processed = 0;
    let savedBytes = 0;
    for (const f of imgs) {
      if (!f.toLowerCase().endsWith('.png')) continue;
      const srcPath = path.join(IMAGES_SRC_DIR, f);
      const outPath = path.join(OUT_IMAGES, path.parse(f).name + '.webp');
      const srcSize = (await stat(srcPath)).size;
      await sharp(srcPath)
        .resize({ width: DUNGEON_IMG_MAX_WIDTH, withoutEnlargement: true })
        .webp({ quality: WEBP_QUALITY })
        .toFile(outPath);
      const outSize = (await stat(outPath)).size;
      savedBytes += srcSize - outSize;
      processed++;
    }
    console.log(`[images] ${processed} dungeon images optimized to WebP (-${(savedBytes / 1024).toFixed(0)}KB)`);
  }

  // 6. Copy addon logo to src/assets/ so AddonBanner.astro can import it via astro:assets.
  // Astro will then auto-generate optimized WebP/AVIF variants at the right sizes.
  await mkdir(OUT_ASSETS, { recursive: true });
  const logoSrc = path.join(REPO_ROOT, 'MythicDungeonNotes.png');
  if (existsSync(logoSrc)) {
    await copyFile(logoSrc, path.join(OUT_ASSETS, 'MythicDungeonNotes.png'));
    console.log(`[logo] copied addon logo to src/assets/`);
  }

  console.log('\nbuild-content done.');
}

function tableToArray(t) {
  if (!t) return [];
  if (Array.isArray(t)) return t;
  // wasmoon returns Lua tables as JS objects with numeric keys 1..n
  const arr = [];
  let i = 1;
  while (t[i] !== undefined) {
    arr.push(t[i]);
    i++;
  }
  return arr;
}

main().catch(err => {
  console.error(err);
  process.exit(1);
});
