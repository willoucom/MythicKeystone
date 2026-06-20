local ADDON, Addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON)

-- Option key -> default value. Keys double as MythicKeystoneDB fields.
local DEFAULTS = {
    showAlts        = true,
    showGroup       = true,
    showGuild       = true,
    teleportVisible = true,
    autoSlot        = true,
    showReadyCheck  = true,
    showCountdown   = true,
}

-- Apply helpers (defined in the other modules; guarded in case a module is absent).
-- All take (value) for a uniform callback signature; panel/button helpers ignore it.
local function applyPanels(_)      if Addon.ApplyPanelVisibility then Addon.ApplyPanelVisibility() end end
local function applyAutoButtons(_) if Addon.ApplyAutoKeystoneButtons then Addon.ApplyAutoKeystoneButtons() end end
local function applyTeleports(value) if Addon.SetTeleportVisible then Addon.SetTeleportVisible(value) end end

-- { dbKey, nameLocaleKey, tooltipLocaleKey, onChange(value) }
local OPTIONS = {
    { "showAlts",        "OPT_showAlts",   "OPT_showAlts_tip",   applyPanels },
    { "showGroup",       "OPT_showGroup",  "OPT_showGroup_tip",  applyPanels },
    { "showGuild",       "OPT_showGuild",  "OPT_showGuild_tip",  applyPanels },
    { "teleportVisible", "OPT_teleports",  "OPT_teleports_tip",  applyTeleports },
    { "autoSlot",        "OPT_autoSlot",   "OPT_autoSlot_tip",   nil },
    { "showReadyCheck",  "OPT_readyCheck", "OPT_readyCheck_tip", applyAutoButtons },
    { "showCountdown",   "OPT_countdown",  "OPT_countdown_tip",  applyAutoButtons },
}

local function buildPanel()
    MythicKeystoneDB = MythicKeystoneDB or {}
    for key, default in pairs(DEFAULTS) do
        if MythicKeystoneDB[key] == nil then MythicKeystoneDB[key] = default end
    end

    local category = Settings.RegisterVerticalLayoutCategory(Addon.Name or "MythicKeystone")

    for _, opt in ipairs(OPTIONS) do
        local key, nameKey, tipKey, onChange = opt[1], opt[2], opt[3], opt[4]
        -- RegisterAddOnSetting(category, variable, variableKey, variableTbl, variableType, name, default)
        local setting = Settings.RegisterAddOnSetting(
            category, "MythicKeystone_" .. key, key, MythicKeystoneDB,
            Settings.VarType.Boolean, L[nameKey], DEFAULTS[key])
        Settings.CreateCheckbox(category, setting, L[tipKey])
        if onChange and setting.SetValueChangedCallback then
            setting:SetValueChangedCallback(function(_, value) onChange(value) end)
        end
    end

    Settings.RegisterAddOnCategory(category)
    Addon.settingsCategory = category
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("PLAYER_LOGIN")
loader:SetScript("OnEvent", function(self)
    self:UnregisterEvent("PLAYER_LOGIN")
    if Settings and Settings.RegisterVerticalLayoutCategory then
        buildPanel()
    end
end)

-- Convenience: open the options panel.
SLASH_MKCONFIG1 = "/mkconfig"
SlashCmdList["MKCONFIG"] = function()
    if Addon.settingsCategory and Settings and Settings.OpenToCategory then
        Settings.OpenToCategory(Addon.settingsCategory:GetID())
    end
end
