local myname, ns = ...
local L = ns.L

-- LibDataBroker launcher + LibDBIcon minimap button.
-- Gives a broker data source for Titan/Fubar/Bazooka and a standalone minimap
-- icon, both opening the guide. The minimap state lives in MythicDungeonNotesDB
-- (see GuideFrame.lua for the SavedVariables wiring).

local LDB     = LibStub("LibDataBroker-1.1", true)
local LDBIcon = LibStub("LibDBIcon-1.0", true)

local ICON = 525134  -- same icon as the addon and floating button

local dataobj

local function OnClick()
    if ns.Guide then ns.Guide:Toggle() end
end

local function OnTooltipShow(tt)
    tt:AddLine("Mythic Dungeon Notes", 1, 0.82, 0)
    tt:AddLine(L["GUIDE_tooltip_click"], 1, 1, 1)
end

local function Init()
    MythicDungeonNotesDB = MythicDungeonNotesDB or {}
    MythicDungeonNotesDB.minimap = MythicDungeonNotesDB.minimap or { hide = false }

    if LDB then
        dataobj = LDB:NewDataObject(myname, {
            type          = "launcher",
            text          = "Mythic Dungeon Notes",
            icon          = ICON,
            OnClick       = OnClick,
            OnTooltipShow = OnTooltipShow,
        })
    end

    if LDBIcon and dataobj then
        LDBIcon:Register(myname, dataobj, MythicDungeonNotesDB.minimap)
    end
end

local boot = CreateFrame("Frame")
boot:RegisterEvent("ADDON_LOADED")
boot:SetScript("OnEvent", function(self, _, name)
    if name == myname then
        Init()
        self:UnregisterAllEvents()
    end
end)
