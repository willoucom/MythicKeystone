local _, Addon = ...

-- AstralKeys wire protocol (https://github.com/astralguild/AstralKeys):
--   Prefix : "AstralKeys"
--   Channel: GUILD (BNET/WHISPER for friends, not handled here)
--   Framing: "<sub-prefix> <payload>" (space-separated; sub-prefix is first token)
--   Sub-prefixes:
--     updateV9 — single key update: "unit:class:dungeonID:keyLevel:weekly_best:week:mplus_score"
--     sync6    — bulk: entries joined by "_", each
--                "unit:class:dungeonID:keyLevel:weekly_best:week:timeStamp:mplus_score"
--     request  — peer asks for our keys; we respond with our own updateV9
--
-- Also imports the local AstralKeys SavedVariable if the AstralKeys addon is installed,
-- so guild keys collected by AstralKeys are visible without waiting for a live broadcast.

local AK_PREFIX = "AstralKeys"
local AK_UPDATE = "updateV9"
local AK_SYNC = "sync6"

C_ChatInfo.RegisterAddonMessagePrefix(AK_PREFIX)

local function GetMplusScore()
    local summary = C_PlayerInfo.GetPlayerMythicPlusRatingSummary("player")
    if type(summary) == "table" and type(summary.currentSeasonScore) == "number" then
        return summary.currentSeasonScore
    end
    return 0
end

local function BuildOwnUpdatePayload()
    local mapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
    local level = C_MythicPlus.GetOwnedKeystoneLevel()
    if not mapID or not level or mapID <= 0 or level <= 0 then return nil end

    local mykey = Addon.Mykey or {}
    local class = mykey["class"]
    if not class or class == "" then
        class = select(2, UnitClass("player")) or ""
    end
    local fullname = mykey["fullname"]
    if not fullname or fullname == "" then
        fullname = UnitName("player") .. "-" .. GetNormalizedRealmName()
    end
    local weeklybest = tonumber(mykey["weeklybest"]) or 0
    local week = Addon.GetWeek and Addon.GetWeek() or 0

    return string.format("%s:%s:%d:%d:%d:%d:%d",
        fullname, class, mapID, level, weeklybest, week, GetMplusScore())
end

local function SendOwnToGuild()
    if not IsInGuild() then return end
    local payload = BuildOwnUpdatePayload()
    if not payload then return end
    local wire = AK_UPDATE .. " " .. payload
    if Addon.dryrun then
        if Addon.DebugLogDryRun then Addon.DebugLogDryRun(AK_PREFIX, "GUILD", wire) end
        return
    end
    ChatThrottleLib:SendAddonMessage("NORMAL", AK_PREFIX, wire, "GUILD")
end

local function StoreGuildEntry(unit, class, dungeonID, keyLevel, weekly_best, week, mplus_score)
    if not unit or not dungeonID or not keyLevel then return end
    if dungeonID <= 0 or keyLevel <= 0 then return end
    if not Addon.GetWeek or week ~= Addon.GetWeek() then return end

    local name, realm = strsplit("-", unit)
    if not name or not realm then return end

    local guildName = GetGuildInfo("player")
    if not guildName then return end

    LibMythicKeystoneDB = LibMythicKeystoneDB or {}
    LibMythicKeystoneDB['Guilds'] = LibMythicKeystoneDB['Guilds'] or {}
    LibMythicKeystoneDB['Guilds'][guildName] = LibMythicKeystoneDB['Guilds'][guildName] or {}
    local entry = LibMythicKeystoneDB['Guilds'][guildName][unit] or {}
    LibMythicKeystoneDB['Guilds'][guildName][unit] = entry
    entry["name"] = name
    entry["realm"] = realm
    entry["fullname"] = unit
    entry["guild"] = guildName
    entry["current_key"] = dungeonID
    entry["current_keylevel"] = keyLevel
    entry["week"] = week
    if class and class ~= "" then entry["class"] = class end
    if weekly_best and weekly_best > 0 then entry["weeklybest"] = weekly_best end
    if mplus_score and mplus_score > 0 then entry["mplus_score"] = mplus_score end
end

local function HandleUpdate(payload)
    local unit, class, dungeonID, keyLevel, weekly_best, week, mplus_score = strsplit(":", payload)
    StoreGuildEntry(unit, class, tonumber(dungeonID), tonumber(keyLevel),
        tonumber(weekly_best), tonumber(week), tonumber(mplus_score))
end

local function HandleSync(payload)
    for entry in payload:gmatch("([^_]+)") do
        local unit, class, dungeonID, keyLevel, weekly_best, week, _, mplus_score = strsplit(":", entry)
        StoreGuildEntry(unit, class, tonumber(dungeonID), tonumber(keyLevel),
            tonumber(weekly_best), tonumber(week), tonumber(mplus_score))
    end
end

local function OnAddonMessage(message, channel)
    if channel ~= "GUILD" then return end
    local subPrefix, payload = message:match("^(%S+)%s*(.-)$")
    if not subPrefix then return end

    if subPrefix == AK_UPDATE then
        HandleUpdate(payload)
    elseif subPrefix == AK_SYNC then
        HandleSync(payload)
    elseif subPrefix == "request" then
        SendOwnToGuild()
    end
end

local importDone = false
local function ImportFromSavedVariable()
    if importDone then return end
    if not AstralKeys then return end
    local guildName = GetGuildInfo("player")
    if not guildName then return end
    if not LibMythicKeystoneDB then return end
    LibMythicKeystoneDB['Guilds'] = LibMythicKeystoneDB['Guilds'] or {}
    LibMythicKeystoneDB['Guilds'][guildName] = LibMythicKeystoneDB['Guilds'][guildName] or {}
    for _, value in pairs(AstralKeys) do
        if value['source'] == "guild" then
            local fullname = value['unit']
            local name, realm = strsplit("-", fullname)
            local entry = LibMythicKeystoneDB['Guilds'][guildName][fullname] or {}
            LibMythicKeystoneDB['Guilds'][guildName][fullname] = entry
            entry["class"] = entry["class"] or value["class"]
            entry["current_key"] = entry["current_key"] or value["dungeon_id"]
            entry["current_keylevel"] = entry["current_keylevel"] or value["key_level"]
            entry["guild"] = entry["guild"] or guildName
            entry["name"] = entry["name"] or name
            entry["realm"] = entry["realm"] or realm
            entry["week"] = entry["week"] or value["week"]
            entry["fullname"] = entry["fullname"] or fullname
        end
    end
    importDone = true
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("CHAT_MSG_ADDON")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("CHALLENGE_MODE_COMPLETED")
f:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        ImportFromSavedVariable()
        if importDone then self:UnregisterEvent("ADDON_LOADED") end
        return
    end
    if event == "CHAT_MSG_ADDON" then
        local prefix, message, channel = ...
        if prefix == AK_PREFIX then
            OnAddonMessage(message, channel)
        end
        return
    end
    -- PLAYER_ENTERING_WORLD or CHALLENGE_MODE_COMPLETED
    C_Timer.After(10, SendOwnToGuild)
end)
