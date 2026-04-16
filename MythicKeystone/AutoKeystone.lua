local ADDON, Addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON)
local button = {}
local isKeyOwner = false


local OnShow = function()
    for bag = 0, NUM_BAG_SLOTS do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local item = C_Container.GetContainerItemInfo(bag, slot)
            if (item and item["hyperlink"]:match("keystone")) then
                C_Container.PickupContainerItem(bag, slot)
                if (CursorHasItem()) then
                    C_ChallengeMode.SlotKeystone()
                    isKeyOwner = true
                end
            end
        end
    end
    if (not ChallengesKeystoneFrame:IsMovable()) then
        ChallengesKeystoneFrame:SetFrameLevel(1000)
        ChallengesKeystoneFrame:SetMovable(true)
        ChallengesKeystoneFrame:SetClampedToScreen(true)
        ChallengesKeystoneFrame:RegisterForDrag("LeftButton")
        ChallengesKeystoneFrame:SetScript("OnDragStart", ChallengesKeystoneFrame.StartMoving)
        ChallengesKeystoneFrame:SetScript("OnDragStop", ChallengesKeystoneFrame.StopMovingOrSizing)
    end
    button[1]:SetText(L["Countdown"])
end

local timer = -1
local function countdown()
    local msg = ""
    if (C_ChallengeMode.HasSlottedKeystone()) and timer >= 0 then
        if timer == 0 then
            -- Start challenge
            C_ChallengeMode.StartChallengeMode()
            ChallengesKeystoneFrame:Hide()
            -- Send message
            msg = "" .. L["DungeonStarted"]
            C_ChatInfo.SendChatMessage(msg, IsInGroup(LE_PARTY_CATEGORY_HOME) and "PARTY" or "SAY")
        else
            msg = " ... " .. timer
            C_ChatInfo.SendChatMessage(msg, IsInGroup(LE_PARTY_CATEGORY_HOME) and "PARTY" or "SAY")
            timer = timer - 1
            C_Timer.After(1, countdown)
        end
    else
        timer = -1
        msg = "" .. L["DungeonCountdownStop"]
        C_ChatInfo.SendChatMessage(msg, IsInGroup(LE_PARTY_CATEGORY_HOME) and "PARTY" or "SAY")
    end
end

local OnEvent = function(self, event, ...)
    if event == "CHALLENGE_MODE_RESET" then
        isKeyOwner = false
        return
    end
    if event == "CHALLENGE_MODE_COMPLETED" then
        if isKeyOwner then
            isKeyOwner = false
            if MythicKeystoneDB and MythicKeystoneDB.completionMessage then
                local completionInfo = C_ChallengeMode.GetChallengeCompletionInfo()
                local msgs = (completionInfo and completionInfo.onTime) and Addon.completionMessagesSuccess or Addon.completionMessagesFailure
                C_ChatInfo.SendChatMessage(msgs[math.random(#msgs)], IsInGroup(LE_PARTY_CATEGORY_HOME) and "PARTY" or "SAY")
            end
        end
        return
    end
    local adDon = ...
    if (adDon ~= "Blizzard_ChallengesUI") then
        return
    end
    if ChallengesKeystoneFrame then
        ChallengesKeystoneFrame:HookScript("OnShow", OnShow)
        self:UnregisterEvent(event)

        -- Ready check button
        button[0] = CreateFrame("Button", nil, ChallengesKeystoneFrame, "UIPanelButtonTemplate")
        button[0]:SetText(L["ReadyCheck"])
        button[0]:SetPoint("BOTTOMLEFT", 20, 20)
        button[0]:SetHeight(ChallengesKeystoneFrame.StartButton:GetHeight())
        button[0]:SetWidth(100)
        button[0]:SetScript("OnClick", function(self, button)
            if UnitIsGroupLeader("player") then
                DoReadyCheck()
            else
                local msg = ""..L["Ready"]
                C_ChatInfo.SendChatMessage(msg, IsInGroup(LE_PARTY_CATEGORY_HOME) and "PARTY" or "SAY")
            end
        end)
        -- Countdown button
        button[1] = CreateFrame("Button", nil, ChallengesKeystoneFrame, "UIPanelButtonTemplate")
        button[1]:SetText(L["Countdown"])
        button[1]:SetPoint("BOTTOMRIGHT", -20, 20)
        button[1]:SetHeight(ChallengesKeystoneFrame.StartButton:GetHeight())
        button[1]:SetWidth(100)
        button[1]:SetScript("OnClick", function(self, button)
            if timer == -1 then
                if (C_ChallengeMode.HasSlottedKeystone()) then
                    timer = 4
                    local msg = "" .. L["DungeonCountdown"] .. ""
                    C_ChatInfo.SendChatMessage(msg, IsInGroup(LE_PARTY_CATEGORY_HOME) and "PARTY" or "SAY")
                    C_Timer.After(1, countdown)
                    C_PartyInfo.DoCountdown(5)
                    self:SetText(L["Countdown_cancel"])
                end
            else
                timer = -1
                self:SetText(L["Countdown"])
            end
        end)

        -- Options panel to the right of ChallengesKeystoneFrame
        local optionsPanel = CreateFrame("Frame", nil, ChallengesKeystoneFrame, "BackdropTemplate")
        optionsPanel:SetWidth(220)
        optionsPanel:SetHeight(ChallengesKeystoneFrame:GetHeight())
        optionsPanel:SetPoint("LEFT", ChallengesKeystoneFrame, "RIGHT", 5, 0)
        optionsPanel:SetBackdrop(BACKDROP_TUTORIAL_16_16) ---@diagnostic disable-line: param-type-mismatch
        optionsPanel:SetAlpha(0.9)

        local optionsTitle = optionsPanel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        optionsTitle:SetPoint("TOPLEFT", 8, -8)
        optionsTitle:SetText(L["Options"])

        -- Checkbox: send chat message on challenge completion
        local chkCompletion = CreateFrame("CheckButton", nil, optionsPanel, "UICheckButtonTemplate")
        chkCompletion:SetPoint("TOPLEFT", 4, -32)
        chkCompletion.text:SetText(L["CompletionMessage"])
        chkCompletion:SetChecked(MythicKeystoneDB and MythicKeystoneDB.completionMessage == true)
        chkCompletion:SetScript("OnClick", function(self)
            MythicKeystoneDB = MythicKeystoneDB or {}
            MythicKeystoneDB.completionMessage = self:GetChecked()
        end)
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("CHALLENGE_MODE_RESET")
frame:RegisterEvent("CHALLENGE_MODE_COMPLETED")
frame:SetScript("OnEvent", OnEvent)
