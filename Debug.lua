local ADDON, Addon = ...

local lib = LibStub("LibMythicKeystone-1.0")
if not lib then return end

-- For debugging
Addon.debug = false

function Addon.Debug(o)
    if Addon.debug then
        DevTools_Dump(o)
    end
end

if Addon.debug then
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
    buttons[1]:SetText("Show Party")
    buttons[1]:SetScript("OnClick", function(self, button)
        Addon.Debug(Addon.PartyKeys)
    end)


    for key in pairs(buttons) do
        local startpos = -20 -40 * key
        buttons[key]:SetPoint("TOPLEFT", 0, startpos or 0)
        buttons[key]:SetSize(130, 40)
    end

end

_G[ADDON] = Addon
