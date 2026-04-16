#!/usr/bin/env python3
"""
preview_guides.py
Generates a standalone HTML preview of all MythicDungeonNotes dungeon guides.

Usage:
    python preview_guides.py [locale] [output.html]
    locale  : frFR (default) or enUS
    output  : preview_guides.html (default)
"""

import re
import sys
from pathlib import Path
from html import escape as html_escape

SCRIPT_DIR = Path(__file__).parent
ADDON_DIR = SCRIPT_DIR / "MythicDungeonNotes"
IMAGES_DIR = ADDON_DIR / "Guide" / "Dungeons" / "Images"


# ---------------------------------------------------------------------------
# Locale parsing
# ---------------------------------------------------------------------------

def parse_locale(locale_code: str) -> dict:
    path = ADDON_DIR / "Locales" / f"{locale_code}.lua"
    result = {}
    text = path.read_text(encoding="utf-8")
    for m in re.finditer(r'L\["([^"]+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', text):
        value = m.group(2).replace('\\"', '"').replace("\\n", "\n").replace("\\'", "'")
        result[m.group(1)] = value
    result["AddonCodeName"] = "MythicDungeonNotes"
    return result


# ---------------------------------------------------------------------------
# TGA → PNG conversion
# ---------------------------------------------------------------------------

def convert_images_to_png() -> set:
    """
    Convert every .tga file in IMAGES_DIR to .png (skip if PNG already up to date).
    Returns the set of stems that have a usable PNG.
    """
    try:
        from PIL import Image
    except ImportError:
        print("Pillow not found — images will not be displayed.")
        return set()

    available = set()
    for tga in IMAGES_DIR.glob("*.tga"):
        png = tga.with_suffix(".png")
        if not png.exists() or tga.stat().st_mtime > png.stat().st_mtime:
            try:
                Image.open(tga).save(png)
                print(f"  Converted {tga.name} -> {png.name}")
            except Exception as exc:
                print(f"  Could not convert {tga.name}: {exc}")
                continue
        available.add(tga.stem)
    return available


# ---------------------------------------------------------------------------
# WoW format codes → HTML
# ---------------------------------------------------------------------------

def wow_to_html(text: str, png_stems: set) -> str:
    """Convert WoW-specific markup to HTML."""
    # |cffRRGGBB ... |r  →  colored span  (handle up to 4 levels of nesting)
    for _ in range(4):
        text = re.sub(
            r'\|cff([0-9a-fA-F]{6})((?:(?!\|cff).)*?)\|r',
            lambda m: f'<span style="color:#{m.group(1)}">{m.group(2)}</span>',
            text,
            flags=re.DOTALL,
        )
    # |TPath:w:h...|t  →  remove (WoW texture references)
    text = re.sub(r'\|T[^|]+\|t', '', text)
    # |Hspell:ID|h[Name]|h  →  wowhead spell link
    text = re.sub(
        r'\|Hspell:(\d+)\|h\[([^\]]*)\]\|h',
        r'<a class="spell-link" href="https://www.wowhead.com/spell=\1" target="_blank">\2</a>',
        text,
    )
    # |Hnpc:ID|h[Name]|h  →  wowhead NPC link
    text = re.sub(
        r'\|Hnpc:(\d+)\|h\[([^\]]*)\]\|h',
        r'<a class="npc-link" href="https://www.wowhead.com/npc=\1" target="_blank">\2</a>',
        text,
    )
    # img src="Interface/Addons/MythicDungeonNotes/Guide/Dungeons/Images/STEM"
    #  →  src="MythicDungeonNotes/Guide/Dungeons/Images/STEM.png"  (if PNG exists)
    #  →  removed otherwise
    def rewrite_img(m: re.Match) -> str:
        attrs_before = m.group(1)  # everything before src=
        stem         = m.group(2)  # e.g. "AA_map"
        attrs_after  = m.group(3)  # width/height/etc.
        if stem in png_stems:
            rel = f"MythicDungeonNotes/Guide/Dungeons/Images/{stem}.png"
            return f'<img {attrs_before}src="{rel}"{attrs_after}/>'
        return ""                  # no PNG available → drop the tag

    text = re.sub(
        r"<img\s+((?:(?!src=)[^>])*?)"          # optional attrs before src
        r"""src=['"']Interface/Addons/MythicDungeonNotes/Guide/Dungeons/Images/([^'"]+)['"']"""
        r"((?:[^/]|/(?!>))*?)"                  # optional attrs after src
        r"/?>",
        rewrite_img,
        text,
        flags=re.IGNORECASE,
    )
    return text


# ---------------------------------------------------------------------------
# Lua string expression evaluator
# ---------------------------------------------------------------------------

class LuaStringEval:
    """
    Evaluates a subset of Lua string-concatenation expressions to a Python str.
    Handles: double/single-quoted literals, .. concatenation, L["KEY"],
             ICON_* variables, ns.Spell(id), ns.NPC(id, "name"),
             string.format(template, arg, ...).
    """

    def __init__(self, locale: dict, icons: dict):
        self.locale = locale
        self.icons = icons
        self.src = ""
        self.pos = 0

    def eval(self, src: str) -> str:
        self.src = src
        self.pos = 0
        return self._parse_concat()

    # --- helpers -----------------------------------------------------------

    def _skip_ws(self):
        while self.pos < len(self.src) and self.src[self.pos] in " \t\n\r":
            self.pos += 1

    def _rest(self) -> str:
        return self.src[self.pos:]

    def _starts(self, s: str) -> bool:
        return self.src[self.pos:].startswith(s)

    # --- grammar -----------------------------------------------------------

    def _parse_concat(self) -> str:
        result = self._parse_term()
        while True:
            self._skip_ws()
            if self._starts(".."):
                self.pos += 2
                self._skip_ws()
                result += self._parse_term()
            else:
                break
        return result

    def _parse_term(self) -> str:
        self._skip_ws()
        if self.pos >= len(self.src):
            return ""

        if self._starts('"'):
            return self._parse_dquote()
        if self._starts("'"):
            return self._parse_squote()
        if self._starts('L["'):
            return self._parse_locale_ref()
        if self._starts("table.concat("):
            return self._parse_table_concat()
        if self._starts("ns.Spell("):
            return self._parse_spell()
        if self._starts("ns.NPC("):
            return self._parse_npc()
        if self._starts("string.format("):
            return self._parse_format()
        if self._starts("fmt("):
            return self._parse_fmt()
        if self._starts("h1("):
            return self._parse_html_wrapper("h1")
        if self._starts("p("):
            return self._parse_html_wrapper("p")
        if self._starts("ICON_"):
            return self._parse_icon()
        if self._starts("myname"):
            return self._parse_myname()

        # Unknown token — skip to next ".." or end
        end = self.src.find("..", self.pos)
        if end == -1:
            end = len(self.src)
        token = self.src[self.pos:end].strip()
        self.pos = end
        return f"[?:{token}]"

    def _parse_dquote(self) -> str:
        self.pos += 1  # skip opening "
        parts = []
        while self.pos < len(self.src):
            c = self.src[self.pos]
            if c == "\\":
                self.pos += 1
                if self.pos < len(self.src):
                    esc = self.src[self.pos]
                    parts.append({"n": "\n", "t": "\t", '"': '"', "\\": "\\"}.get(esc, esc))
                    self.pos += 1
            elif c == '"':
                self.pos += 1
                break
            else:
                parts.append(c)
                self.pos += 1
        return "".join(parts)

    def _parse_squote(self) -> str:
        self.pos += 1
        parts = []
        while self.pos < len(self.src):
            c = self.src[self.pos]
            if c == "\\":
                self.pos += 1
                if self.pos < len(self.src):
                    parts.append(self.src[self.pos])
                    self.pos += 1
            elif c == "'":
                self.pos += 1
                break
            else:
                parts.append(c)
                self.pos += 1
        return "".join(parts)

    def _parse_locale_ref(self) -> str:
        m = re.match(r'L\["([^"]+)"\]', self._rest())
        if m:
            self.pos += len(m.group(0))
            return self.locale.get(m.group(1), f"[L:{m.group(1)}]")
        self.pos += 1
        return ""

    def _parse_spell(self) -> str:
        m = re.match(r"ns\.Spell\((\d+)\)", self._rest())
        if m:
            self.pos += len(m.group(0))
            sid = m.group(1)
            # Emit WoW-style markup so wow_to_html() can convert it later
            return f"|cff71d5ff|Hspell:{sid}|h[Spell #{sid}]|h|r"
        self.pos += 1
        return ""

    def _parse_npc(self) -> str:
        m = re.match(r'ns\.NPC\((\d+),\s*(?:"([^"]*)"|([\w ]+))\)', self._rest())
        if m:
            self.pos += len(m.group(0))
            nid = m.group(1)
            name = m.group(2) or m.group(3) or "?"
            return f"|cffffcc00|Hnpc:{nid}|h[{name}]|h|r"
        self.pos += 1
        return ""

    def _parse_format(self) -> str:
        assert self._starts("string.format(")
        self.pos += len("string.format(")
        self._skip_ws()
        template = self._parse_term()
        args = []
        while True:
            self._skip_ws()
            if self.pos >= len(self.src) or self.src[self.pos] == ")":
                break
            if self.src[self.pos] == ",":
                self.pos += 1
                self._skip_ws()
                args.append(self._parse_term())
        if self.pos < len(self.src) and self.src[self.pos] == ")":
            self.pos += 1
        try:
            return template % tuple(args)
        except Exception:
            return template

    def _parse_icon(self) -> str:
        m = re.match(r"(ICON_\w+)", self._rest())
        if m:
            self.pos += len(m.group(0))
            return self.icons.get(m.group(1), "")
        self.pos += 1
        return ""

    def _parse_table_concat(self) -> str:
        """table.concat({ expr, expr, ... }) → concatenate all elements."""
        self.pos += len("table.concat(")
        self._skip_ws()
        if self.pos < len(self.src) and self.src[self.pos] == "{":
            self.pos += 1
        parts = []
        while self.pos < len(self.src):
            self._skip_ws()
            if self.pos >= len(self.src):
                break
            c = self.src[self.pos]
            if c == "}":
                self.pos += 1
                break
            if c == ",":
                self.pos += 1
                continue
            if self.src[self.pos:self.pos + 2] == "--":   # skip line comments
                eol = self.src.find("\n", self.pos)
                self.pos = eol + 1 if eol != -1 else len(self.src)
                continue
            parts.append(self._parse_concat())
        self._skip_ws()
        if self.pos < len(self.src) and self.src[self.pos] == ")":
            self.pos += 1
        return "".join(parts)

    def _parse_html_wrapper(self, tag: str) -> str:
        """h1(expr) / p(expr) → <tag>expr</tag>"""
        self.pos += len(tag) + 1   # skip e.g. "p("
        self._skip_ws()
        inner = self._parse_concat()
        self._skip_ws()
        if self.pos < len(self.src) and self.src[self.pos] == ")":
            self.pos += 1
        return f"<{tag}>{inner}</{tag}>"

    def _parse_fmt(self) -> str:
        """fmt("KEY", arg, ...) → string.format(L["KEY"], arg, ...)"""
        self.pos += len("fmt(")
        self._skip_ws()
        key = self._parse_term()   # first arg is the locale key (string literal)
        args = []
        while True:
            self._skip_ws()
            if self.pos >= len(self.src) or self.src[self.pos] == ")":
                break
            if self.src[self.pos] == ",":
                self.pos += 1
                self._skip_ws()
                args.append(self._parse_term())
        if self.pos < len(self.src) and self.src[self.pos] == ")":
            self.pos += 1
        template = self.locale.get(key, f"[L:{key}]")
        try:
            return template % tuple(args)
        except Exception:
            return template

    def _parse_myname(self) -> str:
        """myname → addon folder name (same as L["AddonCodeName"])"""
        self.pos += len("myname")
        return self.locale.get("AddonCodeName", "MythicDungeonNotes")


# ---------------------------------------------------------------------------
# Balanced-brace block extractor
# ---------------------------------------------------------------------------

def _balanced_blocks(text: str, start: int):
    """
    Yield (block_text, end_pos) for each top-level {...} block found
    starting from `start` up to the first unmatched `}`.
    Block text is the content *between* the braces.
    """
    i = start
    while i < len(text):
        # Skip whitespace, commas, and line comments
        while i < len(text) and text[i] in " \t\n\r,":
            i += 1
        if i >= len(text):
            break
        if text[i:i+2] == "--":
            eol = text.find("\n", i)
            i = eol + 1 if eol != -1 else len(text)
            continue
        if text[i] != "{":
            break  # end of enclosing block

        # Walk the block with depth tracking, skipping strings
        depth = 0
        in_dq = in_sq = False
        j = i
        while j < len(text):
            c = text[j]
            if in_dq:
                if c == "\\" and j + 1 < len(text):
                    j += 2
                    continue
                if c == '"':
                    in_dq = False
            elif in_sq:
                if c == "\\" and j + 1 < len(text):
                    j += 2
                    continue
                if c == "'":
                    in_sq = False
            else:
                if c == '"':
                    in_dq = True
                elif c == "'":
                    in_sq = True
                elif c == "{":
                    depth += 1
                elif c == "}":
                    depth -= 1
                    if depth == 0:
                        yield text[i + 1 : j], j + 1
                        i = j + 1
                        break
                elif text[j:j+2] == "--":
                    eol = text.find("\n", j)
                    j = (eol + 1 if eol != -1 else len(text)) - 1
            j += 1
        else:
            break  # unterminated block


# ---------------------------------------------------------------------------
# Dungeon file parser
# ---------------------------------------------------------------------------

def parse_icon_defs(lua_text: str) -> dict:
    icons = {}
    for m in re.finditer(r'(ICON_\w+)\s*=\s*"((?:[^"\\]|\\.)*)"', lua_text):
        icons[m.group(1)] = m.group(2).replace('\\"', '"')
    return icons


def _field_expr(block: str, field: str):
    """
    Extract the raw Lua expression for `field` from a section block.
    Returns the expression string or None.
    """
    m = re.search(rf'\b{field}\s*=\s*', block)
    if not m:
        return None
    start = m.end()
    # Scan to expression end: stop at ',' or '}' at paren-depth 0,
    # respecting string literals and parentheses.
    depth = 0
    in_dq = in_sq = False
    i = start
    while i < len(block):
        c = block[i]
        if in_dq:
            if c == "\\" and i + 1 < len(block):
                i += 2
                continue
            if c == '"':
                in_dq = False
        elif in_sq:
            if c == "\\" and i + 1 < len(block):
                i += 2
                continue
            if c == "'":
                in_sq = False
        else:
            if c == '"':
                in_dq = True
            elif c == "'":
                in_sq = True
            elif c == "(":
                depth += 1
            elif c == ")":
                depth = max(0, depth - 1)
            elif c in "{}" and depth == 0:
                break
            elif c == "," and depth == 0:
                break
        i += 1
    return block[start:i].strip()


def parse_dungeon_file(path: Path, locale: dict) -> dict | None:
    text = path.read_text(encoding="utf-8")
    if "ns.guideData" not in text:
        return None

    icons = parse_icon_defs(text)
    evaluator = LuaStringEval(locale, icons)

    # --- dungeon meta fields ---
    meta: dict = {"file": path.name}
    for field in ("id", "shortName"):
        m = re.search(rf'\b{field}\s*=\s*"([^"]+)"', text)
        if m:
            meta[field] = m.group(1)
    name_m = re.search(r'\bname\s*=\s*L\["([^"]+)"\]', text)
    if name_m:
        meta["name"] = locale.get(name_m.group(1), name_m.group(1))
    else:
        nm = re.search(r'\bname\s*=\s*"([^"]+)"', text)
        if nm:
            meta["name"] = nm.group(1)

    # --- sections ---
    sections_m = re.search(r'\bsections\s*=\s*\{', text)
    if not sections_m:
        return {**meta, "sections": []}

    sections = []
    for block, _end in _balanced_blocks(text, sections_m.end()):
        name_expr = _field_expr(block, "name")
        html_expr = _field_expr(block, "htmlContent")
        if name_expr is None and html_expr is None:
            continue
        section = {}
        if name_expr:
            try:
                section["name"] = evaluator.eval(name_expr)
            except Exception as e:
                section["name"] = f"[err: {e}]"
        if html_expr:
            try:
                section["htmlContent"] = evaluator.eval(html_expr)
            except Exception as e:
                section["htmlContent"] = f"[err: {e}]"
        sections.append(section)

    return {**meta, "sections": sections}


# ---------------------------------------------------------------------------
# HTML generation
# ---------------------------------------------------------------------------

_PAGE = """\
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>MythicDungeonNotes — Preview</title>
<style>
*, *::before, *::after {{ box-sizing: border-box; margin: 0; padding: 0; }}
body {{
  background: #111827;
  color: #c6d4df;
  font-family: "Segoe UI", system-ui, sans-serif;
  font-size: 14px;
  display: flex;
  min-height: 100vh;
}}
#sidebar {{
  width: 230px;
  min-width: 230px;
  background: #0b0f18;
  padding: 12px 0;
  overflow-y: auto;
  border-right: 1px solid #1e2d3d;
  position: sticky;
  top: 0;
  height: 100vh;
}}
#sidebar h2 {{
  color: #ffd700;
  font-size: 10px;
  text-transform: uppercase;
  letter-spacing: 1.5px;
  padding: 8px 16px 4px;
}}
#sidebar a {{
  display: block;
  padding: 5px 16px;
  color: #8fa0b0;
  text-decoration: none;
  font-size: 12.5px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  transition: background .1s, color .1s;
}}
#sidebar a:hover {{ background: #182030; color: #d0e0f0; }}
#sidebar a.active {{ color: #ffd700; background: #182030; font-weight: bold; }}
#main {{
  flex: 1;
  padding: 28px 36px;
  max-width: 860px;
  min-width: 0;
}}
.dungeon {{ display: none; }}
.dungeon.active {{ display: block; }}
.dungeon-title {{
  color: #ffd700;
  font-size: 20px;
  font-weight: bold;
  border-bottom: 2px solid #ffd700;
  padding-bottom: 6px;
  margin-bottom: 20px;
}}
.dungeon-meta {{
  font-size: 11px;
  color: #445566;
  margin-top: 2px;
}}
.section {{
  margin-bottom: 16px;
  background: #0e1520;
  border: 1px solid #1a2a3a;
  border-radius: 6px;
  overflow: hidden;
}}
.section-title {{
  background: #16233a;
  color: #a0c4e0;
  font-size: 13px;
  font-weight: bold;
  padding: 7px 14px;
  border-bottom: 1px solid #1a2a3a;
  cursor: pointer;
  user-select: none;
  display: flex;
  justify-content: space-between;
  align-items: center;
}}
.section-title:hover {{ background: #1c2d48; }}
.section-title::after {{ content: "▾"; font-size: 11px; color: #5a7090; }}
.section-title.collapsed::after {{ content: "▸"; }}
.section-content {{
  padding: 10px 16px 12px;
  line-height: 1.65;
}}
.section-content p {{ margin-bottom: 2px; }}
.section-content h1 {{
  color: #ffd700;
  font-size: 13px;
  font-weight: bold;
  margin: 12px 0 4px;
  border-bottom: 1px solid #1e2d3d;
  padding-bottom: 3px;
}}
.section-content img {{
  display: block;
  max-width: 100%;
  border-radius: 4px;
  margin: 8px 0;
  border: 1px solid #1e2d3d;
}}
a.spell-link {{
  color: #71d5ff;
  font-weight: 600;
  text-decoration: none;
}}
a.spell-link:hover {{ text-decoration: underline; }}
a.npc-link {{
  color: #ffcc00;
  text-decoration: none;
}}
a.npc-link:hover {{ text-decoration: underline; }}
</style>
</head>
<body>
<nav id="sidebar">
  <h2>Donjons</h2>
  {nav}
</nav>
<main id="main">
  {content}
</main>
<script>
const links    = Array.from(document.querySelectorAll('#sidebar a'));
const dungeons = Array.from(document.querySelectorAll('.dungeon'));

function show(id) {{
  dungeons.forEach(d => d.classList.toggle('active', d.id === id));
  links.forEach(l => l.classList.toggle('active', l.dataset.id === id));
  history.replaceState(null, '', '#' + id);
}}

links.forEach(l => l.addEventListener('click', e => {{
  e.preventDefault();
  show(l.dataset.id);
}}));

document.querySelectorAll('.section-title').forEach(t => {{
  t.addEventListener('click', () => {{
    const body = t.nextElementSibling;
    const hidden = body.style.display === 'none';
    body.style.display = hidden ? '' : 'none';
    t.classList.toggle('collapsed', !hidden);
  }});
}});

const hash = location.hash.slice(1);
const first = links[0]?.dataset.id;
if (hash && document.getElementById(hash)) show(hash);
else if (first) show(first);
</script>
</body>
</html>
"""


def build_section_html(section: dict, png_stems: set) -> str:
    title = html_escape(section.get("name", "—"))
    raw = section.get("htmlContent", "")
    body = wow_to_html(raw, png_stems)
    return (
        f'<div class="section">'
        f'<div class="section-title">{title}</div>'
        f'<div class="section-content">{body}</div>'
        f'</div>'
    )


def build_dungeon_html(dungeon: dict, idx: int, png_stems: set) -> tuple:
    did   = html_escape(dungeon.get("id",        f"dungeon{idx}"))
    name  = html_escape(dungeon.get("name",       did))
    short = html_escape(dungeon.get("shortName",  did))
    fname = html_escape(dungeon.get("file",       ""))

    nav = f'<a href="#{did}" data-id="{did}">[{short}] {name}</a>'

    sections_html = "".join(build_section_html(s, png_stems) for s in dungeon.get("sections", []))
    if not sections_html:
        sections_html = '<p style="color:#445566;font-style:italic">Aucune section disponible.</p>'

    div = (
        f'<div class="dungeon" id="{did}">'
        f'<div class="dungeon-title">{name}'
        f'<div class="dungeon-meta">{fname}</div></div>'
        f'{sections_html}'
        f'</div>'
    )
    return nav, div


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

def main():
    locale_code = sys.argv[1] if len(sys.argv) > 1 else "frFR"
    output_path = sys.argv[2] if len(sys.argv) > 2 else "preview_guides.html"

    print(f"Locale : {locale_code}")
    locale = parse_locale(locale_code)
    print(f"  {len(locale)} chaines chargees.")

    print("Images ...")
    png_stems = convert_images_to_png()
    print(f"  {len(png_stems)} image(s) disponible(s) : {', '.join(sorted(png_stems)) or 'aucune'}")

    dungeon_dir = ADDON_DIR / "Guide" / "Dungeons"
    files = sorted(dungeon_dir.glob("*.lua"))

    dungeons = []
    for f in files:
        if f.stem.startswith("_"):
            continue
        print(f"Parsing {f.name} ...", end=" ", flush=True)
        try:
            d = parse_dungeon_file(f, locale)
            if d:
                dungeons.append(d)
                print(f"OK  {d.get('name', '?')}  ({len(d['sections'])} sections)")
            else:
                print("skip (pas de guideData)")
        except Exception as exc:
            print(f"ERREUR : {exc}")

    print(f"\nGeneration HTML pour {len(dungeons)} donjons ...")
    nav_parts, content_parts = [], []
    for i, d in enumerate(dungeons):
        nav, div = build_dungeon_html(d, i, png_stems)
        nav_parts.append(nav)
        content_parts.append(div)

    html = _PAGE.format(
        nav="\n  ".join(nav_parts),
        content="\n  ".join(content_parts),
    )
    out = Path(output_path)
    out.write_text(html, encoding="utf-8")
    print(f"Fichier genere : {out.resolve()}")


if __name__ == "__main__":
    main()
