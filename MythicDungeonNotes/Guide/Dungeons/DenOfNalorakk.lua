local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Den of Nalorakk (DN) — Midnight S2
-- uiMapIds: 2513 (main), 2514 (sub-zone)
-- Bosses: The Hoardmonger, Sentinel of Winter, Nalorakk
-------------------------------------------------------------------------------

-- HTML helpers
local function h1(s) return "<h1>" .. s .. "</h1>" end
local function p(s)  return "<p>"  .. s .. "</p>"  end
local function fmt(key, ...) return string.format(L[key], ...) end

ns.guideData[#ns.guideData + 1] = {
    id        = "DN",
    name      = L["DN_name"],
    shortName = "DN",
    groups    = { "S2" },
    icon       = "interface/lfgframe/lfgicon-proveyourworth",
    background = "interface/encounterjournal/ui-ej-background-proveyourworth",
    vignette   = "interface/lfgframe/ui-lfg-background-proveyourworth",
    mapIds    = { 2513, 2514 },
    sections  = {
        -- ── Introduction ──────────────────────────────────────────────────
        {
            name = L["DN_intro_label"],
            icon = "interface/lfgframe/ui-lfg-background-proveyourworth",
            htmlContent = table.concat({
                p(L["DN_intro_desc1"]),
                p(L["DN_intro_desc2"]),
            }),
        },
        -- ── Warding Incense (entrée) ──────────────────────────────────────
        {
            name = L["DN_incense_label"],
            htmlContent =
                "<p>" .. L["DN_incense_desc"] .. "</p><br/>" ..
                "<img src='Interface/Addons/" .. myname .. "/Guide/Dungeons/Images/DN_incense' width='400' height='300'/>" ..
                "<br/><br/>" ..
                "<p>" .. L["DN_buff_alchemy_desc"] .. "</p><br/>"
        },
        -- ── Trash notable ─────────────────────────────────────────────────
        {
            name = L["COMMON_notable_trash"],
            icon = "interface/lfgframe/ui-lfg-background-randomscenario",
            htmlContent = table.concat({
                p(L["DN_trash_todo"]),
            }),
        },
        -- ── Boss 1 : The Hoardmonger ──────────────────────────────────────
        {
            name = L["DN_boss1"],
            -- icon: TODO (not yet in datamined assets)
            htmlContent = table.concat({
                h1(L["DN_boss1"]),
                p(fmt("DN_boss1_desc1", ns.Spell(1235072))),
                p(fmt("DN_boss1_desc2", ns.Spell(1234233), ns.Spell(1234846))),
                p(fmt("DN_boss1_desc3", ns.Spell(1234021))),
                p(fmt("DN_boss1_desc4", ns.Spell(1234681))),
                "<br/>",
                p(fmt("DN_boss1_desc5", ns.Spell(1235105), ns.Spell(1235129), ns.Spell(1235125))),
            }),
        },
        -- ── Boss 2 : Sentinel of Winter ───────────────────────────────────
        {
            name = L["DN_boss2"],
            -- icon: TODO (not yet in datamined assets)
            htmlContent = table.concat({
                h1(L["DN_boss2"]),
                p(fmt("DN_boss2_desc1", ns.Spell(1235783))),
                p(fmt("DN_boss2_desc2", ns.Spell(1235829))),
                p(fmt("DN_boss2_desc3", ns.Spell(1235623))),
                p(fmt("DN_boss2_desc4", ns.Spell(1235548))),
                p(fmt("DN_boss2_desc5", ns.Spell(1235656))),
                p(fmt("DN_boss2_desc6", ns.Spell(1234314))),
                "<br/>",
                p(fmt("DN_boss2_desc7", ns.Spell(1263590), ns.Spell(1263597))),
            }),
        },
        -- ── Boss 3 : Nalorakk ─────────────────────────────────────────────
        {
            name = L["DN_boss3"],
            icon = "interface/encounterjournal/ui-ej-boss-nalorakk",
            htmlContent = table.concat({
                h1(L["DN_boss3"]),
                p(L["DN_boss3_intro"]),
                p(fmt("DN_boss3_desc1", ns.Spell(1243002), ns.Spell(1243063), ns.Spell(1262063))),
                p(fmt("DN_boss3_desc2", ns.Spell(1242860))),
                p(fmt("DN_boss3_desc3", ns.Spell(1255385))),
                p(fmt("DN_boss3_desc4", ns.Spell(1243590), ns.Spell(1261776))),
                "<br/>",
                p(fmt("DN_boss3_desc5", ns.Spell(1255577))),
            }),
        },
    },
}
