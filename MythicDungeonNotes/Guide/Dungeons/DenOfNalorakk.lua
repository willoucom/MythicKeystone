local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Den of Nalorakk (DN) — Midnight S1 New
-- uiMapIds: 2513 (main), 2514 (sub-zone)
-- Bosses: TODO
-------------------------------------------------------------------------------

ns.guideData[#ns.guideData + 1] = {
    id        = "DN",
    name      = L["DN_name"],
    shortName = "DN",
    groups =    {"S2"},
    icon = "interface/lfgframe/lfgicon-proveyourworth",
    background = "interface/encounterjournal/ui-ej-background-proveyourworth",
    vignette = "interface/lfgframe/ui-lfg-background-proveyourworth",
    mapIds    = { 2513, 2514 },
    sections  = {
        -- ── Introduction ──────────────────────────────────────────────────
        {
            name = L["DN_intro_label"],
            htmlContent = "<p>" .. L["DN_intro_desc"] .. "</p>",
        },
        {
            name = L["DN_incense_label"],
            htmlContent =
                "<p>" .. L["DN_incense_desc"] .. "</p><br/>" ..
                "<img src='Interface/Addons/" .. myname .. "/Guide/Dungeons/Images/DN_incense' width='400' height='300'/>" ..
                "<br/><br/>" ..
                "<p>" .. L["DN_buff_alchemy_desc"] .. "</p><br/>"
        },
    },
}
