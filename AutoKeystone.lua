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
end

local timer = 0
local function countdown()
    local msg = " ... " .. timer
    if timer <= 0 then
        msg = " Start"
        if IsInGroup(LE_PARTY_CATEGORY_HOME) then
            SendChatMessage(msg, "PARTY")
        end
        if (C_ChallengeMode.HasSlottedKeystone()) then
            C_ChallengeMode.StartChallengeMode()
        end
    else
        if timer <= 3 then
            if IsInGroup(LE_PARTY_CATEGORY_HOME) then
                SendChatMessage(msg, "PARTY")
            end
        end
        timer = timer - 1
        C_Timer.After(1, countdown)
    end
end

local OnEvent = function(self, event, adDon)
    if (adDon ~= "Blizzard_ChallengesUI") then
        return
    end
    if ChallengesKeystoneFrame then
        ChallengesKeystoneFrame:HookScript("OnShow", OnShow)
        self:UnregisterEvent(event)
        local button = {}
        -- Ready check button
        button[0] = CreateFrame("Button", nil, ChallengesKeystoneFrame, "UIPanelButtonTemplate")
        button[0]:SetText("Ready Check")
        button[0]:SetPoint("BOTTOMLEFT", 20, 20)
        button[0]:SetHeight(ChallengesKeystoneFrame.StartButton:GetHeight())
        button[0]:SetWidth(100)
        button[0]:SetScript("OnClick", function(self, button)
            DoReadyCheck()
        end)
        -- Countdown button
        button[1] = CreateFrame("Button", nil, ChallengesKeystoneFrame, "UIPanelButtonTemplate")
        button[1]:SetText("Countdown")
        button[1]:SetPoint("BOTTOMRIGHT", -20, 20)
        button[1]:SetHeight(ChallengesKeystoneFrame.StartButton:GetHeight())
        button[1]:SetWidth(100)
        button[1]:SetScript("OnClick", function(self, button)
            timer = 4
            C_Timer.After(1, countdown)
            if UnitIsGroupLeader("player") then
                C_PartyInfo.DoCountdown(5)
            end
        end)
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", OnEvent)
