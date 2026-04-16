local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Skyreach (SKY) — Midnight S1 Legacy
-- uiMapIds: 601 (main), 602 (upper)
-- Bosses: Ranjit, Araknath, Rukhran, High Sage Viryx
-------------------------------------------------------------------------------

-- HTML helpers
local function h1(s) return "<h1>" .. s .. "</h1>" end
local function p(s)  return "<p>"  .. s .. "</p>"  end
local function fmt(key, ...) return string.format(L[key], ...) end

ns.guideData[#ns.guideData + 1] = {
    id        = "SKY",
    name      = L["SKY_name"],
    shortName = "SKY",
    groups = {"CAT","S1"},
    mapIds    = { 601, 602 },
    icon = "interface/lfgframe/lfgicon-skyreach",
    background = "interface/lfgframe/ui-lfg-background-skyreach",
    vignette = "interface/lfgframe/ui-lfg-background-skyreach",
    spellportalid = 159898,
    sections  = {
        -- ── Introduction ──────────────────────────────────────────────────
        {
            name = L["COMMON_intro_label"],
            htmlContent = table.concat({
                p(L["SKY_intro_desc1"]),
                p(L["SKY_intro_desc2"]),
            }),
        },
        -- ── Trash notable ─────────────────────────────────────────────────
        {
            name = L["COMMON_notable_trash"],
            htmlContent = table.concat({
                h1(L["SKY_trash1_name"]),
                p(fmt("SKY_trash1_desc1", ns.Spell(1254666))),
                h1(L["SKY_trash2_name"]),
                p(fmt("SKY_trash2_desc1", ns.Spell(152953), ns.Spell(1273356))),
                h1(L["SKY_trash3_name"]),
                p(fmt("SKY_trash3_desc1", ns.Spell(1254475), ns.Spell(1254380))),
                h1(L["SKY_trash4_name"]),
                p(fmt("SKY_trash4_desc1", ns.Spell(1255377))),
                h1(L["SKY_trash5_name"]),
                p(fmt("SKY_trash5_desc1", ns.Spell(1254329), ns.Spell(1258217))),
                h1(L["SKY_trash6_name"]),
                p(fmt("SKY_trash6_desc1", ns.Spell(1258174), ns.Spell(1254566))),
            }),
        },
        -- ── Boss 1 : Ranjit ───────────────────────────────────────────────
        {
            name = L["SKY_boss1_name"],
            htmlContent = table.concat({
                h1(L["SKY_boss1_name"]),
                p(fmt("SKY_boss1_desc1", ns.Spell(1252690), ns.Spell(156793))),
                p(fmt("SKY_boss1_desc2", ns.Spell(153757), ns.Spell(1258152))),
            }),
        },
        -- ── Boss 2 : Araknath ─────────────────────────────────────────────
        {
            name = L["SKY_boss2_name"],
            htmlContent = table.concat({
                h1(L["SKY_boss2_name"]),
                p(fmt("SKY_boss2_desc1", ns.Spell(154139), ns.Spell(154135))),
                p(fmt("SKY_boss2_desc2", ns.Spell(1279002), ns.Spell(1283770), ns.Spell(154110))),
            }),
        },
        -- ── Boss 3 : Rukhran ──────────────────────────────────────────────
        {
            name = L["SKY_boss3_name"],
            htmlContent = table.concat({
                h1(L["SKY_boss3_name"]),
                p(fmt("SKY_boss3_desc1", ns.Spell(1253510), ns.Spell(1253511))),
                p(fmt("SKY_boss3_desc2", ns.Spell(159381), ns.Spell(1253519), ns.Spell(153898))),
            }),
        },
        -- ── Boss 4 : High Sage Viryx ──────────────────────────────────────
        {
            name = L["SKY_boss4_name"],
            htmlContent = table.concat({
                h1(L["SKY_boss4_name"]),
                p(fmt("SKY_boss4_desc1", ns.Spell(154396), ns.Spell(1253543))),
                p(fmt("SKY_boss4_desc2", ns.Spell(153954), ns.Spell(154044))),
            }),
        },
    },
}
