local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Murder Row (MR) — Midnight S2
-- uiMapId: TODO
-- Bosses: TODO
-------------------------------------------------------------------------------

ns.guideData[#ns.guideData + 1] = {
    id        = "MR",
    name      = L["MR_name"],
    shortName = "MR",
    groups = {"S2"},
    icon = "interface/lfgframe/lfgicon-murderrow",
    background = "interface/encounterjournal/ui-ej-background-murderrow",
    vignette = "interface/lfgframe/ui-lfg-background-murderrow",
    mapIds    = { 2500 },
    sections  = {
        -- TODO
    },
}
