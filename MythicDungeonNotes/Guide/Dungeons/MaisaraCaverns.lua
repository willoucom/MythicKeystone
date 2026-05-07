local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Maisara Caverns (MC) — Midnight S1 New
-- uiMapId: 2501
-- Bosses: Muro'jin & Nekraxx, Vordaza, Rak'tul (Vessel of Souls)
-------------------------------------------------------------------------------

-- HTML helpers
local function h1(s) return "<h1>" .. s:gsub("&", "&amp;") .. "</h1>" end
local function p(s)  return "<p>"  .. s .. "</p>"  end
local function fmt(key, ...) return string.format(L[key], ...) end

ns.guideData[#ns.guideData + 1] = {
    id        = "MC",
    name      = L["MC_name"],
    shortName = "MC",
    groups = {"S1"},
    icon = "interface/lfgframe/lfgicon-maisarahills",
    background = "interface/encounterjournal/ui-ej-background-maisarahills",
    vignette = "interface/lfgframe/ui-lfg-background-maisarahills",
    spellportalid = 1254559,
    mapIds    = { 2501 },
    sections  = {
        -- ── Introduction ──────────────────────────────────────────────────
        {
            name = L["COMMON_intro_label"],
            htmlContent = table.concat({
                p(L["MC_intro_desc1"]),
                p(L["MC_intro_desc2"]),
            }),
        },
        -- ── Trash notable ─────────────────────────────────────────────────
        {
            name = L["COMMON_notable_trash"],
            htmlContent = table.concat({
                h1(L["MC_trash_berserker_name"]),
                p(fmt("MC_trash_berserker_desc1", ns.Spell(1255765), ns.Spell(1255966))),
                p(fmt("MC_trash_berserker_desc2", ns.Spell(1266381), ns.Spell(1255964))),
                h1(L["MC_trash_juggernaut_name"]),
                p(fmt("MC_trash_juggernaut_desc1", ns.Spell(1256047), ns.Spell(1256059))),
                h1(L["MC_trash_hexxer_name"]),
                p(fmt("MC_trash_hexxer_desc1", ns.Spell(1256008), ns.Spell(1256015))),
                h1(L["MC_trash_guardian_name"]),
                p(fmt("MC_trash_guardian_desc1", ns.Spell(1258481), ns.Spell(1258806), ns.Spell(1258475))),
                h1(L["MC_trash_skirmisher_name"]),
                p(fmt("MC_trash_skirmisher_desc1", ns.Spell(1270079))),
                h1(L["MC_trash_soulrender_name"]),
                p(fmt("MC_trash_soulrender_desc1", ns.Spell(1259677), ns.Spell(1264327), ns.Spell(1271623))),
                h1(L["MC_trash_defender_name"]),
                p(fmt("MC_trash_defender_desc1", ns.Spell(1259270), ns.Spell(1259651), ns.Spell(269928))),
                h1(L["MC_trash_shade_name"]),
                p(fmt("MC_trash_shade_desc1", ns.Spell(1259255))),
            }),
        },
        -- ── Boss 1 : Muro'jin & Nekraxx ───────────────────────────────────
        {
            name = L["MC_boss1_name"],
            htmlContent = table.concat({
                h1(L["MC_boss1_name"]),
                p(fmt("MC_boss1_desc1", ns.Spell(1249948), ns.Spell(1249789))),
                p(fmt("MC_boss1_desc2", ns.Spell(1249479), ns.Spell(1260731))),
                p(fmt("MC_boss1_desc3", ns.Spell(1266480))),
                p(fmt("MC_boss1_desc4", ns.Spell(1246666))),
                p(fmt("MC_boss1_desc5", ns.Spell(1243900))),
                p(fmt("MC_boss1_desc6", ns.Spell(1260643))),
            }),
        },
        -- ── Boss 2 : Vordaza ──────────────────────────────────────────────
        {
            name = L["MC_boss2_name"],
            htmlContent = table.concat({
                h1(L["MC_boss2_name"]),
                p(fmt("MC_boss2_desc1", ns.Spell(1251204))),
                p(fmt("MC_boss2_desc2", ns.Spell(1251554))),
                p(fmt("MC_boss2_desc3", ns.Spell(1252054))),
                p(fmt("MC_boss2_desc4", ns.Spell(1250708))),
            }),
        },
        -- ── Boss 3 : Rak'tul, Vessel of Souls ────────────────────────────
        {
            name = L["MC_boss3_name"],
            htmlContent = table.concat({
                h1(L["MC_boss3_name"]),
                p(fmt("MC_boss3_desc1", ns.Spell(1248863))),
                p(fmt("MC_boss3_desc2", ns.Spell(1251023))),
                p(fmt("MC_boss3_desc3", ns.Spell(1252676), ns.Spell(1252777))),
                p(fmt("MC_boss3_desc4", ns.Spell(1253788), ns.Spell(1255629), ns.Spell(1253844))),
                p(fmt("MC_boss3_desc5", ns.Spell(1259731))),
            }),
        },
    },
}
