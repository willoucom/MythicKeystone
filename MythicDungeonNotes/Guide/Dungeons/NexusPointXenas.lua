local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Nexus-Point Xenas (NPX) — Midnight S1 New
-- uiMapId: 2556
-- Bosses: Chief Corewright Kasreth, Corewarden Nysarra, Lothraxion
-------------------------------------------------------------------------------

-- HTML helpers
local function h1(s) return "<h1>" .. s .. "</h1>" end
local function p(s)  return "<p>"  .. s .. "</p>"  end
local function fmt(key, ...) return string.format(L[key], ...) end

ns.guideData[#ns.guideData + 1] = {
    id        = "NPX",
    name      = L["NPX_name"],
    shortName = "NPX",
    icon = "interface/lfgframe/lfgicon-nexuspointxenas",
    background = "interface/encounterjournal/ui-ej-background-nexuspointxenas",
    vignette = "interface/lfgframe/ui-lfg-background-nexuspointxenas",
    spellportalid = 1254563,
    groups = {"S1"},
    mapIds    = { 2556 },
    sections  = {
        -- ── Introduction ──────────────────────────────────────────────────
        {
            name = L["COMMON_intro_label"],
            htmlContent = table.concat({
                p(L["NPX_intro_desc1"]),
                p(L["NPX_intro_desc2"]),
            }),
        },
        -- ── Trash notable ─────────────────────────────────────────────────
        {
            name = L["COMMON_notable_trash"],
            htmlContent = table.concat({
                h1(L["NPX_trash_arcanist_name"]),
                p(fmt("NPX_trash_arcanist_desc1", ns.Spell(1285445), ns.Spell(1249815))),
                h1(L["NPX_trash_engineer_name"]),
                p(fmt("NPX_trash_engineer_desc1", ns.Spell(249081))),
                h1(L["NPX_trash_seer_name"]),
                p(fmt("NPX_trash_seer_desc1", ns.Spell(1249801), ns.Spell(1257100))),
                h1(L["NPX_trash_scrounger_name"]),
                p(fmt("NPX_trash_scrounger_desc1", ns.Spell(1252204))),
                h1(L["NPX_trash_nullifier_name"]),
                p(fmt("NPX_trash_nullifier_desc1", ns.Spell(1282722), ns.Spell(1282723))),
                h1(L["NPX_trash_dreadflail_name"]),
                p(fmt("NPX_trash_dreadflail_desc1", ns.Spell(1282665), ns.Spell(1282679))),
                h1(L["NPX_trash_lightwrought_name"]),
                p(fmt("NPX_trash_lightwrought_desc1", ns.Spell(1263892), ns.Spell(1277557))),
                h1(L["NPX_trash_voidcaller_name"]),
                p(fmt("NPX_trash_voidcaller_desc1", ns.Spell(1281636))),
            }),
        },
        -- ── Boss 1 : Chief Corewright Kasreth ─────────────────────────────
        {
            name = L["NPX_boss1_name"],
            htmlContent = table.concat({
                h1(L["NPX_boss1_name"]),
                p(fmt("NPX_boss1_desc1", ns.Spell(1251579), ns.Spell(1251772))),
                p(fmt("NPX_boss1_desc2", ns.Spell(1262088))),
                p(fmt("NPX_boss1_desc3", ns.Spell(1257509))),
                p(fmt("NPX_boss1_desc4", ns.Spell(1250553))),
            }),
        },
        -- ── Boss 2 : Corewarden Nysarra ───────────────────────────────────
        {
            name = L["NPX_boss2_name"],
            htmlContent = table.concat({
                h1(L["NPX_boss2_name"]),
                p(fmt("NPX_boss2_desc1", ns.Spell(1249014))),
                p(fmt("NPX_boss2_desc2", ns.Spell(1252703), ns.Spell(1252883))),
                p(fmt("NPX_boss2_desc3", ns.Spell(1247937))),
                p(fmt("NPX_boss2_desc4", ns.Spell(1247976))),
            }),
        },
        -- ── Boss 3 : Lothraxion ───────────────────────────────────────────
        {
            name = L["NPX_boss3_name"],
            htmlContent = table.concat({
                h1(L["NPX_boss3_name"]),
                p(fmt("NPX_boss3_desc1", ns.Spell(1253950))),
                p(fmt("NPX_boss3_desc2", ns.Spell(1253855))),
                p(fmt("NPX_boss3_desc3", ns.Spell(1255531))),
                p(fmt("NPX_boss3_desc4", ns.Spell(1257595), ns.Spell(1271956), ns.Spell(1271511))),
            }),
        },
    },
}
