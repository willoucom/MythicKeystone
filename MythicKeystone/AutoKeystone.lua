local ADDON, Addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON)
local button = {}

local OnShow = function()
    for bag = 0, NUM_BAG_SLOTS do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local item = C_Container.GetContainerItemInfo(bag, slot)
            if (item and item["hyperlink"]:match("keystone")) then
                C_Container.PickupContainerItem(bag, slot)
                if (CursorHasItem()) then
                    C_ChallengeMode.SlotKeystone()
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
            SendChatMessage(msg, IsInGroup(LE_PARTY_CATEGORY_HOME) and "PARTY" or "SAY")
        else
            msg = " ... " .. timer
            SendChatMessage(msg, IsInGroup(LE_PARTY_CATEGORY_HOME) and "PARTY" or "SAY")
            timer = timer - 1
            C_Timer.After(1, countdown)
        end
    else
        timer = -1
        msg = "" .. L["DungeonCountdownStop"]
        SendChatMessage(msg, IsInGroup(LE_PARTY_CATEGORY_HOME) and "PARTY" or "SAY")
    end
end

local OnEvent = function(self, event, adDon)
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
                SendChatMessage(msg, IsInGroup(LE_PARTY_CATEGORY_HOME) and "PARTY" or "SAY")
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
                    SendChatMessage(msg, IsInGroup(LE_PARTY_CATEGORY_HOME) and "PARTY" or "SAY")
                    C_Timer.After(1, countdown)
                    -- if UnitIsGroupLeader("player") then
                    --     C_PartyInfo.DoCountdown(5)
                    -- end
                    self:SetText(L["Countdown_cancel"])
                end
            else
                timer = -1
                self:SetText(L["Countdown"])
            end
        end)
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", OnEvent)
