local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Temple of Sethraliss (TOS) — Legacy (Battle for Azeroth), S2
-- uiMapIds: 1038, 1043
-- challengeMapID: 250 | spellportalid: 1286828 (Path of the Sacred Temple)
-- NB: Midnight S2 mints a NEW teleport spell — does NOT reuse BfA 272267.
-- IDs from 12.1 PTR (build 12.1.0.68301) — verify @ S2 launch.
-- Bosses: TODO
-------------------------------------------------------------------------------

ns.guideData[#ns.guideData + 1] = {
    id        = "TOS",
    name      = L["TOS_name"],
    shortName = "TOS",
    groups    = { "BFA", "S2" },
    icon       = "interface/lfgframe/lfgicon-templeofsethraliss",
    background = "interface/encounterjournal/ui-ej-background-templeofsethraliss",
    vignette   = "interface/lfgframe/ui-lfg-background-templeofsethraliss",
    spellportalid = 1286828,   -- 12.1 PTR, verify @ launch (NEW spell, not BfA 272267)
    challengeMapID = 250,
    mapIds    = { 1038, 1043 },
    sections  = {
        { name = L["COMMON_intro_label"], icon = "interface/lfgframe/ui-lfg-background-templeofsethraliss", instanceID = 1030 },   -- dungeon lore (EJ)
        -- Boss name / portrait / lore intro come live from the Encounter Journal
        -- (encounterID). Replace each placeholder with curated mechanics.
        { encounterID = 2142, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Adderis and Aspix
        { encounterID = 2143, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Merektha
        { encounterID = 2144, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Galvazzt
        { encounterID = 2145, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Avatar of Sethraliss
    },
}
