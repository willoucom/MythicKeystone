local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Module
-------------------------------------------------------------------------------

local Guide = {}
ns.Guide = Guide

-------------------------------------------------------------------------------
-- Layout constants
-------------------------------------------------------------------------------

local WIN_W     = 1100   -- ~3× the original 380
local WIN_H     = 560
local BTN_SIZE  = 44

local MARGIN    = 8
local TITLE_H   = 30
local DNAME_H   = 26     -- dungeon name row (dungeon view only)
local SEP_H     = 1
local LEFT_W    = 250    -- left column (section menu)
local DIV_W      = 1      -- column divider
local INDENT     = 14     -- tip indent in right column
-- UIPanelScrollFrameTemplate positions its scrollbar OUTSIDE the scroll frame
-- (to the right). SCROLLBAR_W reserves that space inside the window.
local SCROLLBAR_W = 22

-- Y offsets from top of GuideWin (negative = downward)
local Y_SEP1   = TITLE_H                               -- 30
local Y_DNAME  = TITLE_H + SEP_H                      -- 31
local Y_SEP2   = TITLE_H + SEP_H + DNAME_H            -- 57
local Y_COLS   = TITLE_H + SEP_H + DNAME_H + SEP_H   -- 58  (columns start here)
local Y_LIST   = TITLE_H + SEP_H                      -- 31  (list starts here)

-- Right column: starts after left col + divider + small gap
local RIGHT_X  = MARGIN + LEFT_W + DIV_W + 4          -- 263

-- Content widths inside scroll frames
-- = scroll frame width - SCROLLBAR_W (scrollbar) - 4 (inner gap)
local LIST_CW  = WIN_W - 2 * MARGIN - SCROLLBAR_W - 4          -- 1064
local LEFT_CW  = LEFT_W - SCROLLBAR_W - 4                      -- 230
local RIGHT_CW = WIN_W - RIGHT_X - MARGIN - SCROLLBAR_W - 4    -- 805

-- Thumbnail grid (list view)
local THUMB_W    = 250
local THUMB_H    = 120
local THUMB_GAP  = 10
local THUMB_COLS = math.max(1, math.floor((LIST_CW + THUMB_GAP) / (THUMB_W + THUMB_GAP)))

-------------------------------------------------------------------------------
-- State
-------------------------------------------------------------------------------

local GuideBtn       -- floating toggle button
local GuideWin       -- main window
local BackBtn        -- "< Liste" button in title bar

-- Layout frames (created once, shown/hidden per view)
local DungeonHeader     -- frame: dungeon name row (dungeon view)
local DungeonHeaderFS   -- fontstring inside DungeonHeader
local ColDivider        -- vertical line between columns
local ListScroll,  ListContent    -- full-width scroll (list view)
local LeftScroll,  LeftContent    -- left column: section menu (dungeon view)
local RightScroll                 -- right column: section detail (dungeon view)
local RightContent                -- wrapper frame, direct scroll child of RightScroll
local RightHTML                   -- SimpleHTML widget, child of RightContent

local isVisible       = false
local zoneDungeon     = nil
local selectedDungeon = nil
local selectedSection = nil
local forceList       = false   -- true when the user explicitly navigated back to the list
local currentMenuBtn  = nil   -- currently selected menu button
local ListSepTex      = nil   -- horizontal separator in list view (created lazily)
local RightBg         = nil   -- background texture for right panel (dungeon view)

-------------------------------------------------------------------------------
-- Generic pool helpers
-- FontStrings and Buttons cannot be destroyed in WoW — we hide and reuse them.
-- Pools are keyed by their parent content frame so objects are never
-- re-parented (WoW does not support re-parenting).
-------------------------------------------------------------------------------

local fsPool        = {}  -- fsPool[contentFrame]  = { free={}, used={} }
local btnPool       = {}  -- btnPool[contentFrame] = { free={}, used={} }
local thumbPool     = {}  -- thumbPool[contentFrame] = { free={}, used={} } (vignette buttons)
local NewThumbnailBtn     -- forward declaration; defined in "Button factories" below

local function FSGet(parent, fontObj)
    if not fsPool[parent] then fsPool[parent] = { free = {}, used = {} } end
    local p = fsPool[parent]
    local fs
    if #p.free > 0 then
        fs = table.remove(p.free)
        fs:SetFontObject(_G[fontObj] or GameFontNormal)
        fs:SetTextColor(1, 1, 1)
        fs:Show()
    else
        fs = parent:CreateFontString(nil, "OVERLAY", fontObj)
        fs:SetWordWrap(true)
        fs:SetSpacing(1)
    end
    table.insert(p.used, fs)
    return fs
end

local function FSFlush(parent)
    local p = fsPool[parent]
    if not p then return end
    for _, fs in ipairs(p.used) do
        fs:Hide()
        fs:ClearAllPoints()
        table.insert(p.free, fs)
    end
    wipe(p.used)
end

local function BtnGet(parent, createFn)
    if not btnPool[parent] then btnPool[parent] = { free = {}, used = {} } end
    local p = btnPool[parent]
    local btn
    if #p.free > 0 then
        btn = table.remove(p.free)
        btn:SetScript("OnClick", nil)
        btn:Show()
    else
        btn = createFn(parent)
    end
    table.insert(p.used, btn)
    return btn
end

local function BtnFlush(parent)
    local p = btnPool[parent]
    if not p then return end
    for _, btn in ipairs(p.used) do
        btn:Hide()
        btn:ClearAllPoints()
        btn:SetScript("OnClick", nil)
        table.insert(p.free, btn)
    end
    wipe(p.used)
end

local function ThumbBtnGet(parent)
    if not thumbPool[parent] then thumbPool[parent] = { free = {}, used = {} } end
    local p = thumbPool[parent]
    local btn
    if #p.free > 0 then
        btn = table.remove(p.free)
        btn:Show()
    else
        btn = NewThumbnailBtn(parent)  -- forward declaration; defined below
    end
    table.insert(p.used, btn)
    return btn
end

local function ThumbBtnFlush(parent)
    local p = thumbPool[parent]
    if not p then return end
    for _, btn in ipairs(p.used) do
        btn:Hide()
        btn:ClearAllPoints()
        btn:SetHitRectInsets(0, 0, 0, 0)
        btn:SetScript("OnClick", nil)
        -- vigClip and portalBtn are siblings (parented to ListContent),
        -- not children of btn, so they must be hidden/cleared explicitly.
        btn.vigClip:Hide()
        btn.vigClip:ClearAllPoints()
        btn.portalBtn:Hide()
        btn.portalBtn:ClearAllPoints()
        btn.portalBtn:SetScript("OnEnter", nil)
        btn.portalBtn:SetScript("OnLeave", nil)
        table.insert(p.free, btn)
    end
    wipe(p.used)
end

-------------------------------------------------------------------------------
-- Button factories (called once per new button, then the button is recycled)
-------------------------------------------------------------------------------

local function NewMenuBtn(parent)
    local btn = CreateFrame("Button", nil, parent)
    btn:SetHeight(28)
    btn:EnableMouse(true)
    btn:RegisterForClicks("LeftButtonUp")

    -- Selection background (visible when this section is active)
    local selBg = btn:CreateTexture(nil, "BACKGROUND")
    selBg:SetAllPoints()
    selBg:SetColorTexture(0.20, 0.40, 0.70, 0.22)
    selBg:Hide()
    btn.selBg = selBg

    -- Hover highlight
    local hl = btn:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints()
    hl:SetColorTexture(0.30, 0.55, 0.90, 0.20)

    -- Section name label
    local label = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("LEFT",  8, 0)
    label:SetPoint("RIGHT", -4, 0)
    label:SetJustifyH("LEFT")
    label:SetWordWrap(false)
    btn.label = label

    return btn
end

local function NewRowBtn(parent)
    local btn = CreateFrame("Button", nil, parent)
    btn:SetHeight(26)
    btn:EnableMouse(true)
    btn:RegisterForClicks("LeftButtonUp")

    local hl = btn:CreateTexture(nil, "HIGHLIGHT")
    hl:SetPoint("TOPLEFT",      1, -1)
    hl:SetPoint("BOTTOMRIGHT", -1,  1)
    hl:SetColorTexture(0.30, 0.55, 0.90, 0.20)

    local abbr = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    abbr:SetPoint("LEFT", 0, 0)
    abbr:SetWidth(44)
    abbr:SetJustifyH("LEFT")
    btn.abbr = abbr

    local label = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("LEFT", 48, 0)
    label:SetJustifyH("LEFT")
    btn.label = label

    return btn
end

-- Thumbnail button used in the dungeon list grid view.
-- Children are anchored relative to the button; only SetText/SetTexture/Show/Hide
-- are needed when recycling from the pool.
NewThumbnailBtn = function(parent)
    -- Three sibling frames, all children of `parent`, with explicit FrameLevels:
    --   vigClip  (L+1) — clips the vignette texture, drawn first (behind everything)
    --   btn      (L+2) — interactive button with icon/label overlays
    --   portalBtn(L+3) — teleport button, drawn on top of btn's gradient bar
    -- This avoids the SetClipsChildren screen-space scissor bug: applying it on btn
    -- would clip siblings (portalBtn) in the same screen rect.

    -- 1. Vignette clip frame — lowest level, just holds the background texture
    local vigClip = CreateFrame("Frame", nil, parent)
    vigClip:SetSize(THUMB_W, THUMB_H)
    vigClip:SetClipsChildren(true)
    vigClip:Hide()  -- shown + positioned in RenderThumbnailGrid
    local vignetteTex = vigClip:CreateTexture(nil, "BACKGROUND")
    vignetteTex:SetPoint("CENTER", vigClip, "CENTER")

    -- 2. Main button — above vigClip so its OVERLAY regions (icon, label) are visible
    local btn = CreateFrame("Button", nil, parent)
    btn:SetFrameLevel(vigClip:GetFrameLevel() + 1)
    btn:SetSize(THUMB_W, THUMB_H)
    btn:EnableMouse(true)
    btn:RegisterForClicks("LeftButtonUp")
    -- Hit rect is set dynamically in RenderThumbnailGrid:
    --   hasPortal → insets(0,0,0,44): top part opens guide, bottom bar is portalBtn
    --   no portal → insets(0,0,0,0):  entire vignette opens guide

    btn.vignetteTex = vignetteTex
    btn.vigClip     = vigClip

    -- Dark gradient at the bottom for text readability
    local bottomGrad = btn:CreateTexture(nil, "BORDER")
    bottomGrad:SetPoint("BOTTOMLEFT")
    bottomGrad:SetPoint("BOTTOMRIGHT")
    bottomGrad:SetHeight(44)
    bottomGrad:SetColorTexture(0, 0, 0, 0.72)

    -- "Coming soon" dim overlay (shown when no guide data available)
    local dimOverlay = btn:CreateTexture(nil, "ARTWORK")
    dimOverlay:SetAllPoints()
    dimOverlay:SetColorTexture(0, 0, 0, 0.55)
    dimOverlay:Hide()
    btn.dimOverlay = dimOverlay

    -- Hover highlight
    local hl = btn:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints()
    hl:SetColorTexture(1, 1, 1, 0.12)

    -- Dungeon icon (24 × 24) at bottom-left
    local iconTex = btn:CreateTexture(nil, "OVERLAY")
    iconTex:SetPoint("BOTTOMLEFT", 6, 10)
    iconTex:SetSize(24, 24)
    btn.iconTex = iconTex

    -- Dungeon name label, to the right of the icon
    -- Right anchor leaves room for the optional portal icon button (-30)
    local label = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("BOTTOMLEFT",  36, 12)
    label:SetPoint("BOTTOMRIGHT", -30, 12)
    label:SetJustifyH("LEFT")
    label:SetWordWrap(false)
    btn.label = label

    -- "À venir" text (centered, shown when no data)
    local comingSoon = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    comingSoon:SetAllPoints()
    comingSoon:SetJustifyH("CENTER")
    comingSoon:SetJustifyV("MIDDLE")
    comingSoon:SetText("|cffAAAAAA" .. L["GUIDE_coming_soon"] .. "|r")
    comingSoon:Hide()
    btn.comingSoon = comingSoon

    -- 3. Portal button — covers the full bottom bar (THUMB_W × 44).
    -- Parented to `parent` (ListContent), NOT to btn: secure buttons must not be
    -- children of another Button in WoW. Hit rect on btn is set dynamically so
    -- that clicks on the bar pass through to portalBtn when the portal is active.
    local portalBtn = CreateFrame("Button", nil, parent, "InsecureActionButtonTemplate")
    portalBtn:SetFrameLevel(btn:GetFrameLevel() + 1)
    portalBtn:SetSize(THUMB_W, 44)
    portalBtn:EnableMouse(true)
    portalBtn:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
    portalBtn:SetAttribute("type", "macro")

    -- Small portal icon at the bottom-right of the bar (visual indicator only)
    local portalIconTex = portalBtn:CreateTexture(nil, "ARTWORK")
    portalIconTex:SetPoint("BOTTOMRIGHT", portalBtn, "BOTTOMRIGHT", -6, 11)
    portalIconTex:SetSize(22, 22)
    portalIconTex:SetTexture("interface/icons/spell_animabastion_nova")
    portalIconTex:SetTexCoord(0.07, 0.93, 0.07, 0.93)

    -- Highlight covers the full bar to give clear hover feedback
    local portalHl = portalBtn:CreateTexture(nil, "HIGHLIGHT")
    portalHl:SetAllPoints()
    portalHl:SetColorTexture(1, 1, 1, 0.20)

    portalBtn:Hide()
    btn.portalBtn = portalBtn

    return btn
end

-------------------------------------------------------------------------------
-- Rendering: right column — section detail
-------------------------------------------------------------------------------

local function RenderDetail(section)
    RightScroll:SetVerticalScroll(0)
    if not section then
        RightHTML:Hide()
        RightHTML:SetHeight(10)
        return
    end
    RightHTML:SetHeight(200)   -- allow full layout before measuring
    local html = section.htmlContent
        :gsub("<h1>", "<br/><h1>")
        :gsub("</h1>", "</h1><br/>")
    RightHTML:SetText("<html><body>" .. html .. "</body></html>")
    RightHTML:SetHeight(RightHTML:GetHeight() + 20)
    RightContent:SetHeight(RightHTML:GetHeight() + 10)  -- 10 = top margin
    RightHTML:Show()
end

-------------------------------------------------------------------------------
-- Rendering: left column — section menu
-------------------------------------------------------------------------------

local function SelectSection(section, btn)
    -- Deselect the previous button
    if currentMenuBtn then
        currentMenuBtn.selBg:Hide()
        currentMenuBtn.label:SetTextColor(0.72, 0.72, 0.72)
    end
    -- Select the new one
    selectedSection = section
    currentMenuBtn  = btn
    if btn then
        btn.selBg:Show()
        btn.label:SetTextColor(1.0, 0.85, 0.0)
    end
    RenderDetail(section)
end

local function RenderMenu(dungeon)
    BtnFlush(LeftContent)
    FSFlush(LeftContent)
    LeftScroll:SetVerticalScroll(0)
    currentMenuBtn = nil

    if not dungeon.sections or #dungeon.sections == 0 then
        LeftContent:SetHeight(10)
        return
    end

    local y = -6
    local firstBtn, firstSection

    for _, section in ipairs(dungeon.sections) do
        local sec = section  -- closure capture

        local btn = BtnGet(LeftContent, NewMenuBtn)
        btn:SetPoint("TOPLEFT",  LeftContent, "TOPLEFT",  0, y)
        btn:SetPoint("TOPRIGHT", LeftContent, "TOPRIGHT", 0, y)
        btn.label:SetText(section.name)
        btn.label:SetTextColor(0.72, 0.72, 0.72)
        btn.selBg:Hide()

        btn:SetScript("OnClick", function()
            SelectSection(sec, btn)
        end)

        if not firstBtn then
            firstBtn    = btn
            firstSection = section
        end

        y = y - btn:GetHeight() - 2
    end

    LeftContent:SetHeight(math.abs(y) + 8)

    -- Auto-select the first section on open
    if firstBtn then
        SelectSection(firstSection, firstBtn)
    end
end

-------------------------------------------------------------------------------
-- Rendering: dungeon view (two-column layout)
-------------------------------------------------------------------------------

local function RenderDungeon(dungeon)
    ListScroll:Hide()
    DungeonHeader:Show()

    -- Icon (|T...|t escape) + dungeon name in the header row
    local iconStr = dungeon.icon and ("|T" .. dungeon.icon .. ":22:22:0:0|t  ") or ""
    DungeonHeaderFS:SetText(iconStr .. "|cffFFD700" .. dungeon.name .. "|r")

    -- Right-panel background texture
    if RightBg then
        if dungeon.background then
            RightBg:SetTexture(dungeon.background)
            RightBg:Show()
        else
            RightBg:Hide()
        end
    end

    ColDivider:Show()
    LeftScroll:Show()
    RightScroll:Show()
    BackBtn:Show()

    if not dungeon.sections or #dungeon.sections == 0 then
        -- No data yet: empty left col, placeholder in right col
        BtnFlush(LeftContent)
        FSFlush(LeftContent)
        LeftContent:SetHeight(10)

        RenderDetail({ htmlContent = "<p>|cff888888" .. L["GUIDE_wip"] .. "|r</p>" })
        return
    end

    RenderMenu(dungeon)
end

-------------------------------------------------------------------------------
-- Rendering: dungeon list (thumbnail grid view)
-------------------------------------------------------------------------------

-- Renders a list of dungeons as a THUMB_COLS-wide vignette grid.
-- Returns the y offset after the last row (negative, downward).
local function RenderThumbnailGrid(dungeons, startY)
    local col  = 0
    local rowY = startY

    for _, dungeon in ipairs(dungeons) do
        local d       = dungeon
        local hasData = dungeon.sections and #dungeon.sections > 0
        local xOffset = col * (THUMB_W + THUMB_GAP)

        local btn = ThumbBtnGet(ListContent)
        btn:SetSize(THUMB_W, THUMB_H)
        btn:SetPoint("TOPLEFT", ListContent, "TOPLEFT", xOffset, rowY)

        -- Position the vignette clip frame (sibling of btn) over the same area
        btn.vigClip:ClearAllPoints()
        btn.vigClip:SetPoint("TOPLEFT", ListContent, "TOPLEFT", xOffset, rowY)
        btn.vigClip:Show()

        -- Vignette background
        if dungeon.vignette then
            btn.vignetteTex:SetTexture(dungeon.vignette)
        else
            btn.vignetteTex:SetColorTexture(0.08, 0.08, 0.18, 1)
        end

        -- Icon
        if dungeon.icon then
            btn.iconTex:SetTexture(dungeon.icon)
            btn.iconTex:Show()
        else
            btn.iconTex:Hide()
        end

        btn.label:SetText(dungeon.name)

        if hasData then
            btn.vignetteTex:SetAlpha(1)
            btn.dimOverlay:Hide()
            btn.comingSoon:Hide()
            btn.label:SetTextColor(1, 1, 1)
            btn:SetScript("OnClick", function()
                selectedDungeon = d
                selectedSection = nil
                forceList       = false
                Guide:Render()
            end)
            btn:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOP")
                GameTooltip:SetText(L["GUIDE_vignette_tooltip"], 1, 1, 1)
                GameTooltip:Show()
            end)
            btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
        else
            btn.vignetteTex:SetAlpha(0.40)
            btn.dimOverlay:Show()
            btn.comingSoon:Show()
            btn.label:SetTextColor(0.55, 0.55, 0.55)
            btn:SetScript("OnClick", nil)
            btn:SetScript("OnEnter", nil)
            btn:SetScript("OnLeave", nil)
        end

        local spellId   = dungeon.spellportalid
        local hasPortal = spellId and C_SpellBook.IsSpellInSpellBook(spellId)
        if hasPortal then
            local info = C_Spell.GetSpellInfo(spellId)
            local spellName = info and info.name
            if spellName then
                -- Split interaction: top part → guide, bottom bar → teleport
                btn:SetHitRectInsets(0, 0, 0, 44)
                btn.portalBtn:SetAttribute("macrotext", "/cast " .. spellName)
                btn.portalBtn:ClearAllPoints()
                btn.portalBtn:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT", 0, 0)
                local dName = dungeon.name
                btn.portalBtn:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_TOP")
                    GameTooltip:SetText(L["GUIDE_portal_tooltip"], 1, 1, 1)
                    GameTooltip:AddLine(dName, 1, 0.82, 0)
                    GameTooltip:Show()
                end)
                btn.portalBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
                btn.portalBtn:Show()
            else
                -- Spell info unavailable: full vignette opens guide
                btn:SetHitRectInsets(0, 0, 0, 0)
                btn.portalBtn:Hide()
            end
        else
            -- No portal spell: entire vignette opens guide
            btn:SetHitRectInsets(0, 0, 0, 0)
            btn.portalBtn:SetAttribute("macrotext", nil)
            btn.portalBtn:Hide()
        end

        col = col + 1
        if col >= THUMB_COLS then
            col  = 0
            rowY = rowY - THUMB_H - THUMB_GAP
        end
    end

    local numRows = math.ceil(#dungeons / THUMB_COLS)
    return startY - numRows * (THUMB_H + THUMB_GAP)
end

local function RenderList()
    DungeonHeader:Hide()
    ColDivider:Hide()
    LeftScroll:Hide()
    RightScroll:Hide()
    BackBtn:Hide()
    ListScroll:Show()

    FSFlush(ListContent)
    BtnFlush(ListContent)
    ThumbBtnFlush(ListContent)
    ListScroll:SetVerticalScroll(0)

    -- Separate S1 dungeons from others
    local s1Dungeons    = {}
    local otherDungeons = {}
    for _, dungeon in ipairs(ns.guideData) do
        local isS1 = false
        for _, g in ipairs(dungeon.groups or {}) do
            if g == "S1" then isS1 = true; break end
        end
        if isS1 then
            s1Dungeons[#s1Dungeons + 1] = dungeon
        else
            otherDungeons[#otherDungeons + 1] = dungeon
        end
    end

    local y = -10

    -- S1 header
    local hdrFS = FSGet(ListContent, "GameFontNormalLarge")
    hdrFS:SetPoint("TOPLEFT", ListContent, "TOPLEFT", 6, y)
    hdrFS:SetWidth(LIST_CW - 12)
    hdrFS:SetText("|cffFFD700" .. L["GUIDE_s1_header"] .. "|r")
    hdrFS:SetJustifyH("LEFT")
    y = y - hdrFS:GetStringHeight() - 10

    -- S1 thumbnail grid
    y = RenderThumbnailGrid(s1Dungeons, y)
    y = y + THUMB_GAP  -- remove trailing gap after last row

    -- Optional section: other dungeons (e.g. S2)
    if #otherDungeons > 0 then
        y = y - 20

        -- Horizontal separator
        if not ListSepTex then
            ListSepTex = ListContent:CreateTexture(nil, "ARTWORK")
            ListSepTex:SetHeight(1)
            ListSepTex:SetColorTexture(0.40, 0.40, 0.65, 0.80)
        end
        ListSepTex:ClearAllPoints()
        ListSepTex:SetPoint("TOPLEFT",  ListContent, "TOPLEFT",  0, y)
        ListSepTex:SetPoint("TOPRIGHT", ListContent, "TOPRIGHT", 0, y)
        ListSepTex:Show()

        y = y - 16

        -- Other dungeons label
        local otherHdrFS = FSGet(ListContent, "GameFontNormalLarge")
        otherHdrFS:SetPoint("TOPLEFT", ListContent, "TOPLEFT", 6, y)
        otherHdrFS:SetWidth(LIST_CW - 12)
        otherHdrFS:SetText("|cffAAAAFF" .. L["GUIDE_other_dungeons"] .. "|r")
        otherHdrFS:SetJustifyH("LEFT")
        y = y - otherHdrFS:GetStringHeight() - 10

        y = RenderThumbnailGrid(otherDungeons, y)
        y = y + THUMB_GAP
    else
        if ListSepTex then ListSepTex:Hide() end
    end

    ListContent:SetHeight(math.abs(y) + 16)
end

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------

function Guide:Render()
    if not isVisible then return end
    if forceList then
        RenderList()
        return
    end
    local dungeon = selectedDungeon or zoneDungeon
    if dungeon then
        RenderDungeon(dungeon)
    else
        RenderList()
    end
end

function Guide:Open()
    GuideWin:Show()
    isVisible = true
    Guide:Render()
end

function Guide:Close()
    GuideWin:Hide()
    isVisible = false
end

function Guide:Toggle()
    if isVisible then Guide:Close() else Guide:Open() end
end

-------------------------------------------------------------------------------
-- Zone detection
-------------------------------------------------------------------------------

local function UpdateZone()
    local mapId        = C_Map.GetBestMapForUnit("player")
    local newDungeon   = ns.GetDungeonByMapId(mapId)
    -- Reset forceList when entering a new dungeon zone so the guide
    -- automatically opens on the correct dungeon view.
    if newDungeon and newDungeon ~= zoneDungeon then
        forceList = false
    end
    zoneDungeon = newDungeon
    if zoneDungeon then selectedDungeon = nil end
    Guide:Render()
end

-------------------------------------------------------------------------------
-- Build: floating toggle button
-------------------------------------------------------------------------------

local function BuildButton()
    GuideBtn = CreateFrame("Button", "MythicPlusGuideBtn", UIParent)
    GuideBtn:SetSize(BTN_SIZE, BTN_SIZE)
    GuideBtn:SetPoint("CENTER", UIParent, "CENTER", 700, -200)
    GuideBtn:SetMovable(true)
    GuideBtn:EnableMouse(true)
    GuideBtn:RegisterForDrag("LeftButton")
    GuideBtn:SetClampedToScreen(true)
    GuideBtn:SetFrameStrata("HIGH")

    local bg = GuideBtn:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface/Minimap/UI-Minimap-Background")
    bg:SetVertexColor(0.15, 0.15, 0.15)

    local icon = GuideBtn:CreateTexture(nil, "ARTWORK")
    icon:SetPoint("TOPLEFT",      7, -7)
    icon:SetPoint("BOTTOMRIGHT", -7,  7)
    icon:SetTexture(525134)
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

    local hl = GuideBtn:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints()
    hl:SetTexture("Interface/Minimap/UI-Minimap-Background")
    hl:SetAlpha(0.35)

    GuideBtn:SetScript("OnDragStart", GuideBtn.StartMoving)
    GuideBtn:SetScript("OnDragStop",  GuideBtn.StopMovingOrSizing)
    GuideBtn:SetScript("OnClick", function(_, btn)
        if btn == "LeftButton" then Guide:Toggle() end
    end)
    GuideBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("MythicPlus Guide", 1, 0.82, 0)
        GameTooltip:AddLine(L["GUIDE_tooltip_click"], 1, 1, 1)
        GameTooltip:AddLine(L["GUIDE_tooltip_drag"],  0.6, 0.6, 0.6)
        GameTooltip:Show()
    end)
    GuideBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

-------------------------------------------------------------------------------
-- Build: main guide window
-------------------------------------------------------------------------------

local function BuildWindow()
    -- ── Outer frame ────────────────────────────────────────────────────────
    GuideWin = CreateFrame("Frame", "MythicPlusGuideWindow", UIParent, "BackdropTemplate")
    GuideWin:SetSize(WIN_W, WIN_H)
    GuideWin:SetPoint("CENTER")
    GuideWin:SetMovable(true)
    GuideWin:SetClampedToScreen(true)
    GuideWin:EnableMouse(true)
    GuideWin:SetFrameStrata("HIGH")
    GuideWin:SetBackdrop({
        bgFile   = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets   = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    GuideWin:SetBackdropColor(0.04, 0.04, 0.12, 0.96)
    GuideWin:SetBackdropBorderColor(0.35, 0.35, 0.60, 1)
    GuideWin:Hide()

    -- ── Title bar ──────────────────────────────────────────────────────────
    local titleBar = CreateFrame("Frame", nil, GuideWin)
    titleBar:SetPoint("TOPLEFT",  0, 0)
    titleBar:SetPoint("TOPRIGHT", 0, 0)
    titleBar:SetHeight(TITLE_H)
    titleBar:EnableMouse(true)
    titleBar:RegisterForDrag("LeftButton")
    titleBar:SetScript("OnDragStart", function() GuideWin:StartMoving() end)
    titleBar:SetScript("OnDragStop",  function() GuideWin:StopMovingOrSizing() end)

    local titleFS = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleFS:SetPoint("LEFT", 10, 0)
    titleFS:SetText("|cffFFD700[M+]|r  MythicPlus Guide")

    -- ── Close button ───────────────────────────────────────────────────────
    local closeBtn = CreateFrame("Button", nil, GuideWin, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -6, -6)
    closeBtn:SetScript("OnClick", function() Guide:Close() end)

    -- ── "< Liste" back button — child of titleBar for correct z-order ──────
    BackBtn = CreateFrame("Button", nil, titleBar, "UIPanelButtonTemplate")
    BackBtn:SetText(L["GUIDE_back_btn"])
    local btnText = BackBtn:GetFontString()
    BackBtn:SetWidth(btnText:GetStringWidth() + 24)
    BackBtn:SetHeight(closeBtn:GetHeight())
    BackBtn:SetPoint("RIGHT", closeBtn, "LEFT", -6, 0)

    BackBtn:SetScript("OnClick", function()
        selectedDungeon = nil
        selectedSection = nil
        forceList       = true
        Guide:Render()
    end)
    BackBtn:Hide()

    -- ── Separator 1 (below title bar) ─────────────────────────────────────
    local sep1 = GuideWin:CreateTexture(nil, "ARTWORK")
    sep1:SetPoint("TOPLEFT",  MARGIN, -Y_SEP1)
    sep1:SetPoint("TOPRIGHT", -MARGIN, -Y_SEP1)
    sep1:SetHeight(SEP_H)
    sep1:SetColorTexture(0.40, 0.40, 0.65, 0.80)

    -- ── Dungeon name row (dungeon view only) ───────────────────────────────
    DungeonHeader = CreateFrame("Frame", nil, GuideWin)
    DungeonHeader:SetPoint("TOPLEFT",  MARGIN, -Y_DNAME)
    DungeonHeader:SetPoint("TOPRIGHT", -MARGIN, -Y_DNAME)
    DungeonHeader:SetHeight(DNAME_H)

    DungeonHeaderFS = DungeonHeader:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    DungeonHeaderFS:SetPoint("LEFT",  4, 0)
    DungeonHeaderFS:SetPoint("RIGHT", -4, 0)
    DungeonHeaderFS:SetJustifyH("LEFT")

    -- Separator 2 embedded at the bottom of DungeonHeader
    local sep2 = DungeonHeader:CreateTexture(nil, "ARTWORK")
    sep2:SetPoint("BOTTOMLEFT",  0, 0)
    sep2:SetPoint("BOTTOMRIGHT", 0, 0)
    sep2:SetHeight(SEP_H)
    sep2:SetColorTexture(0.40, 0.40, 0.65, 0.50)

    DungeonHeader:Hide()

    -- ── Column divider ─────────────────────────────────────────────────────
    ColDivider = GuideWin:CreateTexture(nil, "ARTWORK")
    ColDivider:SetPoint("TOPLEFT",     GuideWin, "TOPLEFT",    MARGIN + LEFT_W,     -Y_COLS)
    ColDivider:SetPoint("BOTTOMRIGHT", GuideWin, "BOTTOMLEFT", MARGIN + LEFT_W + 1, MARGIN)
    ColDivider:SetColorTexture(0.40, 0.40, 0.65, 0.60)
    ColDivider:Hide()

    -- ── Full-width list scroll (list view) ─────────────────────────────────
    ListScroll = CreateFrame("ScrollFrame", "MythicPlusListScroll", GuideWin, "UIPanelScrollFrameTemplate")
    ListScroll:SetPoint("TOPLEFT",     GuideWin, "TOPLEFT",     MARGIN,                    -Y_LIST)
    ListScroll:SetPoint("BOTTOMRIGHT", GuideWin, "BOTTOMRIGHT", -(MARGIN + SCROLLBAR_W),  MARGIN)

    ListContent = CreateFrame("Frame", nil, ListScroll)
    ListContent:SetWidth(LIST_CW)
    ListContent:SetHeight(10)
    ListScroll:SetScrollChild(ListContent)
    ListScroll:Hide()

    -- ── Left scroll — section menu (dungeon view) ──────────────────────────
    LeftScroll = CreateFrame("ScrollFrame", "MythicPlusLeftScroll", GuideWin, "UIPanelScrollFrameTemplate")
    LeftScroll:SetPoint("TOPLEFT",     GuideWin, "TOPLEFT",    MARGIN,                       -Y_COLS)
    LeftScroll:SetPoint("BOTTOMRIGHT", GuideWin, "TOPLEFT",    MARGIN + LEFT_W - SCROLLBAR_W - 4, -(WIN_H - MARGIN))

    LeftContent = CreateFrame("Frame", nil, LeftScroll)
    LeftContent:SetWidth(LEFT_CW)
    LeftContent:SetHeight(10)
    LeftScroll:SetScrollChild(LeftContent)
    LeftScroll:Hide()

    -- ── Right scroll — section detail (dungeon view) ───────────────────────
    RightScroll = CreateFrame("ScrollFrame", "MythicPlusRightScroll", GuideWin, "UIPanelScrollFrameTemplate")
    RightScroll:SetPoint("TOPLEFT",     GuideWin, "TOPLEFT",     RIGHT_X,                   -Y_COLS)
    RightScroll:SetPoint("BOTTOMRIGHT", GuideWin, "BOTTOMRIGHT", -(MARGIN + SCROLLBAR_W),  MARGIN)

    RightContent = CreateFrame("Frame", nil, RightScroll)
    RightContent:SetWidth(RIGHT_CW)
    RightContent:SetHeight(10)
    RightScroll:SetScrollChild(RightContent)

    RightHTML = CreateFrame("SimpleHTML", "MythicPlusRightHTML", RightContent)
    RightHTML:SetPoint("TOPLEFT", RightContent, "TOPLEFT", 10, -10)
    RightHTML:SetWidth(RIGHT_CW - 14)
    RightHTML:SetHeight(10)
    local fontPath  = (GameFontNormal:GetFont())
    local fontLarge = (GameFontNormalLarge:GetFont())
    RightHTML:SetFont("h1", fontLarge, 16, "SLUG")
    RightHTML:SetFont("p",  fontPath,  13, "SLUG")
    RightHTML:SetTextColor("h1", 1, 0.85, 0)
    RightHTML:EnableMouse(true)
    RightHTML:SetScript("OnHyperlinkEnter", function(self, link)
        GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
        GameTooltip:SetHyperlink(link)
        GameTooltip:Show()
    end)
    RightHTML:SetScript("OnHyperlinkLeave", function() GameTooltip:Hide() end)
    RightScroll:Hide()

    -- Right-panel background (child of RightScroll so it stays fixed while content scrolls)
    RightBg = RightScroll:CreateTexture(nil, "BACKGROUND")
    RightBg:SetAllPoints()
    RightBg:SetAlpha(0.18)
    RightBg:Hide()
end

-------------------------------------------------------------------------------
-- Init & boot
-------------------------------------------------------------------------------

function Guide:Init()
    BuildButton()
    BuildWindow()

    local evt = CreateFrame("Frame")
    evt:RegisterEvent("PLAYER_ENTERING_WORLD")
    evt:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    evt:RegisterEvent("ZONE_CHANGED")
    evt:SetScript("OnEvent", UpdateZone)
end

local boot = CreateFrame("Frame")
boot:RegisterEvent("ADDON_LOADED")
boot:SetScript("OnEvent", function(self, event, name)
    if name == myname then
        Guide:Init()
        self:UnregisterAllEvents()
    end
end)
