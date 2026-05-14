local _, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Module
-------------------------------------------------------------------------------

local About = {}
ns.About = About

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

-- Download links target MythicKeystone (the addon being promoted in this popup).
-- The user already has MythicDungeonNotes installed, so the call-to-action is MK.
local URL_CURSEFORGE = "https://www.curseforge.com/wow/addons/mythickeystone"
local URL_WAGO       = "https://addons.wago.io/addons/mythickeystone"
local URL_GITHUB     = "https://github.com/willoucom/MythicKeystone"

local WIN_W        = 480
local WIN_H        = 460
local MARGIN       = 12
local TITLE_H      = 30
local LINK_BTN_W   = 110
local LINK_BTN_H   = 22

local AboutWin

-------------------------------------------------------------------------------
-- StaticPopup: shows a URL in a copy-able EditBox
-------------------------------------------------------------------------------

StaticPopupDialogs["MYTHICDUNGEONNOTES_URL"] = {
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
    preferredIndex = 3,  -- avoid taint with other addons
}

local function ShowURL(url)
    local popup = StaticPopup_Show("MYTHICDUNGEONNOTES_URL", L["ABOUT_url_popup_text"], nil, url)
    if popup then
        popup:SetFrameStrata("TOOLTIP")
        popup:Raise()
        -- Belt-and-suspenders: force-fill the EditBox in case OnShow didn't.
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

function About:Build(parent)
    if AboutWin then return end

    -- ── Outer frame ────────────────────────────────────────────────────────
    AboutWin = CreateFrame("Frame", "MythicDungeonNotesAboutWindow", parent, "BackdropTemplate")
    AboutWin:SetSize(WIN_W, WIN_H)
    AboutWin:SetPoint("CENTER", parent, "CENTER")
    AboutWin:SetFrameStrata("DIALOG")
    AboutWin:SetFrameLevel((parent:GetFrameLevel() or 0) + 20)
    AboutWin:EnableMouse(true)
    AboutWin:SetMovable(true)
    AboutWin:SetClampedToScreen(true)
    AboutWin:SetBackdrop({
        bgFile   = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets   = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    AboutWin:SetBackdropColor(0.04, 0.04, 0.12, 0.98)
    AboutWin:SetBackdropBorderColor(0.35, 0.35, 0.60, 1)
    AboutWin:Hide()

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

    -- ── Section 1: About this addon (anchored top) ─────────────────────────
    local topHTML = CreateFrame("SimpleHTML", nil, AboutWin)
    topHTML:SetPoint("TOPLEFT", AboutWin, "TOPLEFT", MARGIN + CONTENT_INDENT, -(TITLE_H + 8))
    topHTML:SetWidth(CONTENT_W)
    topHTML:SetHeight(80)
    styleHTML(topHTML)
    topHTML:SetText(table.concat({
        "<html><body>",
        "<h1>Mythic Dungeon Notes</h1>",
        "<p>" .. L["ABOUT_description"] .. "</p>",
        "<p>|cffAAAAAA" .. L["ABOUT_author"] .. "|r</p>",
        "</body></html>",
    }, ""))

    -- ── Section 2: MythicKeystone promo (anchored bottom, above links) ────
    local botHTML = CreateFrame("SimpleHTML", nil, AboutWin)
    botHTML:SetPoint("BOTTOMLEFT", AboutWin, "BOTTOMLEFT", MARGIN + CONTENT_INDENT, MARGIN + LINK_BTN_H + 6 + 14 + 10)
    botHTML:SetWidth(CONTENT_W)
    styleHTML(botHTML)
    botHTML:SetText(table.concat({
        "<html><body>",
        "<h2>" .. L["ABOUT_mk_header"] .. "</h2>",
        "<p>" .. L["ABOUT_mk_pitch"] .. "</p>",
        "<p><br/></p>",
        "<p>" .. L["ABOUT_mk_feature_alts"]  .. "</p>",
        "<p>" .. L["ABOUT_mk_feature_party"] .. "</p>",
        "<p>" .. L["ABOUT_mk_feature_guild"] .. "</p>",
        "<p>" .. L["ABOUT_mk_feature_auto"]  .. "</p>",
        "<p><br/></p>",
        "<p>|cffAAAAAA" .. L["ABOUT_mk_companion"] .. "|r</p>",
        "</body></html>",
    }, ""))
    -- Resize the frame to the actual content height so the content sits flush
    -- with the bottom anchor (otherwise SimpleHTML renders from the top, leaving
    -- an empty gap above the Links section).
    local botContentH = botHTML.GetContentHeight and botHTML:GetContentHeight() or 200
    if botContentH < 10 then botContentH = 200 end
    botHTML:SetHeight(botContentH + 4)

    -- ── Middle separator (centered in the empty gap between sections) ────
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

function About:Open(parent)
    if not AboutWin then About:Build(parent) end
    if not AboutWin then return end
    AboutWin:Show()
    AboutWin:Raise()
end

function About:Close()
    if not AboutWin then return end
    AboutWin:Hide()
end

function About:Toggle(parent)
    if not AboutWin then About:Build(parent) end
    if not AboutWin then return end
    if AboutWin:IsShown() then About:Close() else About:Open(parent) end
end
