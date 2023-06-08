local ADDON, Addon = ...

local lib = LibStub("LibMythicKeystone-1.0")
if not lib then return end

function Addon.Debug(o)
    if Addon.debug then
        DevTools_Dump(o)
    end
end

-- For debugging
local LibMythicKeystoneDebug = CreateFrame("Frame")
LibMythicKeystoneDebug:RegisterEvent("ADDON_LOADED")
LibMythicKeystoneDebug:SetScript("OnEvent", function(self, event, addOnName, ...)
    if addOnName == "MythicKeystone" then
        if LibMythicKeystoneDB then
            if not LibMythicKeystoneDB["options"] then
                LibMythicKeystoneDB["options"] = {}
            end
            if not LibMythicKeystoneDB["options"]["debug"] then
                LibMythicKeystoneDB["options"]["debug"] = false
            end
        end
        Addon.debug = LibMythicKeystoneDB["options"]["debug"] or false
    end
    if Addon.debug then
        local f = CreateFrame("Frame", nil)
        local t = f:CreateTexture(nil, "BACKGROUND")
        f:SetPoint("CENTER")
        f:SetSize(UIParent:GetWidth(), UIParent:GetHeight())
        t:SetAllPoints()
        t:SetColorTexture(0, 0, 0, 1)
        f:Hide()

        local Debug = CreateFrame("Frame", nil, PVEFrame, "BackdropTemplate")
        Debug:SetPoint("TOPLEFT", -140, 0)
        Debug:SetSize(400, 400)

        local buttons = {}
        buttons[0] = CreateFrame("Button", nil, Debug, "UIPanelButtonTemplate")
        buttons[0]:SetText("Refresh")
        buttons[0]:SetScript("OnClick", function(self, button)
            Addon.UpdateGroupFrame()
            Addon.UpdateAltsFrame()
        end)
        buttons[1] = CreateFrame("Button", nil, Debug, "UIPanelButtonTemplate")
        buttons[1]:SetText("BG")
        buttons[1]:SetScript("OnClick", function(self, button)
            if f:IsShown() then
                f:Hide()
            else
                f:Show()
            end
        end)

        buttons[2] = CreateFrame("Button", nil, Debug, "UIPanelButtonTemplate")
        buttons[2]:SetText("Show Party")
        buttons[2]:SetScript("OnClick", function(self, button)
            Addon.Debug(Addon.PartyKeys)
        end)

        buttons[3] = CreateFrame("Button", nil, Debug, "UIPanelButtonTemplate")
        buttons[3]:SetText("Concat Party")
        buttons[3]:SetScript("OnClick", function(self, button)
            Addon.Debug(table.concat(Addon.getTableKeys(Addon.PartyKeys), " "))
        end)

        for key in pairs(buttons) do
            local startpos = -20 - 40 * key
            buttons[key]:SetPoint("TOPLEFT", 0, startpos or 0)
            buttons[key]:SetSize(130, 40)
        end
    end
end)

_G[ADDON] = Addon
