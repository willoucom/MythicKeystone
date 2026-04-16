local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- The Blinding Vale (BV) — Midnight S1 New
-- uiMapId: 2500
-- Bosses: TODO
-------------------------------------------------------------------------------

ns.guideData[#ns.guideData + 1] = {
    id        = "BV",
    name      = L["BV_name"],
    shortName = "BV",
    groups = {"S2"},
    icon = "interface/lfgframe/lfgicon-lightbloom",
    background = "interface/encounterjournal/ui-ej-background-lightbloom",
    vignette = "interface/lfgframe/ui-lfg-background-lightbloom",
    mapIds    = { 2500 },
    sections  = {
        -- TODO
    },
}
