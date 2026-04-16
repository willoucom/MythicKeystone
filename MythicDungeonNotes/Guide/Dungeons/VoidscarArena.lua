local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- The Blinding Vale (BV) — Midnight S1 New
-- uiMapId: 2500
-- Bosses: TODO
-------------------------------------------------------------------------------

ns.guideData[#ns.guideData + 1] = {
    id        = "VA",
    name      = L["VA_name"],
    shortName = "VA",
    groups = {"S2"},
    icon = "interface/lfgframe/lfgicon-domanaararena",
    background = "interface/encounterjournal/ui-ej-background-domanaararena",
    vignette = "interface/lfgframe/ui-lfg-background-domanaararena",
    mapIds    = { 2500 },
    sections  = {
        -- TODO
    },
}
