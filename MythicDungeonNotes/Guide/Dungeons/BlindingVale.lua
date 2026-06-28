local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- The Blinding Vale (BV) — Midnight S2 (new)
-- uiMapId: 2500
-- challengeMapID: 584 | spellportalid: 1286801 (Path of the Blooming Verdure)
-- IDs from 12.1 PTR (build 12.1.0.68301) — verify @ S2 launch.
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
    spellportalid = 1286801,   -- 12.1 PTR, verify @ launch
    challengeMapID = 584,
    mapIds    = { 2500 },
    sections  = {
        { name = L["COMMON_intro_label"], icon = "interface/lfgframe/ui-lfg-background-lightbloom", instanceID = 1309 },   -- dungeon lore (EJ)
        -- Boss name / portrait / lore intro come live from the Encounter Journal
        -- (encounterID). Replace each placeholder with curated mechanics.
        { encounterID = 2769, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Lightblossom Trinity
        { encounterID = 2770, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Ikuzz the Light Hunter
        { encounterID = 2771, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Lightwarden Ruia
        { encounterID = 2772, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Ziekket
    },
}
