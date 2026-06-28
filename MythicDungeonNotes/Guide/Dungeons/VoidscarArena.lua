local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Voidscar Arena (VA) — Midnight S2 (new)
-- uiMapIds: 2572, 2573, 2574
-- challengeMapID: 585 | spellportalid: 1286804 (Path of the Brutal Combatant)
-- IDs from 12.1 PTR (build 12.1.0.68301) — verify @ S2 launch.
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
    spellportalid = 1286804,   -- 12.1 PTR, verify @ launch
    challengeMapID = 585,
    mapIds    = { 2572, 2573, 2574 },
    sections  = {
        { name = L["COMMON_intro_label"], icon = "interface/lfgframe/ui-lfg-background-domanaararena", instanceID = 1313 },   -- dungeon lore (EJ)
        -- Boss name / portrait / lore intro come live from the Encounter Journal
        -- (encounterID). Replace each placeholder with curated mechanics.
        { encounterID = 2791, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Taz'Rah
        { encounterID = 2792, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Atroxus
        { encounterID = 2793, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Charonus
    },
}
