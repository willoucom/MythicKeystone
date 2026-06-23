local myname, ns = ...
local L = ns.L

-- Blizzard Settings panel for Mythic Dungeon Notes.
-- Mirrors MythicKeystone/Options.lua: registers a vertical-layout category with
-- one checkbox per option. Keys double as MythicDungeonNotesDB fields.

-- Option key -> default value.
local DEFAULTS = {
    showButton  = true,   -- floating toggle button (GuideFrame.lua)
    showMinimap = true,   -- LibDBIcon minimap button (Launcher.lua)
}

-- Apply helpers (defined in the other modules; guarded in case a module is absent).
local function applyButton(value)  if ns.SetButtonVisible  then ns.SetButtonVisible(value)  end end
local function applyMinimap(value) if ns.SetMinimapVisible then ns.SetMinimapVisible(value) end end

-- { dbKey, nameLocaleKey, tooltipLocaleKey, onChange(value) }
local OPTIONS = {
    { "showButton",  "OPT_showButton",  "OPT_showButton_tip",  applyButton },
    { "showMinimap", "OPT_showMinimap", "OPT_showMinimap_tip", applyMinimap },
}

local function buildPanel()
    MythicDungeonNotesDB = MythicDungeonNotesDB or {}
    for key, default in pairs(DEFAULTS) do
        if MythicDungeonNotesDB[key] == nil then MythicDungeonNotesDB[key] = default end
    end

    local category = Settings.RegisterVerticalLayoutCategory("Mythic Dungeon Notes")

    for _, opt in ipairs(OPTIONS) do
        local key, nameKey, tipKey, onChange = opt[1], opt[2], opt[3], opt[4]
        -- RegisterAddOnSetting(category, variable, variableKey, variableTbl, variableType, name, default)
        local setting = Settings.RegisterAddOnSetting(
            category, "MythicDungeonNotes_" .. key, key, MythicDungeonNotesDB,
            Settings.VarType.Boolean, L[nameKey], DEFAULTS[key])
        Settings.CreateCheckbox(category, setting, L[tipKey])
        if onChange and setting.SetValueChangedCallback then
            setting:SetValueChangedCallback(function(_, value) onChange(value) end)
        end
    end

    Settings.RegisterAddOnCategory(category)
    ns.settingsCategory = category
end

-- Open the options panel (used by the gear button in the guide window).
function ns.OpenOptions()
    if ns.settingsCategory and Settings and Settings.OpenToCategory then
        Settings.OpenToCategory(ns.settingsCategory:GetID())
    end
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("PLAYER_LOGIN")
loader:SetScript("OnEvent", function(self)
    self:UnregisterEvent("PLAYER_LOGIN")
    if Settings and Settings.RegisterVerticalLayoutCategory then
        buildPanel()
    end
end)

-- Convenience: open the options panel from chat.
SLASH_MDNCONFIG1 = "/mdn"
SLASH_MDNCONFIG2 = "/mdnconfig"
SlashCmdList["MDNCONFIG"] = function()
    ns.OpenOptions()
end
