local _, Addon = ...

-- AngryKeystones wire protocol (https://github.com/Ermad/angry-keystones):
--   Prefix : "AngryKeystones" (addon ShortName)
--   Framing: "<module>|<message>" — keystone module is "Schedule"
--   Payload: "<mapID>:<level>" or "0" (no key) or "request"
--   Channel: PARTY

local AK_PREFIX = "AngryKeystones"
local AK_FRAME = "Schedule|"

C_ChatInfo.RegisterAddonMessagePrefix(AK_PREFIX)

local function BuildOwnPayload()
    local mapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
    local level = C_MythicPlus.GetOwnedKeystoneLevel()
    if mapID and level and mapID > 0 and level > 0 then
        return string.format("%s%d:%d", AK_FRAME, mapID, level)
    end
    return AK_FRAME .. "0"
end

local function SendOwnToParty()
    if not IsInGroup(LE_PARTY_CATEGORY_HOME) then return end
    local payload = BuildOwnPayload()
    if Addon.dryrun then
        if Addon.DebugLogDryRun then Addon.DebugLogDryRun(AK_PREFIX, "PARTY", payload) end
        return
    end
    ChatThrottleLib:SendAddonMessage("NORMAL", AK_PREFIX, payload, "PARTY")
end

local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_ADDON")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("GROUP_JOINED")
f:RegisterEvent("CHALLENGE_MODE_COMPLETED")
f:SetScript("OnEvent", function(_, event, ...)
    if event ~= "CHAT_MSG_ADDON" then
        C_Timer.After(5, SendOwnToParty)
        return
    end

    local prefix, message, channel, sender = ...
    if prefix ~= AK_PREFIX then return end
    if channel ~= "PARTY" then return end
    if string.sub(message, 1, #AK_FRAME) ~= AK_FRAME then return end

    local payload = string.sub(message, #AK_FRAME + 1)

    if payload == "request" then
        SendOwnToParty()
        return
    end
    if payload == "0" then return end

    local mapStr, levelStr = payload:match("^(%d+):(%d+)$")
    local mapID = tonumber(mapStr)
    local level = tonumber(levelStr)
    if not mapID or not level or mapID == 0 or level == 0 then return end

    local charName = strsplit("-", sender)
    Addon.PartyKeys[charName] = Addon.PartyKeys[charName] or {}
    Addon.PartyKeys[charName]["current_key"] = mapID
    Addon.PartyKeys[charName]["current_keylevel"] = level
end)
