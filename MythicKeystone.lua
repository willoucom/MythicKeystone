local ADDON, Addon = ...

local lib = LibStub("LibMythicKeystone-1.0")
if not lib then return end
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON)

Addon.Name = C_AddOns.GetAddOnMetadata(ADDON, "Title")
Addon.ShortName = C_AddOns.GetAddOnMetadata(ADDON, "X-Short-Name") or string.sub(ADDON, 1, 16)
Addon.Version = C_AddOns.GetAddOnMetadata(ADDON, "X-Packaged-Version")
Addon.AltKeys = {}
Addon.PartyKeys = {}
Addon.GuildKeys = {}

-------------------------------------------
-- Tooltip
local tooltipshow = function(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR", 0 , -20)
    GameTooltip:SetText(L["Refresh"], 1, 1, 1,  0.9, true);
    GameTooltip:Show();
end
local tooltiphide = function(self)
    GameTooltip:Hide();
end

-------------------------------------------
-- Create frame to hold Alts informations
local AltsFrame = CreateFrame("Frame", nil, PVEFrame, "BackdropTemplate")
-- frame size
AltsFrame:SetWidth(430)
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
alts:SetText(L["Alts"])

local AltsLeftText = AltsScrollChild:CreateFontString("ARTWORK", nil, "GameFontWhite")
AltsLeftText:SetTextColor(255, 255, 255)
AltsLeftText:SetPoint("TOPLEFT", 10, 0)
AltsLeftText:SetWidth(120)
AltsLeftText:SetHeight(50)
AltsLeftText:SetJustifyH("LEFT")
AltsLeftText:SetJustifyV("TOP")
AltsLeftText:SetText("")

local AltsCenterText = AltsScrollChild:CreateFontString("ARTWORK", nil, "GameFontWhite")
AltsCenterText:SetTextColor(255, 255, 255)
AltsCenterText:SetPoint("TOPLEFT", 90, 0)
AltsCenterText:SetWidth(20)
AltsCenterText:SetHeight(50)
AltsCenterText:SetJustifyH("RIGHT")
AltsCenterText:SetJustifyV("TOP")
AltsCenterText:SetText("")

local AltsCenterRightText = AltsScrollChild:CreateFontString("ARTWORK", nil, "GameFontWhite")
AltsCenterRightText:SetTextColor(255, 255, 255)
AltsCenterRightText:SetPoint("TOPLEFT", 120, 0)
AltsCenterRightText:SetWidth(280)
AltsCenterRightText:SetHeight(50)
AltsCenterRightText:SetJustifyH("LEFT")
AltsCenterRightText:SetJustifyV("TOP")
AltsCenterRightText:SetText("")

local AltsRightText = AltsScrollChild:CreateFontString("ARTWORK", nil, "GameFontWhite")
AltsRightText:SetTextColor(255, 255, 255)
AltsRightText:SetPoint("TOPLEFT", 290, 0)
AltsRightText:SetWidth(280)
AltsRightText:SetHeight(50)
AltsRightText:SetJustifyH("LEFT")
AltsRightText:SetJustifyV("TOP")
AltsRightText:SetText("")

local AltsButton = CreateFrame("Button", nil, AltsFrame)
AltsButton:SetWidth(AltsFrame:GetWidth())
AltsButton:SetHeight(AltsFrame:GetHeight())
AltsButton:SetPoint("TOPLEFT", 0, 0)
AltsButton:SetScript("OnClick", function(self, button)
    Addon.UpdateAltsFrame()
end)
AltsButton:SetScript("OnEnter", tooltipshow)
AltsButton:SetScript("OnLeave", tooltiphide)

-------------------------------------------
-- Create frame to hold Group informations
local GroupFrame = CreateFrame("Frame", nil, PVEFrame, "BackdropTemplate")
-- frame size
GroupFrame:SetWidth(280)
GroupFrame:SetHeight(150)
GroupFrame:SetAlpha(.90)
GroupFrame:SetPoint("BOTTOMLEFT", AltsFrame:GetWidth(), -200)
-- Make frame almost beautiful
GroupFrame:SetBackdrop(BACKDROP_TUTORIAL_16_16) ---@diagnostic disable-line: param-type-mismatch

local Group = GroupFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
Group:SetPoint("TOPLEFT", 5, -5)
Group:SetText(L["Group"])

local GroupLeftText = GroupFrame:CreateFontString("ARTWORK", nil, "GameFontWhite")
GroupLeftText:SetTextColor(255, 255, 255)
GroupLeftText:SetPoint("TOPLEFT", 10, -25)
GroupLeftText:SetWidth(280)
GroupLeftText:SetHeight(150)
GroupLeftText:SetJustifyH("LEFT")
GroupLeftText:SetJustifyV("TOP")
GroupLeftText:SetText("")

local GroupCenterText = GroupFrame:CreateFontString("ARTWORK", nil, "GameFontWhite")
GroupCenterText:SetTextColor(255, 255, 255)
GroupCenterText:SetPoint("TOPLEFT", 90, -25)
GroupCenterText:SetWidth(20)
GroupCenterText:SetHeight(150)
GroupCenterText:SetJustifyH("RIGHT")
GroupCenterText:SetJustifyV("TOP")
GroupCenterText:SetText("")

local GroupRightText = GroupFrame:CreateFontString("ARTWORK", nil, "GameFontWhite")
GroupRightText:SetTextColor(255, 255, 255)
GroupRightText:SetPoint("TOPLEFT", 120, -25)
GroupRightText:SetWidth(280)
GroupRightText:SetHeight(150)
GroupRightText:SetJustifyH("LEFT")
GroupRightText:SetJustifyV("TOP")
GroupRightText:SetText("")

local GroupButton = CreateFrame("Button", nil, GroupFrame)
GroupButton:SetWidth(GroupFrame:GetWidth())
GroupButton:SetHeight(GroupFrame:GetHeight())
GroupButton:SetPoint("TOPLEFT", 0, 0)
GroupButton:SetScript("OnClick", function(self, button)
    Addon.UpdateGroupFrame()
end)
GroupButton:SetScript("OnEnter", tooltipshow)
GroupButton:SetScript("OnLeave", tooltiphide)


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

local GuildButton = CreateFrame("Button", nil, GuildFrame)
GuildButton:SetWidth(GuildFrame:GetWidth())
GuildButton:SetHeight(GuildFrame:GetHeight())
GuildButton:SetPoint("TOPLEFT", 0, 0)
GuildButton:SetScript("OnClick", function(self, button)
    Addon.UpdateGuildFrame()
end)
GuildButton:SetScript("OnEnter", tooltipshow)
GuildButton:SetScript("OnLeave", tooltiphide)


local guild = {}
guild["title"] = GuildFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
guild["title"]:SetPoint("TOPLEFT", 5, -5)
guild["title"]:SetText(L["Guild"])

guild["text"] = GuildScrollChild:CreateFontString("ARTWORK", nil, "GameFontWhite")
guild["text"]:SetTextColor(255, 255, 255)
guild["text"]:SetPoint("TOPLEFT", 10, 0)
guild["text"]:SetWidth(GuildFrame:GetWidth())
guild["text"]:SetHeight(50)
guild["text"]:SetJustifyH("LEFT")
guild["text"]:SetJustifyV("TOP")
guild["text"]:SetText("")


function Addon.UpdateAltsFrame()
    local list = Addon.AltKeys or {}
    local sorted_table = {}
    for _, value in pairs(list) do
        table.insert(sorted_table, value)
    end
    table.sort(sorted_table, function(a, b) return a["current_keylevel"] > b["current_keylevel"] end)

    local leftParts = {}
    local centerParts = {}
    local centerRightParts = {}
    local rightParts = {}
    local lineCount = 0

    for _, value in pairs(sorted_table) do
        local key = value["fullname"]
        local entry = list[key]
        if not entry then break end

        -- left column
        local name = entry["name"] or ""
        if string.find(name, "-") then
            name, _ = strsplit("-", name)
        end
        name = string.sub(name, 1, 12) -- cut long name

        local color = ""
        if entry["class"] ~= "" then
            color = C_ClassColor.GetClassColor(entry["class"]):GenerateHexColorMarkup()
        end
        table.insert(leftParts, color .. name .. "|r \n")

        -- center column
        local keylevel = entry["current_keylevel"] or 0
        table.insert(centerParts, keylevel .. "\n")

        -- center-right column
        local keystoneMapName = ""
        if entry["current_key"] ~= "" then
            keystoneMapName = C_ChallengeMode.GetMapUIInfo(entry["current_key"]) or " "
        end
        if string.len(keystoneMapName) > 35 then
            keystoneMapName = string.sub(keystoneMapName, 1, 35) .. "..."
        end
        table.insert(centerRightParts, keystoneMapName .. "\n")

        -- right column
        local weeklybest = entry["weeklybest"] or ""
        local weeklycount = entry["weeklycount"] or ""
        if weeklybest ~= "" and weeklybest > 0 then
            weeklybest = "|cFFFFFFFFRuns(" .. weeklycount .. ") Best(" .. weeklybest .. ")|r"
        else
            weeklybest = "|cFFFF0000No Weekly Best|r"
        end
        table.insert(rightParts, weeklybest .. "\n")

        lineCount = lineCount + 1
    end

    -- resize: compute line height once, apply once after the loop
    local lineHeight = AltsLeftText:GetLineHeight()
    local totalHeight = 5 + lineCount * lineHeight
    AltsLeftText:SetHeight(totalHeight)
    AltsCenterText:SetHeight(totalHeight)
    AltsCenterRightText:SetHeight(totalHeight)
    AltsRightText:SetHeight(totalHeight)

    AltsLeftText:SetText(table.concat(leftParts))
    AltsCenterText:SetText(table.concat(centerParts))
    AltsCenterRightText:SetText(table.concat(centerRightParts))
    AltsRightText:SetText(table.concat(rightParts))
end

function Addon.UpdateGroupFrame()
    local leftParts = {}
    local centerParts = {}
    local rightParts = {}

    for char, value in pairs(Addon.PartyKeys) do
        -- left column
        local name = char or ""
        if string.find(name, "-") then
            name, _ = strsplit("-", name)
        end
        name = string.sub(name, 1, 12) -- cut long name

        local color = "|cFFFFFFFF"
        if value["class"] and value["class"] ~= "" then
            color = C_ClassColor.GetClassColor(value["class"]):GenerateHexColorMarkup()
        end
        table.insert(leftParts, color .. name .. "\n")

        -- center column
        local keylevel = value["current_keylevel"] or 0
        table.insert(centerParts, keylevel .. "\n")

        -- right column
        local keystoneMapName = ""
        if value["current_key"] then
            keystoneMapName = C_ChallengeMode.GetMapUIInfo(value["current_key"]) or " "
        end
        if string.len(keystoneMapName) > 25 then
            keystoneMapName = string.sub(keystoneMapName, 1, 25) .. "..."
        end
        table.insert(rightParts, keystoneMapName .. "\n")
    end

    GroupLeftText:SetText(table.concat(leftParts))
    GroupCenterText:SetText(table.concat(centerParts))
    GroupRightText:SetText(table.concat(rightParts))
end

local function formatText(obj)
    if not obj then return "" end
    local name = obj["name"] or ""
    name = string.sub(name, 1, 14) -- cut long name
    local color = "|cFFFFFFFF"
    if obj["class"] ~= "" then
        color = C_ClassColor.GetClassColor(obj["class"]):GenerateHexColorMarkup()
        name = color .. name .. "|r"
    end

    local keylevel = obj["current_keylevel"]
    -- not so proud of this
    if keylevel < 10 then
        keylevel = "      " .. keylevel
    else
        keylevel = "    " .. keylevel
    end
    -- returns formatted string
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

function Addon.UpdateGuildFrame()
    local textParts = {}
    local lineCount = 0
    if Addon.GuildKeys then
        local keys = tableGroupByKeyLevel(Addon.GuildKeys) or {}
        for keyid in pairs(keys) do
            local keystoneMapName = keyid and C_ChallengeMode.GetMapUIInfo(keyid) or " "
            table.insert(textParts, "  " .. keystoneMapName .. "\n")
            lineCount = lineCount + 1
            for _, entry in ipairs(keys[keyid]) do
                local charName = entry[1]
                table.insert(textParts, "  " .. formatText(Addon.GuildKeys[charName]) .. "\n")
                lineCount = lineCount + 1
            end
        end
    end
    -- resize: compute line height once, apply once after the loop
    local lineHeight = guild["text"]:GetLineHeight()
    guild["text"]:SetHeight(5 + lineCount * lineHeight)
    guild["text"]:SetText(table.concat(textParts))
end

function Addon.getTableKeys(t)
    local keys = ""
    if (type(t) == "table") then
        for key, _ in pairs(t) do
            keys = keys .. "|" .. key
        end
    end
    return keys
end

PVEFrame:SetScript("OnShow", function(...)
    -- Move raider io frame
    if RaiderIO_ProfileTooltip then
        RaiderIO_ProfileTooltip:SetPoint("TOPLEFT", PVEFrame:GetWidth() - GuildFrame:GetWidth() + 15, 0)
    end
    -- Move WTCompatibility frame
    if WTCompatibilityFrame then
        GuildFrame:SetPoint("TOPRIGHT", PVEFrame:GetWidth() - GuildFrame:GetWidth() + 240, 0)
    end
    -- Update Party
    Addon.PartyKeys = lib.getPartyKeystone()
    -- Update Guild
    Addon.GuildKeys = lib.getGuildKeystone()
    -- Update Alts
    Addon.AltKeys = lib.getAltsKeystone()
    -- Update frames
    Addon.UpdateGroupFrame()
    Addon.UpdateGuildFrame()
    Addon.UpdateAltsFrame()
end)


-- Update frame every 10 seconds
C_Timer.NewTicker(10, function()
    if PVEFrame:IsShown() then
        Addon.UpdateGroupFrame()
        Addon.UpdateGuildFrame()
        Addon.UpdateAltsFrame()
    end
end)

-- Update data every 1 second
C_Timer.NewTicker(1, function()
    -- Update Party
    Addon.PartyKeys = lib.getPartyKeystone()
    -- Update Guild
    Addon.GuildKeys = lib.getGuildKeystone()
    -- Update Alts
    Addon.AltKeys = lib.getAltsKeystone()
    -- Move raider io frame
    if RaiderIO_ProfileTooltip then
        RaiderIO_ProfileTooltip:SetPoint("TOPLEFT", PVEFrame:GetWidth() - GuildFrame:GetWidth() + 15, 0)
    end
end)
_G[ADDON] = Addon
