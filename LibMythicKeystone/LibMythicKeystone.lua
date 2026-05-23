local ADDON, Addon = ...
local MAJOR, MINOR = "LibMythicKeystone-1.0", 1;
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end
local LKS = assert(LibStub("LibKeystone", true), "LibMythicKeystone requires LibKeystone")
local CTL = assert(ChatThrottleLib, "LibMythicKeystone requires ChatThrottleLib")

Addon.ShortName = "MythicKeystone"
Addon.PartyKeys = {}
Addon.Mykey = {
    ["class"] = "",
    ["name"] = "pname",
    ["realm"] = "sname",
    ["fullname"] = "player",
    ["current_key"] = 0,
    ["current_keylevel"] = 0,
    ["mplus_score"] = 0
}

Addon.ProcessingKeys = false
Addon.lib = lib

local initializeTime = {}
initializeTime[1] = 1500390000 -- US Tuesday at reset
initializeTime[2] = 1500447600 -- EU Wednesday at reset
initializeTime[3] = 1500505200 -- TW Thursday at reset
initializeTime[4] = 0

--
-- Public functions
--

function lib.getMyKeystone()
    return Addon.Mykey
end

function lib.getAltsKeystone()
    if not LibMythicKeystoneDB then return {} end
    return LibMythicKeystoneDB['Alts'] or {}
end

function lib.getPartyKeystone()
    return Addon.PartyKeys
end

function lib.getGuildKeystone()
    if not LibMythicKeystoneDB or not LibMythicKeystoneDB['Guilds'] then return {} end
    local GuildName = GetGuildInfo("player") or "none"
    return LibMythicKeystoneDB['Guilds'][GuildName] or {}
end

--
-- Private functions
--

-- This function is from AstralKeys addon (great addon btw)
function Addon.GetWeek()
    local region = GetCurrentRegion()
    if region == 3 then     -- EU
        return math.floor((GetServerTime() - initializeTime[2]) / 604800)
    elseif region == 4 then -- TW
        return math.floor((GetServerTime() - initializeTime[3]) / 604800)
    else                    -- default to US
        return math.floor((GetServerTime() - initializeTime[1]) / 604800)
    end
end

function Addon.getKeystone()
    if Addon.ProcessingKeys then
        return
    end
    Addon.ProcessingKeys = true
    local keystoneMapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID() or 0
    local keystoneLevel = C_MythicPlus.GetOwnedKeystoneLevel() or 0

    -- Look for database and create if not exists
    LibMythicKeystoneDB = LibMythicKeystoneDB or {};
    LibMythicKeystoneDB['Alts'] = LibMythicKeystoneDB['Alts'] or {};
    LibMythicKeystoneDB['Guilds'] = LibMythicKeystoneDB['Guilds'] or {};

    -- Get character name. guild and realm
    local pname = UnitName("player")
    if not pname then
        Addon.ProcessingKeys = false
        return false
    end
    local realm = GetNormalizedRealmName()
    if not realm then
        Addon.ProcessingKeys = false
        return false
    end
    local GuildName = GetGuildInfo("player") or "none"
    local _, classFilename = C_PlayerInfo.GetClass(PlayerLocation:CreateFromUnit("player"))

    -- Create guild storage
    if GuildName ~= "none" then
        LibMythicKeystoneDB['Guilds'] = LibMythicKeystoneDB['Guilds'] or {}
        LibMythicKeystoneDB['Guilds'][GuildName] = LibMythicKeystoneDB['Guilds'][GuildName] or {};
    end

    -- Format for storage
    local player = string.format("%s-%s", pname, realm)

    Addon.Mykey = {
        ["class"] = classFilename,
        ["name"] = pname,
        ["realm"] = realm,
        ["fullname"] = player,
        ["current_key"] = keystoneMapID,
        ["guild"] = GuildName,
        ["current_keylevel"] = keystoneLevel,
        ["week"] = Addon.GetWeek(),
        ["weeklybest"] = 0,
        ["weeklycount"] = 0,
        ["mplus_score"] = 0
    }

    -- Get Number of runs this week
    local rewards = C_WeeklyRewards.GetActivities(1) or {[1] = {["progress"] = 0, ["level"] = 0}}
    if rewards[1] and rewards[1]["progress"] and rewards[1]["level"] then
        -- Get num runs
        Addon.Mykey["weeklycount"] = rewards[1]["progress"] or 0
        -- Get best runs
        Addon.Mykey["weeklybest"] = rewards[1]["level"] or 0
    end

    -- Get Mythic+ rating
    local mplusSummary = C_PlayerInfo.GetPlayerMythicPlusRatingSummary("player")
    if type(mplusSummary) == "table" and type(mplusSummary.currentSeasonScore) == "number" then
        Addon.Mykey["mplus_score"] = mplusSummary.currentSeasonScore
    end

    Addon.PartyKeys[pname] = {
        ["class"] = classFilename,
        ["name"] = pname,
        ["realm"] = realm,
        ["fullname"] = player,
        ["current_key"] = keystoneMapID,
        ["current_keylevel"] = keystoneLevel
    }

    -- save in database
    if keystoneLevel > 0 and realm then
        -- save in alts
        LibMythicKeystoneDB['Alts'][player] = Addon.Mykey
        -- save in guild
        if GuildName ~= "none" then
            LibMythicKeystoneDB['Guilds'][GuildName][player] = Addon.Mykey
        end
    end

    -- Init group table
    local tempkeys = {}
    tempkeys[Addon.Mykey["name"]] = Addon.Mykey
    if IsInGroup(LE_PARTY_CATEGORY_HOME) then
        for i = 1, 4 do
            local name, realm = UnitNameUnmodified("party" .. i) or nil, nil
            local _, class = UnitClass("party" .. i)
            if not realm then
                -- unit is on the same realm
                realm = Addon.Mykey["realm"]
            end
            if name then
                tempkeys[name] = {}
                tempkeys[name]["class"] = class
                tempkeys[name]["name"] = name
                tempkeys[name]["realm"] = realm
                tempkeys[name]["current_key"] = 0
                tempkeys[name]["current_keylevel"] = 0
                if Addon.PartyKeys[name] then
                    tempkeys[name]["current_key"] = Addon.PartyKeys[name]["current_key"] or 0
                    tempkeys[name]["current_keylevel"] = Addon.PartyKeys[name]["current_keylevel"] or 0
                end
            end
        end
    end
    Addon.PartyKeys = tempkeys

    -- Clean obsolete keys (Guild)
    for guild in pairs(LibMythicKeystoneDB['Guilds']) do
        for char in pairs(LibMythicKeystoneDB['Guilds'][guild]) do
            if LibMythicKeystoneDB['Guilds'][guild][char]['week'] ~= Addon.GetWeek() then
                LibMythicKeystoneDB['Guilds'][guild][char] = nil
            end
        end
    end

    -- Clean obsolete keys (Alts)
    for char in pairs(LibMythicKeystoneDB['Alts']) do
        if LibMythicKeystoneDB['Alts'][char]['week'] ~= Addon.GetWeek() then
            LibMythicKeystoneDB['Alts'][char] = nil
        end
    end


    Addon.ProcessingKeys = false
end

--
-- LibKeystone integration
--
-- LibKeystone broadcasts our own key automatically (post-M+ via CHALLENGE_MODE_COMPLETED
-- chain, or in response to peer "R" requests). It also gives us callbacks for keys
-- received from party/guild members. We just need to (a) register a callback to absorb
-- incoming data into our tables, and (b) call LKS.Request to seed the player list when
-- the group/guild state changes.

local function OnKeystoneReceived(keyLevel, keyMap, playerRating, playerName, channel)
    if not keyLevel or not keyMap or keyLevel <= 0 or keyMap <= 0 then return end

    local name, realm = strsplit("-", playerName)
    if not realm or realm == "" then
        realm = GetNormalizedRealmName() or ""
    end
    local fullname = (realm ~= "") and (name .. "-" .. realm) or name

    if channel == "PARTY" then
        local entry = Addon.PartyKeys[name] or {}
        Addon.PartyKeys[name] = entry
        entry["name"] = name
        entry["realm"] = realm
        entry["fullname"] = fullname
        entry["current_key"] = keyMap
        entry["current_keylevel"] = keyLevel
        if playerRating and playerRating > 0 then
            entry["mplus_score"] = playerRating
        end
    elseif channel == "GUILD" then
        local guildName = GetGuildInfo("player")
        if not guildName then return end
        LibMythicKeystoneDB = LibMythicKeystoneDB or {}
        LibMythicKeystoneDB['Guilds'] = LibMythicKeystoneDB['Guilds'] or {}
        LibMythicKeystoneDB['Guilds'][guildName] = LibMythicKeystoneDB['Guilds'][guildName] or {}
        local entry = LibMythicKeystoneDB['Guilds'][guildName][fullname] or {}
        LibMythicKeystoneDB['Guilds'][guildName][fullname] = entry
        entry["name"] = name
        entry["realm"] = realm
        entry["fullname"] = fullname
        entry["guild"] = guildName
        entry["current_key"] = keyMap
        entry["current_keylevel"] = keyLevel
        entry["week"] = Addon.GetWeek()
        if playerRating and playerRating > 0 then
            entry["mplus_score"] = playerRating
        end
    end
end

LKS.Register(Addon, OnKeystoneReceived)

--
-- "MythicKeystone" wire protocol (LMK-specific, on top of LibKeystone)
--
-- Used for two things:
--   1. Offline-alts broadcast on GUILD with format
--      "<mapID>:<level>:<class>:<fullname>[:<mplus_score>]"
--      LibKeystone only carries the currently-logged-in character; this fills
--      the gap for alts that share the player's guild.
--   2. ======= LEGACY COMPAT — REMOVAL TARGET: 2026-07-15 =======
--      The same prefix used to carry the *active* character's broadcast on
--      both PARTY and GUILD, with the 4-field form
--      "<mapID>:<level>:<class>:<fullname>" and the request messages
--      "requestPartyKeystone" / "requestGuildKeystone".
--      LibKeystone replaced this for new clients, but pre-2026-05 LMK clients
--      still speak only this protocol. Until enough peers have upgraded, we:
--        - keep receiving on both channels (permanent — defensive, near-zero
--          cost)
--        - keep emitting the active character on both channels when
--          Addon.legacyWire is true (toggle via `/lmk legacy on|off`,
--          persisted in options.legacyWire, default true).
--      When the sunset date passes, delete the LEGACY EMITTER block and the
--      legacy request keywords from the receiver dispatch.
--

function Addon.sendAltsToGuild()
    if not IsInGuild() then return end
    local guildName = GetGuildInfo("player")
    if not guildName then return end
    if not LibMythicKeystoneDB or not LibMythicKeystoneDB['Alts'] then return end

    local activeFullname = Addon.Mykey and Addon.Mykey["fullname"]
    for _, value in pairs(LibMythicKeystoneDB['Alts']) do
        if value['guild'] == guildName
            and tonumber(value["current_key"] or 0) > 0
            and value["fullname"] ~= activeFullname then
            local data = value["current_key"] .. ":"
                .. value["current_keylevel"] .. ":"
                .. (value["class"] or "") .. ":"
                .. value["fullname"] .. ":"
                .. (tonumber(value["mplus_score"]) or 0)
            if Addon.dryrun then
                if Addon.DebugLogDryRun then Addon.DebugLogDryRun(Addon.ShortName, "GUILD", data) end
            else
                CTL:SendAddonMessage("NORMAL", Addon.ShortName, data, "GUILD")
            end
        end
    end
end

function Addon.requestGuildAlts()
    if not IsInGuild() then return end
    if Addon.dryrun then
        if Addon.DebugLogDryRun then Addon.DebugLogDryRun(Addon.ShortName, "GUILD", "requestGuildAlts") end
        return
    end
    CTL:SendAddonMessage("NORMAL", Addon.ShortName, "requestGuildAlts", "GUILD")
end

-- ====== LEGACY EMITTER (remove with the surrounding block on sunset) ======

local function sendOnLegacy(channel, payload)
    if Addon.dryrun then
        if Addon.DebugLogDryRun then Addon.DebugLogDryRun(Addon.ShortName, channel, payload) end
    else
        CTL:SendAddonMessage("NORMAL", Addon.ShortName, payload, channel)
    end
end

function Addon.sendLegacyActiveKeystone()
    if not Addon.legacyWire then return end
    local m = Addon.Mykey
    if not m or not m.current_key or tonumber(m.current_key) == 0 then return end
    if not m.fullname or m.fullname == "" then return end
    local payload = string.format("%s:%s:%s:%s",
        tostring(m.current_key), tostring(m.current_keylevel or 0),
        m.class or "", m.fullname)
    if IsInGroup(LE_PARTY_CATEGORY_HOME) and not IsInRaid() then
        sendOnLegacy("PARTY", payload)
    end
    if IsInGuild() then
        sendOnLegacy("GUILD", payload)
    end
end

function Addon.requestLegacyKeystone()
    if not Addon.legacyWire then return end
    if IsInGroup(LE_PARTY_CATEGORY_HOME) and not IsInRaid() then
        sendOnLegacy("PARTY", "requestPartyKeystone")
    end
    if IsInGuild() then
        sendOnLegacy("GUILD", "requestGuildKeystone")
    end
end

-- ====== END LEGACY EMITTER ======

local function OnLegacyReceived(message, channel)
    -- Request keywords
    if message == "requestGuildAlts" then
        if channel == "GUILD" then Addon.sendAltsToGuild() end
        return
    end
    -- LEGACY: requests from pre-2026-05 clients
    if message == "requestPartyKeystone" then
        if channel == "PARTY" then Addon.sendLegacyActiveKeystone() end
        return
    end
    if message == "requestGuildKeystone" then
        if channel == "GUILD" then
            Addon.sendLegacyActiveKeystone()
            Addon.sendAltsToGuild()
        end
        return
    end

    -- Data payload: "<mapID>:<level>:<class>:<fullname>[:<mplus_score>]"
    if not string.match(message, ":") then return end
    local key, keylevel, class, fullname, mplus_score = strsplit(":", message)
    if not fullname or fullname == "" then return end
    local keyNum = tonumber(key)
    local levelNum = tonumber(keylevel)
    if not keyNum or not levelNum or keyNum <= 0 or levelNum <= 0 then return end
    local score = tonumber(mplus_score)

    if channel == "PARTY" then
        local name = strsplit("-", fullname)
        if not name or name == "" then return end
        local entry = Addon.PartyKeys[name] or {}
        Addon.PartyKeys[name] = entry
        entry["name"] = name
        entry["realm"] = select(2, strsplit("-", fullname))
        entry["fullname"] = fullname
        entry["current_key"] = keyNum
        entry["current_keylevel"] = levelNum
        if class and class ~= "" then entry["class"] = class end
        if score and score > 0 then entry["mplus_score"] = score end
    elseif channel == "GUILD" then
        local name, realm = strsplit("-", fullname)
        if not name or not realm then return end
        local guildName = GetGuildInfo("player")
        if not guildName then return end
        LibMythicKeystoneDB = LibMythicKeystoneDB or {}
        LibMythicKeystoneDB['Guilds'] = LibMythicKeystoneDB['Guilds'] or {}
        LibMythicKeystoneDB['Guilds'][guildName] = LibMythicKeystoneDB['Guilds'][guildName] or {}
        local entry = LibMythicKeystoneDB['Guilds'][guildName][fullname] or {}
        LibMythicKeystoneDB['Guilds'][guildName][fullname] = entry
        entry["name"] = name
        entry["realm"] = realm
        entry["fullname"] = fullname
        entry["guild"] = guildName
        entry["current_key"] = keyNum
        entry["current_keylevel"] = levelNum
        if class and class ~= "" then entry["class"] = class end
        if score and score > 0 then entry["mplus_score"] = score end
        entry["week"] = Addon.GetWeek()
    end
end

C_ChatInfo.RegisterAddonMessagePrefix(Addon.ShortName)

local legacyListener = CreateFrame("Frame")
legacyListener:RegisterEvent("CHAT_MSG_ADDON")
legacyListener:SetScript("OnEvent", function(_, _, prefix, message, channel)
    if prefix == Addon.ShortName then
        OnLegacyReceived(message, channel)
    end
end)

--
-- Frames
--

local LibMythicKeystoneFrame = CreateFrame("Frame")
local LibMythicKeystoneFrames = {}

LibMythicKeystoneFrames["SendkeyEvent"] = CreateFrame("Frame", nil, LibMythicKeystoneFrame)
LibMythicKeystoneFrames["SendkeyEvent"]:RegisterEvent("PLAYER_ENTERING_WORLD")
LibMythicKeystoneFrames["SendkeyEvent"]:RegisterEvent("GROUP_JOINED")
LibMythicKeystoneFrames["SendkeyEvent"]:RegisterEvent("GROUP_LEFT")
LibMythicKeystoneFrames["SendkeyEvent"]:RegisterEvent("GROUP_ROSTER_UPDATE")
LibMythicKeystoneFrames["SendkeyEvent"]:RegisterEvent("CHALLENGE_MODE_MEMBER_INFO_UPDATED")
LibMythicKeystoneFrames["SendkeyEvent"]:RegisterEvent("ITEM_CHANGED")
LibMythicKeystoneFrames["SendkeyEvent"]:SetScript("OnEvent", function()
    C_Timer.After(10, function()
        Addon.getKeystone()
        LKS.Request("PARTY")
        LKS.Request("GUILD")
        Addon.sendAltsToGuild()
        Addon.requestGuildAlts()
        -- LEGACY COMPAT (remove on sunset): broadcast active char on the old
        -- MythicKeystone prefix and request keys from old peers.
        Addon.sendLegacyActiveKeystone()
        Addon.requestLegacyKeystone()
    end)
end)

C_Timer.After(1, Addon.getKeystone)
C_Timer.NewTicker(60, function() Addon.getKeystone() end)




Addon.lib = lib
_G[ADDON] = lib
