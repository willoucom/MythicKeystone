local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Guide data table
-- Populated by individual files in Guide/Dungeons/*.lua (loaded after this one).
-------------------------------------------------------------------------------

ns.guideData = {}

-------------------------------------------------------------------------------
-- Helper: find dungeon by uiMapId
-------------------------------------------------------------------------------

function ns.Spell(id)
    local info    = C_Spell.GetSpellInfo(id)
    local name    = (info and info.name) or "?"
    local iconID  = info and info.iconID
    local iconStr = iconID and ("|T" .. iconID .. ":16:16:0:0|t") or ""
    return iconStr .. "|cff71d5ff|Hspell:" .. id .. "|h[" .. name .. "]|h|r"
end

function ns.NPC(id, name)
    return "|cffffcc00|Hnpc:" .. id .. "|h[" .. (name or "?") .. "]|h|r"
end

function ns.GetDungeonByMapId(mapId)
    if not mapId then return nil end
    for _, dungeon in ipairs(ns.guideData) do
        for _, id in ipairs(dungeon.mapIds) do
            if id == mapId then return dungeon end
        end
    end
    return nil
end

-------------------------------------------------------------------------------
-- Helper: localized dungeon name
-- Prefer the game's official localized name (C_ChallengeMode.GetMapUIInfo) so
-- names always match the client locale; fall back to the hardcoded
-- L["<id>_name"] when the API has no data (e.g. a dungeon not in the data yet).
-------------------------------------------------------------------------------

function ns.DungeonName(dungeon)
    if dungeon.challengeMapID then
        local name = C_ChallengeMode.GetMapUIInfo(dungeon.challengeMapID)
        if name and name ~= "" then return name end
    end
    return dungeon.name
end

-- Official LFG icon fileID (GetMapUIInfo return #4); fall back to datamined path.
function ns.DungeonIcon(dungeon)
    if dungeon.challengeMapID then
        local _, _, _, texture = C_ChallengeMode.GetMapUIInfo(dungeon.challengeMapID)
        if texture then return texture end
    end
    return dungeon.icon
end

-- Official background fileID (GetMapUIInfo return #5, the EJ lore art); fall back
-- to the datamined background path.
function ns.DungeonBackground(dungeon)
    if dungeon.challengeMapID then
        local _, _, _, _, backgroundTexture = C_ChallengeMode.GetMapUIInfo(dungeon.challengeMapID)
        if backgroundTexture then return backgroundTexture end
    end
    return dungeon.background
end

-------------------------------------------------------------------------------
-- Encounter Journal helpers
-- Boss section data (name / portrait / lore) is pulled live from the Encounter
-- Journal via a section's `encounterID`, so it is always official and localized.
-------------------------------------------------------------------------------

-- EJ_* lookups need the journal data loaded; it usually is at login, but force
-- the journal addon once so the first guide open works.
local ejRequested = false
local function ensureEJData()
    if not ejRequested then
        ejRequested = true
        pcall(C_AddOns.LoadAddOn, "Blizzard_EncounterJournal")
    end
end

-- Localized boss name for a journal encounter id (nil if EJ has no data).
function ns.EncounterName(encounterID)
    ensureEJData()
    return (EJ_GetEncounterInfo(encounterID))
end

-- Boss portrait texture for a journal encounter id (first creature), with the
-- Blizzard default portrait as fallback.
function ns.EncounterIcon(encounterID)
    ensureEJData()
    return select(5, EJ_GetCreatureInfo(1, encounterID))
        or "Interface\\EncounterJournal\\UI-EJ-BOSS-Default"
end

-- Auto intro HTML for a boss section: <h1>name</h1> + <p>EJ lore</p>.
function ns.BossIntroHTML(encounterID)
    ensureEJData()
    local name, lore = EJ_GetEncounterInfo(encounterID)
    local html = ""
    if name and name ~= "" then html = "<h1>" .. name .. "</h1>" end
    if lore and lore ~= "" then html = html .. "<p>" .. lore .. "</p>" end
    return html
end

-- Dungeon (instance) lore description from the Encounter Journal.
function ns.InstanceLore(instanceID)
    ensureEJData()
    local _, description = EJ_GetInstanceInfo(instanceID)
    return description
end
