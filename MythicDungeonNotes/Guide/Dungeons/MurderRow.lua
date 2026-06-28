local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Murder Row (MR) — Midnight S2 (new)
-- uiMapIds: 2433, 2434 (Augurs' Terrace), 2435 (The Illicit Rain)
-- challengeMapID: 587 | spellportalid: 1286809 (Path of the Devious Smuggler)
-- IDs from 12.1 PTR (build 12.1.0.68301) — verify @ S2 launch.
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
    spellportalid = 1286809,   -- 12.1 PTR, verify @ launch
    challengeMapID = 587,
    mapIds    = { 2433, 2434, 2435 },
    sections  = {
        { name = L["COMMON_intro_label"], icon = "interface/lfgframe/ui-lfg-background-murderrow", instanceID = 1304 },   -- dungeon lore (EJ)
        -- Boss name / portrait / lore intro come live from the Encounter Journal
        -- (encounterID). Replace each placeholder with curated mechanics.
        { encounterID = 2679, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Kystia Manaheart
        { encounterID = 2680, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Zaen Bladesorrow
        { encounterID = 2681, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Xathuux the Annihilator
        { encounterID = 2682, htmlContent = "<p>" .. L["COMMON_strats_soon"] .. "</p>" },  -- Lithiel Cinderfury
    },
}
