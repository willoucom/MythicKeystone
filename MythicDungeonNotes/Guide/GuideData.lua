local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Guide data table
-- Populated by individual files in Guide/Dungeons/*.lua (loaded after this one).
-------------------------------------------------------------------------------

ns.guideData = {}

-------------------------------------------------------------------------------
-- Helper: find dungeon by uiMapId
-------------------------------------------------------------------------------

function ns.Spell(id)
    local info    = C_Spell.GetSpellInfo(id)
    local name    = (info and info.name) or "?"
    local iconID  = info and info.iconID
    local iconStr = iconID and ("|T" .. iconID .. ":16:16:0:0|t") or ""
    return iconStr .. "|cff71d5ff|Hspell:" .. id .. "|h[" .. name .. "]|h|r"
end

function ns.NPC(id, name)
    return "|cffffcc00|Hnpc:" .. id .. "|h[" .. (name or "?") .. "]|h|r"
end

function ns.GetDungeonByMapId(mapId)
    if not mapId then return nil end
    for _, dungeon in ipairs(ns.guideData) do
        for _, id in ipairs(dungeon.mapIds) do
            if id == mapId then return dungeon end
        end
    end
    return nil
end
