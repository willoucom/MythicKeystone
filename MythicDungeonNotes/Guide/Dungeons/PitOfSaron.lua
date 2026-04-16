local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Pit of Saron (PoS) — Midnight S1 Legacy
-- uiMapId: 184
-- Bosses: Forgemaster Garfrost, Ick & Krick, Scourgelord Tyrannus
-------------------------------------------------------------------------------

-- HTML helpers
local function h1(s) return "<h1>" .. s:gsub("&", "&amp;") .. "</h1>" end
local function p(s)  return "<p>"  .. s .. "</p>"  end
local function fmt(key, ...) return string.format(L[key], ...) end

ns.guideData[#ns.guideData + 1] = {
    id        = "POS",
    name      = L["POS_name"],
    shortName = "PoS",
    groups = {"WOTLK","S1"},
    mapIds    = { 184 },
    icon = "interface/lfgframe/lfgicon-pitofsaron",
    background = "interface/encounterjournal/ui-ej-background-pitofsaron",
    vignette = "interface/lfgframe/ui-lfg-background-pitofsaron",
    spellportalid = 1254555,
    sections  = {
        -- ── Introduction ──────────────────────────────────────────────────
        {
            name = L["COMMON_intro_label"],
            htmlContent = table.concat({
                p(L["POS_intro_desc1"]),
                p(L["POS_intro_desc2"]),
                p(L["POS_intro_desc3"]),
            }),
        },
        -- ── Trash notable ─────────────────────────────────────────────────
        {
            name = L["COMMON_notable_trash"],
            htmlContent = table.concat({
                h1(L["POS_trash1_name"]),
                p(fmt("POS_trash1_desc1", ns.Spell(1271074), ns.Spell(1258798), ns.Spell(1258826))),
                h1(L["POS_trash2_name"]),
                p(fmt("POS_trash2_desc1", ns.Spell(1277258), ns.Spell(1258448))),
                h1(L["POS_trash3_name"]),
                p(fmt("POS_trash3_desc1", ns.Spell(1271479))),
                h1(L["POS_trash4_name"]),
                p(fmt("POS_trash4_desc1", ns.Spell(1259132), ns.Spell(1259116))),
                h1(L["POS_trash5_name"]),
                p(fmt("POS_trash5_desc1", ns.Spell(1258436), ns.Spell(1258437))),
                h1(L["POS_trash6_name"]),
                p(fmt("POS_trash6_desc1", ns.Spell(1259187), ns.Spell(1259226))),
                h1(L["POS_trash7_name"]),
                p(fmt("POS_trash7_desc1", ns.Spell(1258434), ns.Spell(1258435))),
            }),
        },
        -- ── Boss 1 : Forgemaster Garfrost ─────────────────────────────────
        {
            name = L["POS_boss1_name"],
            htmlContent = table.concat({
                h1(L["POS_boss1_name"]),
                p(fmt("POS_boss1_desc1", ns.Spell(1261299))),
                p(fmt("POS_boss1_desc2", ns.Spell(1261546))),
                p(fmt("POS_boss1_desc3", ns.Spell(1262029))),
                p(fmt("POS_boss1_desc4", ns.Spell(1261847), ns.Spell(1261806))),
            }),
        },
        -- ── Boss 2 : Ick &amp; Krick ──────────────────────────────────────
        {
            name = L["POS_boss2_name"],
            htmlContent = table.concat({
                h1(L["POS_boss2_name"]),
                p(fmt("POS_boss2_desc1", ns.Spell(1264192))),
                p(fmt("POS_boss2_desc2", ns.Spell(1264027), ns.Spell(1264186))),
                p(fmt("POS_boss2_desc3", ns.Spell(1278893), ns.Spell(1264287))),
                p(fmt("POS_boss2_desc4", ns.Spell(1264336), ns.Spell(1264363))),
            }),
        },
        -- ── Boss 3 : Scourgelord Tyrannus ─────────────────────────────────
        {
            name = L["POS_boss3_name"],
            htmlContent = table.concat({
                h1(L["POS_boss3_name"]),
                p(fmt("POS_boss3_desc1", ns.Spell(1262582), ns.Spell(1263756), ns.Spell(1276948))),
                p(fmt("POS_boss3_desc2", ns.Spell(1263406), ns.Spell(1276357), ns.Spell(1262929), ns.Spell(1262941), ns.Spell(1262745))),
            }),
        },
    },
}
