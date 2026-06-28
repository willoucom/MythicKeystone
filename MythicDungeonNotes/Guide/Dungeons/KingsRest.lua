local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Kings' Rest (KR) — Legacy (Battle for Azeroth), S2
-- uiMapId: 1004
-- challengeMapID: 249 | spellportalid: 1286831 (Path of the Slumbering Conqueror)
-- NB: Midnight S2 mints a NEW teleport spell — does NOT reuse BfA 272261.
-- IDs from 12.1 PTR (build 12.1.0.68301) — verify @ S2 launch.
-- Bosses: TODO
-------------------------------------------------------------------------------

ns.guideData[#ns.guideData + 1] = {
    id        = "KR",
    name      = L["KR_name"],
    shortName = "KR",
    groups    = { "BFA", "S2" },
    icon       = "interface/lfgframe/lfgicon-kingsrest",
    background = "interface/encounterjournal/ui-ej-background-kingsrest",
    vignette   = "interface/lfgframe/ui-lfg-background-kingsrest",
    spellportalid = 1286831,   -- 12.1 PTR, verify @ launch (NEW spell, not BfA 272261)
    challengeMapID = 249,
    mapIds    = { 1004 },
    sections  = {
        { name = L["COMMON_intro_label"], icon = "interface/lfgframe/ui-lfg-background-kingsrest", instanceID = 1041 },   -- dungeon lore (EJ)
        -- Boss name / portrait / lore intro come live from the Encounter Journal
        -- (encounterID). Replace each placeholder with curated mechanics.
        { encounterID = 2165, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- The Golden Serpent
        { encounterID = 2171, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Mchimba the Embalmer
        { encounterID = 2170, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- The Council of Tribes
        { encounterID = 2172, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Dazar, The First King
    },
}
