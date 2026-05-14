local ADDON, Addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON)

-------------------------------------------------------------------------------
-- Module: About popup
-- Displays addon info + cross-promo for Mythic Dungeon Notes.
-- Parented to UIParent (MythicKeystone has no standalone window of its own);
-- auto-hides when PVEFrame closes so the popup never lingers orphaned.
-------------------------------------------------------------------------------

local About = {}
Addon.About = About

-- Download links target Mythic Dungeon Notes (the addon being promoted).
-- The user already has MythicKeystone installed, so the call-to-action is MDN.
local URL_CURSEFORGE = "https://www.curseforge.com/wow/addons/mythic-dungeon-notes"
local URL_WAGO       = "https://addons.wago.io/addons/mythic-dungeon-notes"
local URL_GITHUB     = "https://github.com/willoucom/MythicKeystone"

local WIN_W       = 480
local WIN_H       = 460
local MARGIN      = 12
local TITLE_H     = 30
local LINK_BTN_W  = 110
local LINK_BTN_H  = 22

local AboutWin

-------------------------------------------------------------------------------
-- StaticPopup: shows a URL in a copy-able EditBox
-------------------------------------------------------------------------------

StaticPopupDialogs["MYTHICKEYSTONE_URL"] = {
    text         = "%s",
    button1      = OKAY,
    hasEditBox   = true,
    editBoxWidth = 350,
    OnShow = function(self)
        local editBox = self.editBox or _G[self:GetName() .. "EditBox"]
        if editBox and self.data then
            editBox:SetText(self.data)
            editBox:HighlightText()
            editBox:SetFocus()
        end
    end,
    EditBoxOnEnterPressed  = function(self) self:GetParent():Hide() end,
    EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
    timeout      = 0,
    whileDead    = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

local function ShowURL(url)
    local popup = StaticPopup_Show("MYTHICKEYSTONE_URL", L["ABOUT_url_popup_text"], nil, url)
    if popup then
        popup:SetFrameStrata("TOOLTIP")
        popup:Raise()
        local editBox = popup.editBox or _G[popup:GetName() .. "EditBox"]
        if editBox then
            editBox:SetText(url)
            editBox:HighlightText()
            editBox:SetFocus()
        end
    end
end

-------------------------------------------------------------------------------
-- Build
-------------------------------------------------------------------------------

local function NewLinkBtn(parent, label, url)
    local btn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    btn:SetSize(LINK_BTN_W, LINK_BTN_H)
    btn:SetText(label)
    btn:SetScript("OnClick", function() ShowURL(url) end)
    return btn
end

function About:Build()
    if AboutWin then return end

    AboutWin = CreateFrame("Frame", "MythicKeystoneAboutWindow", UIParent, "BackdropTemplate")
    AboutWin:SetSize(WIN_W, WIN_H)
    AboutWin:SetPoint("CENTER", UIParent, "CENTER")
    AboutWin:SetFrameStrata("DIALOG")
    AboutWin:EnableMouse(true)
    AboutWin:SetMovable(true)
    AboutWin:SetClampedToScreen(true)
    -- Use the same backdrop as the Alts/Group/Guild panels to keep the popup
    -- visually consistent with the rest of the addon's UI surfaces.
    AboutWin:SetBackdrop(BACKDROP_TUTORIAL_16_16) ---@diagnostic disable-line: param-type-mismatch
    AboutWin:Hide()

    -- Esc closes
    tinsert(UISpecialFrames, "MythicKeystoneAboutWindow")

    -- Auto-close when the parent UI (LFG/PVE frame) closes — keeps the popup
    -- from lingering on screen if the player closes PVEFrame.
    if PVEFrame then
        PVEFrame:HookScript("OnHide", function()
            if AboutWin and AboutWin:IsShown() then AboutWin:Hide() end
        end)
    end

    -- ── Title bar (draggable) ──────────────────────────────────────────────
    local titleBar = CreateFrame("Frame", nil, AboutWin)
    titleBar:SetPoint("TOPLEFT",  0, 0)
    titleBar:SetPoint("TOPRIGHT", 0, 0)
    titleBar:SetHeight(TITLE_H)
    titleBar:EnableMouse(true)
    titleBar:RegisterForDrag("LeftButton")
    titleBar:SetScript("OnDragStart", function() AboutWin:StartMoving() end)
    titleBar:SetScript("OnDragStop",  function() AboutWin:StopMovingOrSizing() end)

    local titleFS = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleFS:SetPoint("LEFT", 10, 0)
    titleFS:SetText(L["ABOUT_title"])

    -- ── Close button ───────────────────────────────────────────────────────
    local closeBtn = CreateFrame("Button", nil, AboutWin, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -6, -6)
    closeBtn:SetScript("OnClick", function() About:Close() end)

    -- ── Separator under title ──────────────────────────────────────────────
    local sep = AboutWin:CreateTexture(nil, "ARTWORK")
    sep:SetPoint("TOPLEFT",  MARGIN, -TITLE_H)
    sep:SetPoint("TOPRIGHT", -MARGIN, -TITLE_H)
    sep:SetHeight(1)
    sep:SetColorTexture(0.40, 0.40, 0.65, 0.80)

    -- ── Link buttons (bottom row) ──────────────────────────────────────────
    local cfBtn   = NewLinkBtn(AboutWin, L["ABOUT_link_curseforge"], URL_CURSEFORGE)
    local wagoBtn = NewLinkBtn(AboutWin, L["ABOUT_link_wago"],       URL_WAGO)
    local ghBtn   = NewLinkBtn(AboutWin, L["ABOUT_link_github"],     URL_GITHUB)

    local totalLinksW = 3 * LINK_BTN_W + 2 * 8
    local linksStartX = (WIN_W - totalLinksW) / 2
    cfBtn:SetPoint("BOTTOMLEFT", AboutWin, "BOTTOMLEFT", linksStartX, MARGIN)
    wagoBtn:SetPoint("LEFT", cfBtn,   "RIGHT", 8, 0)
    ghBtn:SetPoint("LEFT",   wagoBtn, "RIGHT", 8, 0)

    -- ── Links header (above buttons) ───────────────────────────────────────
    local linksHdr = AboutWin:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    linksHdr:SetPoint("BOTTOM", cfBtn, "TOP", 0, 6)
    linksHdr:SetText("|cffFFD700" .. L["ABOUT_links_header"] .. "|r")

    -- ── Shared fonts/colors for SimpleHTML blocks ─────────────────────────
    local fontPath  = (GameFontNormal:GetFont())
    local fontLarge = (GameFontNormalLarge:GetFont())

    local function styleHTML(h)
        h:SetFont("h1", fontLarge, 16, "SLUG")
        h:SetFont("h2", fontLarge, 14, "SLUG")
        h:SetFont("p",  fontPath,  12, "SLUG")
        h:SetTextColor("h1", 1.00, 0.85, 0.00)
        h:SetTextColor("h2", 0.65, 0.85, 1.00)
        h:SetTextColor("p",  0.92, 0.92, 0.92)
    end

    local CONTENT_INDENT = 6
    local CONTENT_W      = WIN_W - 2 * (MARGIN + CONTENT_INDENT)

    -- ── Section 1: About this addon (MythicKeystone) ───────────────────────
    local topHTML = CreateFrame("SimpleHTML", nil, AboutWin)
    topHTML:SetPoint("TOPLEFT", AboutWin, "TOPLEFT", MARGIN + CONTENT_INDENT, -(TITLE_H + 8))
    topHTML:SetWidth(CONTENT_W)
    topHTML:SetHeight(80)
    styleHTML(topHTML)
    topHTML:SetText(table.concat({
        "<html><body>",
        "<h1>MythicKeystone</h1>",
        "<p>" .. L["ABOUT_description"] .. "</p>",
        "<p>|cffAAAAAA" .. L["ABOUT_author"] .. "|r</p>",
        "</body></html>",
    }, ""))

    -- ── Section 2: Cross-promo for Mythic Dungeon Notes ────────────────────
    local botHTML = CreateFrame("SimpleHTML", nil, AboutWin)
    botHTML:SetPoint("BOTTOMLEFT", AboutWin, "BOTTOMLEFT", MARGIN + CONTENT_INDENT, MARGIN + LINK_BTN_H + 6 + 14 + 10)
    botHTML:SetWidth(CONTENT_W)
    styleHTML(botHTML)
    botHTML:SetText(table.concat({
        "<html><body>",
        "<h2>" .. L["ABOUT_other_header"] .. "</h2>",
        "<p>" .. L["ABOUT_other_pitch"] .. "</p>",
        "<p><br/></p>",
        "<p>" .. L["ABOUT_other_feature_1"] .. "</p>",
        "<p>" .. L["ABOUT_other_feature_2"] .. "</p>",
        "<p>" .. L["ABOUT_other_feature_3"] .. "</p>",
        "<p>" .. L["ABOUT_other_feature_4"] .. "</p>",
        "<p><br/></p>",
        "<p>|cffAAAAAA" .. L["ABOUT_other_companion"] .. "|r</p>",
        "</body></html>",
    }, ""))
    local botContentH = botHTML.GetContentHeight and botHTML:GetContentHeight() or 200
    if botContentH < 10 then botContentH = 200 end
    botHTML:SetHeight(botContentH + 4)

    -- ── Middle separator ───────────────────────────────────────────────────
    local midSep = AboutWin:CreateTexture(nil, "ARTWORK")
    midSep:SetPoint("LEFT",  AboutWin, "LEFT",  MARGIN + 4, 0)
    midSep:SetPoint("RIGHT", AboutWin, "RIGHT", -(MARGIN + 4), 0)
    midSep:SetPoint("TOP",   topHTML, "BOTTOM", 0, -12)
    midSep:SetHeight(1)
    midSep:SetColorTexture(0.40, 0.40, 0.65, 0.6)
end

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------

function About:Open()
    if not AboutWin then About:Build() end
    if not AboutWin then return end
    AboutWin:Show()
    AboutWin:Raise()
end

function About:Close()
    if not AboutWin then return end
    AboutWin:Hide()
end

function About:Toggle()
    if not AboutWin then About:Build() end
    if not AboutWin then return end
    if AboutWin:IsShown() then About:Close() else About:Open() end
end
