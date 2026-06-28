local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Ruby Life Pools (RLP) — Legacy (Dragonflight), S2
-- uiMapIds: 2094, 2095
-- challengeMapID: 399 | spellportalid: 393256 (Path of the Clutch Defender)
-- NB: reuses the original Dragonflight teleport spell (no new S2 spell minted).
-- challengeMapID/uiMapIds from 12.1 PTR (build 12.1.0.68301) — verify @ S2 launch.
-- Bosses: TODO
-------------------------------------------------------------------------------

ns.guideData[#ns.guideData + 1] = {
    id        = "RLP",
    name      = L["RLP_name"],
    shortName = "RLP",
    groups    = { "DF", "S2" },
    icon       = "interface/lfgframe/lfgicon-lifepools",            -- internal codename "lifepools"
    background = "interface/encounterjournal/ui-ej-background-lifepools",
    vignette   = "interface/lfgframe/ui-lfg-background-lifepools",
    spellportalid = 393256,   -- reuses Dragonflight spell
    challengeMapID = 399,
    mapIds    = { 2094, 2095 },
    sections  = {
        { name = L["COMMON_intro_label"], icon = "interface/lfgframe/ui-lfg-background-lifepools", instanceID = 1202 },   -- dungeon lore (EJ)
        -- Boss name / portrait / lore intro come live from the Encounter Journal
        -- (encounterID). Replace each placeholder with curated mechanics.
        { encounterID = 2488, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Melidrussa Chillworn
        { encounterID = 2485, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Kokia Blazehoof
        { encounterID = 2503, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Kyrakka and Erkhart Stormvein
    },
}
