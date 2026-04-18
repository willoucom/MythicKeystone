local _ = ...

local DUNGEON_ID_FIELDS = { "mapId", "challengeMapID", "dungeonID", "mapID" }

-- challengeMapID -> teleport spellID, sourced from MythicDungeonNotes dungeon definitions.
local TELEPORT_SPELLS = {
    [239] = 1254551, -- Siège du Triumvirat
    [161] = 159898,  -- Orée-du-ciel
    [560] = 1254559, -- Cavernes de Maisara
    [402] = 393273,  -- Académie Algethar
    [557] = 1254400, -- Coursevent (Windrunner Spire)
    [556] = 1254555, -- Fosse de Saron
    [558] = 1254572, -- Terrasse des Magistères
    [559] = 1254563, -- Point Nexus Xenas
}

local function findDungeonFrames()
    local found = {}
    if not ChallengesFrame then return found end
    for i = 1, ChallengesFrame:GetNumChildren() do
        local child = select(i, ChallengesFrame:GetChildren())
        for _, field in ipairs(DUNGEON_ID_FIELDS) do
            local v = child[field]
            if type(v) == "number" and v > 0 then
                tinsert(found, { frame = child, mapID = v })
                break
            end
        end
    end
    return found
end

local initialized = false
local teleportButtons = {}
local teleportVisible = true

local function createTeleportButton(dungeonFrame, mapID)
    local spellID = TELEPORT_SPELLS[mapID]
    if not spellID then return end

    local spellInfo = C_Spell.GetSpellInfo(spellID)
    if not C_SpellBook.IsSpellInSpellBook(spellID) then return end

    local btn = CreateFrame("Button", nil, UIParent, "SecureActionButtonTemplate")
    btn:SetSize(22, 22)
    btn:SetPoint("BOTTOMRIGHT", dungeonFrame, "BOTTOMRIGHT", -2, 2)
    btn:SetFrameStrata("HIGH")
    btn:EnableMouse(true)
    btn:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
    btn:SetAttribute("type", "macro")
    btn:SetAttribute("macrotext", "/cast " .. (spellInfo and spellInfo.name or ""))

    local icon = btn:CreateTexture(nil, "ARTWORK")
    icon:SetAllPoints()
    icon:SetTexture("interface/icons/spell_animabastion_nova")
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

    local highlight = btn:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetAllPoints()
    highlight:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
    highlight:SetBlendMode("ADD")

    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetHyperlink("spell:" .. spellID)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    ChallengesFrame:HookScript("OnShow", function()
        btn:SetShown(teleportVisible and C_SpellBook.IsSpellInSpellBook(spellID))
    end)
    ChallengesFrame:HookScript("OnHide", function()
        btn:Hide()
    end)

    btn:SetShown(teleportVisible and C_SpellBook.IsSpellInSpellBook(spellID))
    return btn
end

------------------------------------------------
local function setTeleportVisible(visible)
    teleportVisible = visible
    MythicKeystoneDB = MythicKeystoneDB or {}
    MythicKeystoneDB.teleportVisible = visible
    for _, btn in pairs(teleportButtons) do
        btn:SetShown(visible)
    end
end

local function createToggleButton()
    local toggle = CreateFrame("Button", nil, UIParent)
    toggle:SetSize(18, 18)
    toggle:SetPoint("TOPRIGHT", ChallengesFrame, "TOPRIGHT", -2, -26)
    toggle:SetFrameStrata("HIGH")
    toggle:EnableMouse(true)

    local icon = toggle:CreateTexture(nil, "ARTWORK")
    icon:SetAllPoints()
    icon:SetTexture("interface/icons/spell_animabastion_nova")
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

    local highlight = toggle:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetAllPoints()
    highlight:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
    highlight:SetBlendMode("ADD")

    local function updateToggle()
        if teleportVisible then
            icon:SetDesaturated(true)
            icon:SetAlpha(0.7)
            icon:SetVertexColor(1, 1, 1)
        else
            icon:SetDesaturated(false)
            icon:SetAlpha(1)
            icon:SetVertexColor(1, 1, 1)
        end
    end

    toggle:SetScript("OnClick", function()
        setTeleportVisible(not teleportVisible)
        updateToggle()
        if GameTooltip:IsOwned(toggle) then
            GameTooltip:SetText(teleportVisible and "Masquer les téléports" or "Afficher les téléports", 1, 1, 1)
        end
    end)
    toggle:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
        GameTooltip:SetText(teleportVisible and "Masquer les téléports" or "Afficher les téléports", 1, 1, 1)
        GameTooltip:Show()
    end)
    toggle:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    ChallengesFrame:HookScript("OnShow", function() toggle:Show() end)
    ChallengesFrame:HookScript("OnHide", function() toggle:Hide() end)

    updateToggle()
    return toggle
end

local function initTeleportButtons()
    if initialized then return end

    MythicKeystoneDB = MythicKeystoneDB or {}
    if MythicKeystoneDB.teleportVisible ~= nil then
        teleportVisible = MythicKeystoneDB.teleportVisible
    end

    local entries = findDungeonFrames()
    if #entries == 0 then return end

    for _, entry in ipairs(entries) do
        local btn = createTeleportButton(entry.frame, entry.mapID)
        if btn then
            teleportButtons[entry.mapID] = btn
        end
    end

    initialized = next(teleportButtons) ~= nil
    if initialized then
        createToggleButton()
    end
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self, _, addonName)
    if addonName ~= "Blizzard_ChallengesUI" then return end
    self:UnregisterEvent("ADDON_LOADED")
    ChallengesFrame:HookScript("OnShow", function()
        C_Timer.After(0.1, initTeleportButtons)
    end)
end)

------------------------------------------------
SLASH_MKTELE1 = "/mktele"
SlashCmdList["MKTELE"] = function(msg)
    msg = msg and msg:lower() or ""

    if msg == "debug" then
        if not ChallengesFrame then
            print("|cFF00CCFFMKTele|r ChallengesFrame non chargé — ouvre l'onglet M+ d'abord.")
            return
        end
        local count = 0
        for _ in pairs(teleportButtons) do count = count + 1 end
        print("|cFF00CCFFMKTele|r initialized=" .. tostring(initialized) .. " boutons=" .. count)
        for _, e in ipairs(findDungeonFrames()) do
            local spellID = TELEPORT_SPELLS[e.mapID]
            local known = spellID and C_SpellBook.IsSpellInSpellBook(spellID)
            local btn = teleportButtons[e.mapID]
            print(string.format("  mapID=%-4d spellID=%-8s known=%-5s btn=%s shown=%s",
                e.mapID, tostring(spellID), tostring(known),
                btn and "oui" or "non",
                btn and tostring(btn:IsShown()) or "n/a"))
        end

    elseif msg == "reset" then
        initialized = false
        wipe(teleportButtons)
        initTeleportButtons()
        local count = 0
        for _ in pairs(teleportButtons) do count = count + 1 end
        print("|cFF00CCFFMKTele|r reset — " .. count .. " boutons.")

    else
        print("|cFF00CCFFMKTele|r /mktele debug | reset")
    end
end
