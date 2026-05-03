local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Algeth'ar Academy (AA) — Midnight S1 Legacy
-- uiMapId: 2097
-- Bosses: Overgrown Ancient, Crawth, Vexamus, Echo of Doragosa
-------------------------------------------------------------------------------

local ICON_BRONZE = "|TInterface/Icons/INV_Misc_Head_Dragon_Bronze:20:20|t"
local ICON_RED    = "|TInterface/Icons/INV_Misc_Head_Dragon_Red:20:20|t"
local ICON_GREEN  = "|TInterface/Icons/INV_Misc_Head_Dragon_Green:20:20|t"
local ICON_BLUE   = "|TInterface/Icons/INV_Misc_Head_Dragon_Blue:20:20|t"
local ICON_BLACK  = "|TInterface/Icons/INV_Misc_Head_Dragon_Black:20:20|t"

-- HTML helpers
local function h1(s) return "<h1>" .. s .. "</h1>" end
local function p(s)  return "<p>"  .. s .. "</p>"  end
local function fmt(key, ...) return string.format(L[key], ...) end

ns.guideData[#ns.guideData + 1] = {
    id        = "AA",
    name      = L["AA_name"],
    shortName = "AA",
    groups    = { "DF", "S1" },
    icon      = "interface/lfgframe/lfgicon-theacademy",
    background = "interface/encounterjournal/ui-ej-background-theacademy",
    vignette   = "interface/lfgframe/ui-lfg-background-theacademy",
    spellportalid = 393273,
    mapIds    = { 2097 },
    sections  = {
        -- ── Entrée ─────────────────────────────────────────────────────────
        {
            name = L["AA_entrance_label"],
            htmlContent = table.concat({
                p(L["AA_entrance_intro"]),
                p(L["AA_entrance_bosses"]),
                p(L["AA_entrance_desc"]),
                "<img src='Interface/Addons/" .. myname .. "/Guide/Dungeons/Images/AA_map' width='500' height='300'/>",
                p("|cffCD9B3A• |r" .. ICON_BRONZE .. " |cffCD9B3A" .. L["AA_bronze_drake_desc"] .. "|r — " .. L["AA_bronze_drake"] .. " — " .. ns.Spell(389512)),
                p("|cffFF4444• |r" .. ICON_RED    .. " |cffFF4444" .. L["AA_red_drake_desc"]    .. "|r — " .. L["AA_red_drake"]    .. " — " .. ns.Spell(389501)),
                p("|cff44FF44• |r" .. ICON_GREEN  .. " |cff44FF44" .. L["AA_green_drake_desc"]  .. "|r — " .. L["AA_green_drake"]  .. " — " .. ns.Spell(389536)),
                p("|cff6699FF• |r" .. ICON_BLUE   .. " |cff6699FF" .. L["AA_blue_drake_desc"]   .. "|r — " .. L["AA_blue_drake"]   .. " — " .. ns.Spell(389521)),
                p("|cffAAAAAA• |r" .. ICON_BLACK  .. " |cffAAAAAA" .. L["AA_black_drake_desc"]  .. "|r — " .. L["AA_black_drake"]  .. " — " .. ns.Spell(389516)),
            }),
        },
        -- ── Trash ──────────────────────────────────────────────────────────
        {
            name = L["AA_trash_label"],
            htmlContent = table.concat({
                h1(L["AA_trash1_mob1_name"]),
                p(L["COMMON_cc_immune"]),
                p(fmt("AA_trash1_mob1_desc1", ns.Spell(1282244))),
                p(fmt("AA_trash1_mob1_desc2", ns.Spell(390918))),
                h1(L["AA_trash1_mob2_name"]),
                p(L["AA_trash1_mob2_desc1"]),
                p(L["AA_trash1_mob2_desc2"]),
                p(fmt("AA_trash1_mob2_desc3", ns.Spell(390938))),
                p(fmt("AA_trash1_mob2_desc4", ns.Spell(390944))),
                h1(L["AA_trash2_mob1_name"]),
                p(L["COMMON_cc_immune"]),
                p(fmt("AA_trash2_mob1_desc1", ns.Spell(377991))),
                p(fmt("AA_trash2_mob1_desc2", ns.Spell(378011))),
                p(fmt("AA_trash2_mob1_desc3", ns.Spell(377912))),
                h1(L["AA_trash2_mob2_name"]),
                p(L["COMMON_cc_immune"]),
                p(fmt("AA_trash2_mob2_desc1", ns.Spell(377383))),
                h1(L["AA_trash3_mob1_name"]),
                p(fmt("AA_trash3_mob1_desc1", ns.Spell(388862))),
                p(fmt("AA_trash3_mob1_desc2", ns.Spell(388863))),
                h1(L["AA_trash3_mob2_name"]),
                p(fmt("AA_trash3_mob2_desc1", ns.Spell(388841))),
                h1(L["AA_trash3_mob3_name"]),
                p(fmt("AA_trash3_mob3_desc1", ns.Spell(388940))),
                p(fmt("AA_trash3_mob3_desc2", ns.Spell(388976))),
                h1(L["AA_trash3_mob4_name"]),
                p(fmt("AA_trash3_mob4_desc1", ns.Spell(389054))),
                h1(L["AA_trash3_mob5_name"]),
                p(fmt("AA_trash3_mob5_desc1", ns.Spell(388392))),
                h1(L["AA_trash4_mob1_name"]),
                p(fmt("AA_trash4_mob1_desc1", ns.Spell(1270349))),
                p(fmt("AA_trash4_mob1_desc2", ns.Spell(1270356))),
                h1(L["AA_trash4_mob2_name"]),
                p(fmt("AA_trash4_mob2_desc1", ns.Spell(1270294))),
                p(fmt("AA_trash4_mob2_desc2", ns.Spell(1279627))),
            }),
        },
        -- ── Boss 1 : Overgrown Ancient ─────────────────────────────────────
        {
            name = L["AA_boss1"],
            htmlContent = table.concat({
                h1(L["AA_boss1_name"]),
                p(L["AA_boss1_desc0"]),
                p(fmt("AA_boss1_desc1", ns.Spell(388796))),
                p(fmt("AA_boss1_desc2", ns.Spell(388625))),
                h1(L["AA_boss1_branch_name"]),
                p(fmt("AA_boss1_desc3", ns.Spell(396640))),
                p(fmt("AA_boss1_desc4", ns.Spell(396721), ns.Spell(396716))),
            }),
        },
        -- ── Boss 2 : Crawth ────────────────────────────────────────────────
        {
            name = L["AA_boss2"],
            htmlContent = table.concat({
                h1(L["AA_boss2_name"]),
                p(fmt("AA_boss2_desc0",  ns.Spell(376997))),
                p(L["AA_boss2_desc0b"]),
                p(fmt("AA_boss2_desc1",  ns.Spell(377004))),
                p(L["AA_boss2_desc2"]),
            }),
        },
        -- ── Boss 3 : Vexamus ───────────────────────────────────────────────
        {
            name = L["AA_boss3"],
            htmlContent = table.concat({
                h1(L["AA_boss3_name"]),
                p(fmt("AA_boss3_desc1", ns.Spell(387691))),
                p(fmt("AA_boss3_desc0", ns.Spell(385958))),
                p(fmt("AA_boss3_desc2", ns.Spell(388537))),
            }),
        },
        -- ── Boss 4 : Echo of Doragosa ──────────────────────────────────────
        {
            name = L["AA_boss4"],
            htmlContent = table.concat({
                h1(L["AA_boss4_name"]),
                p(L["AA_boss4_desc0"]),
                p(fmt("AA_boss4_desc1", ns.Spell(439488))),
                "<br/>",
                p(fmt("AA_boss4_desc2", ns.Spell(389011), ns.Spell(388901))),
                p(fmt("AA_boss4_desc3", ns.Spell(388901), ns.Spell(388951))),
                p(fmt("AA_boss4_desc4", ns.Spell(374352), ns.Spell(373326))),
                p(fmt("AA_boss4_desc5", ns.Spell(388822))),
            }),
        },
    },
}
