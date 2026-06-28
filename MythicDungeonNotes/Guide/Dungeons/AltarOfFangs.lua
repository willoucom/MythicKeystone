local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Altar of Fangs (AF) — Midnight S2
-- uiMapIds: 2588, 2589, 2590
-- challengeMapID: 588 | spellportalid: 1286812 (Path of Venomous Evolution)
-- IDs from 12.1 PTR (build 12.1.0.68301) — verify @ S2 launch.
-- Bosses: TODO
-------------------------------------------------------------------------------

ns.guideData[#ns.guideData + 1] = {
    id        = "AF",
    name      = L["AF_name"],
    shortName = "AF",
    groups    = { "S2" },
    icon       = "interface/lfgframe/lfgicon-dungeonaltaroffangs",
    background = "interface/encounterjournal/ui-ej-background-dungeonaltaroffangs",
    vignette   = "interface/lfgframe/ui-lfg-background-dungeonaltaroffangs",
    spellportalid = 1286812,   -- 12.1 PTR, verify @ launch
    challengeMapID = 588,
    mapIds    = { 2588, 2589, 2590 },
    sections  = {
        { name = L["COMMON_intro_label"], icon = "interface/lfgframe/ui-lfg-background-dungeonaltaroffangs", instanceID = 1322 },   -- dungeon lore (EJ)
        -- Boss name / portrait / lore intro come live from the Encounter Journal
        -- (encounterID). Replace each placeholder with curated mechanics.
        { encounterID = 2878, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Rav'i
        { encounterID = 2879, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- The Writhing Coil
        { encounterID = 2880, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Zul'jan
    },
}
