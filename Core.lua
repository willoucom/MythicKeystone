local ADDON, Addon = ...

local lib = LibStub("LibMythicKeystone-1.0")
if not lib then return end

Addon.Name = GetAddOnMetadata(ADDON, "Title")
Addon.ShortName = GetAddOnMetadata(ADDON, "X-Short-Name") or string.sub(ADDON, 1, 16)
Addon.Version = GetAddOnMetadata(ADDON, "X-Packaged-Version")
Addon.AltKeys = {}
Addon.PartyKeys = {}


-------------------------------------------
-- Create frame to hold Alts informations
local AltsFrame = CreateFrame("Frame", nil, PVEFrame, "BackdropTemplate")
-- frame size
AltsFrame:SetWidth(280)
AltsFrame:SetHeight(150)
AltsFrame:SetAlpha(.90)
AltsFrame:SetPoint("BOTTOMLEFT", 0, -200)
-- Make frame almost beautiful
AltsFrame:SetBackdrop(BACKDROP_TUTORIAL_16_16) ---@diagnostic disable-line: param-type-mismatch

-- Create the scrolling parent frame and size it to fit inside the texture
AltsFrame.ScrollFrame = AltsFrame.ScrollFrame or CreateFrame("ScrollFrame", nil, AltsFrame, "UIPanelScrollFrameTemplate")
AltsFrame.ScrollFrame:SetPoint("TOPLEFT", 0, -24)
AltsFrame.ScrollFrame:SetPoint("BOTTOMRIGHT", -27, 4)

-- Create the scrolling child frame, set its width to fit, and give it an arbitrary minimum height (such as 1)
local AltsScrollChild = CreateFrame("Frame")
AltsFrame.ScrollFrame:SetScrollChild(AltsScrollChild)
AltsScrollChild:SetWidth(AltsFrame:GetWidth())
AltsScrollChild:SetHeight(1)

local alts = AltsFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
alts:SetPoint("TOPLEFT", 5, -5)
alts:SetText("My Keystones")

local AltsLeftText = AltsScrollChild:CreateFontString("ARTWORK", nil, "GameFontWhite")
AltsLeftText:SetTextColor(255, 255, 255)
AltsLeftText:SetPoint("TOPLEFT", 10, 0)
AltsLeftText:SetWidth(120)
AltsLeftText:SetHeight(50)
AltsLeftText:SetJustifyH("LEFT")
AltsLeftText:SetJustifyV("TOP")
AltsLeftText:SetText("---")

local AltsCenterText = AltsScrollChild:CreateFontString("ARTWORK", nil, "GameFontWhite")
AltsCenterText:SetTextColor(255, 255, 255)
AltsCenterText:SetPoint("TOPLEFT", 90, 0)
AltsCenterText:SetWidth(20)
AltsCenterText:SetHeight(50)
AltsCenterText:SetJustifyH("RIGHT")
AltsCenterText:SetJustifyV("TOP")
AltsCenterText:SetText("---")

local AltsRightText = AltsScrollChild:CreateFontString("ARTWORK", nil, "GameFontWhite")
AltsRightText:SetTextColor(255, 255, 255)
AltsRightText:SetPoint("TOPLEFT", 120, 0)
AltsRightText:SetWidth(280)
AltsRightText:SetHeight(50)
AltsRightText:SetJustifyH("LEFT")
AltsRightText:SetJustifyV("TOP")
AltsRightText:SetText("---")


-------------------------------------------
-- Create frame to hold Group informations
local GroupFrame = CreateFrame("Frame", nil, PVEFrame, "BackdropTemplate")
-- frame size
GroupFrame:SetWidth(280)
GroupFrame:SetHeight(150)
GroupFrame:SetAlpha(.90)
GroupFrame:SetPoint("BOTTOMLEFT", 280, -200)
-- Make frame almost beautiful
GroupFrame:SetBackdrop(BACKDROP_TUTORIAL_16_16) ---@diagnostic disable-line: param-type-mismatch

local Group = GroupFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
Group:SetPoint("TOPLEFT", 5, -5)
Group:SetText("My Group")

local GroupLeftText = GroupFrame:CreateFontString("ARTWORK", nil, "GameFontWhite")
GroupLeftText:SetTextColor(255, 255, 255)
GroupLeftText:SetPoint("TOPLEFT", 10, -25)
GroupLeftText:SetWidth(280)
GroupLeftText:SetHeight(150)
GroupLeftText:SetJustifyH("LEFT")
GroupLeftText:SetJustifyV("TOP")
GroupLeftText:SetText("---")

local GroupCenterText = GroupFrame:CreateFontString("ARTWORK", nil, "GameFontWhite")
GroupCenterText:SetTextColor(255, 255, 255)
GroupCenterText:SetPoint("TOPLEFT", 90, -25)
GroupCenterText:SetWidth(20)
GroupCenterText:SetHeight(150)
GroupCenterText:SetJustifyH("RIGHT")
GroupCenterText:SetJustifyV("TOP")
GroupCenterText:SetText("---")

local GroupRightText = GroupFrame:CreateFontString("ARTWORK", nil, "GameFontWhite")
GroupRightText:SetTextColor(255, 255, 255)
GroupRightText:SetPoint("TOPLEFT", 120, -25)
GroupRightText:SetWidth(280)
GroupRightText:SetHeight(150)
GroupRightText:SetJustifyH("LEFT")
GroupRightText:SetJustifyV("TOP")
GroupRightText:SetText("---")


-------------------------------------------
-- Create frame to hold Guild informations
local GuildFrame = CreateFrame("Frame", nil, PVEFrame, "BackdropTemplate")
-- frame size
GuildFrame:SetWidth(280)
GuildFrame:SetHeight(PVEFrame:GetHeight())
GuildFrame:SetAlpha(.90)
GuildFrame:SetPoint("TOPRIGHT", PVEFrame:GetWidth() - GuildFrame:GetWidth(), 0)
-- Make frame almost beautiful
GuildFrame:SetBackdrop(BACKDROP_TUTORIAL_16_16) ---@diagnostic disable-line: param-type-mismatch

-- Create the scrolling parent frame and size it to fit inside the texture
GuildFrame.ScrollFrame = GuildFrame.ScrollFrame or
    CreateFrame("ScrollFrame", nil, GuildFrame, "UIPanelScrollFrameTemplate")
GuildFrame.ScrollFrame:SetPoint("TOPLEFT", 0, -24)
GuildFrame.ScrollFrame:SetPoint("BOTTOMRIGHT", -27, 4)

-- Create the scrolling child frame, set its width to fit, and give it an arbitrary minimum height (such as 1)
local GuildScrollChild = CreateFrame("Frame")
GuildFrame.ScrollFrame:SetScrollChild(GuildScrollChild)
GuildScrollChild:SetWidth(GuildFrame:GetWidth())
GuildScrollChild:SetHeight(1)
local guild = {}
guild["title"] = GuildFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
guild["title"]:SetPoint("TOPLEFT", 5, -5)
guild["title"]:SetText("Guild Keystones")

guild["text"] = GuildScrollChild:CreateFontString("ARTWORK", nil, "GameFontWhite")
guild["text"]:SetTextColor(255, 255, 255)
guild["text"]:SetPoint("TOPLEFT", 10, 0)
guild["text"]:SetWidth(GuildFrame:GetWidth())
guild["text"]:SetHeight(50)
guild["text"]:SetJustifyH("LEFT")
guild["text"]:SetJustifyV("TOP")
guild["text"]:SetText("---")

function Addon.UpdateAltsFrame()
    local list = Addon.AltKeys or {}
    local sorted_table = {}
    for key in pairs(list) do
        table.insert(sorted_table, key)
    end
    table.sort(sorted_table)
    local textleft = ""
    local textcenter = ""
    local textright = ""
    AltsLeftText:SetHeight(5)
    AltsCenterText:SetHeight(5)
    AltsRightText:SetHeight(5)
    for _, key in pairs(sorted_table) do
        -- left column
        local name = list[key]["fullname"] or ""
        if string.find(name, "-") then
            name, _ = string.split("-", name)
        end
        name = string.sub(name, 1, 12) -- cut long name

        local color = "|cFFFF000"
        if list[key]["class"] ~= "" then
            color = C_ClassColor.GetClassColor(list[key]["class"]):GenerateHexColorMarkup()
        end
        textleft = textleft .. color .. name .. "\n"
        -- center column
        local keylevel = list[key]["current_keylevel"]
        textcenter = textcenter .. keylevel .. "\n"
        -- right column
        local keystoneMapName = ""
        if list[key]["current_key"] ~= "" then
            keystoneMapName = list[key]["current_key"] and C_ChallengeMode.GetMapUIInfo(list[key]["current_key"]) or " "
        end
        if string.len(keystoneMapName) > 25 then
            keystoneMapName = string.sub(keystoneMapName or "", 1, 25) .. "..."
        end
        textright = textright .. keystoneMapName .. "\n"
        -- resize
        AltsLeftText:SetHeight(AltsLeftText:GetHeight() + AltsLeftText:GetLineHeight())
        AltsCenterText:SetHeight(AltsCenterText:GetHeight() + AltsLeftText:GetLineHeight())
        AltsRightText:SetHeight(AltsRightText:GetHeight() + AltsLeftText:GetLineHeight())
    end
    AltsLeftText:SetText(textleft)
    AltsCenterText:SetText(textcenter)
    AltsRightText:SetText(textright)
end

function Addon.UpdateGroupFrame()
    -- Group
    local textleft = ""
    local textcenter = ""
    local textright = ""
    for char, value in pairs(Addon.PartyKeys) do
        -- left column
        local name = char or ""
        if string.find(name, "-") then
            name, _ = string.split("-", name)
        end
        name = string.sub(name, 1, 12) -- cut long name

        local color = "|cFFFFFFFF"
        if value["class"] and value["class"] ~= "" then
            color = C_ClassColor.GetClassColor(value["class"]):GenerateHexColorMarkup()
        end
        textleft = textleft .. color .. name .. "\n"
        -- center column
        local keylevel = value["current_keylevel"] or 0
        textcenter = textcenter .. keylevel .. "\n"
        -- right column
        local keystoneMapName = ""
        if value["current_key"] then
            keystoneMapName = C_ChallengeMode.GetMapUIInfo(value["current_key"]) or " "
        end
        if string.len(keystoneMapName) > 25 then
            keystoneMapName = string.sub(keystoneMapName or "", 1, 25) .. "..."
        end
        textright = textright .. keystoneMapName .. "\n"
    end

    GroupLeftText:SetText(textleft)
    GroupCenterText:SetText(textcenter)
    GroupRightText:SetText(textright)
end

local function formatText(obj)
    local name = obj["name"] or ""
    name = string.sub(name, 1, 14) -- cut long name
    local color = "|cFFFFFFF"
    if obj["class"] ~= "" then
        color = C_ClassColor.GetClassColor(obj["class"]):GenerateHexColorMarkup()
        name = color .. name .. "|r"
    end

    local keylevel = obj["current_keylevel"]
    -- not so proud of this
    if keylevel < 10 then keylevel = "      "..keylevel
    else keylevel = "    "..keylevel end
    -- returns formated string
    return string.format("%s %s", keylevel, name)
end

local function tableGroupByKeyLevel(obj)
    local keys = {}
    for _, key in pairs(obj) do
        keys[key["current_key"]] = keys[key["current_key"]] or {}
        local tmp = { key["fullname"], key["current_keylevel"] }
        tinsert(keys[key["current_key"]], tmp)
    end

    for keyid in pairs(keys) do
        local tmptable = keys[keyid]
        table.sort(tmptable, function(a, b) return a[2] > b[2] end)
    end
    return keys
end

function Addon.updateGuildFrame()
    local text = ""
    guild["text"]:SetHeight(5)
    if Addon.GuildKeys then
        local keys = tableGroupByKeyLevel(Addon.GuildKeys) or {}
        for keyid in pairs(keys) do
            local keystoneMapName = keyid and C_ChallengeMode.GetMapUIInfo(keyid) or " "
            text = text .. "  " .. keystoneMapName .. "\n"
            guild["text"]:SetHeight(guild["text"]:GetHeight() + guild["text"]:GetLineHeight())
            for char in pairs(keys[keyid]) do
                char = keys[keyid][char][1]
                text = text .. "  " .. formatText(Addon.GuildKeys[char]) .. "\n"
                guild["text"]:SetHeight(guild["text"]:GetHeight() + guild["text"]:GetLineHeight())
            end
        end
    end
    guild["text"]:SetText(text)
end

function Addon.getTableKeys(t)
    local keys = {}
    for key, _ in pairs(t) do
        table.insert(keys, key)
    end
    return keys
end

local f = CreateFrame("frame")
local throttle = 0
f:SetScript("OnUpdate", function(self, elap)
    if PVEFrame:IsShown() then
        local oldparty = Addon.PartyKeys
        Addon.PartyKeys = lib.getPartyKeystone()
        if table.concat(Addon.getTableKeys(Addon.PartyKeys)) ~= table.concat(Addon.getTableKeys(oldparty)) then
            Addon.UpdateGroupFrame()
        end
        if RaiderIO_ProfileTooltip then
            RaiderIO_ProfileTooltip:SetPoint("TOPLEFT", PVEFrame:GetWidth() - GuildFrame:GetWidth() + 15, 0)
        end
        if throttle == 0 then
            Addon.AltKeys = lib.getAltsKeystone()
            Addon.GuildKeys = lib.getGuildKeystone()
            Addon.UpdateAltsFrame()
            Addon.updateGuildFrame()
            Addon.UpdateGroupFrame()
            throttle = 100
        end
        throttle = throttle - 1
    else
        throttle = 0
    end
end)


_G[ADDON] = Addon
