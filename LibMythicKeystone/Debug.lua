local _, Addon = ...

-- ============================================================================
-- LibMythicKeystone Debug Mode v2
-- ============================================================================
-- Tabbed panel for runtime introspection: status, inspect, comms (RX/TX log),
-- DB ops, fixtures (fake-data flagged via _fake). Toggled live with /lmk debug
-- (no reload), or by `Addon.debug = true` persisted in LibMythicKeystoneDB.
--
-- Comm capture spans the four wire prefixes used by LMK and its plugins:
--   LibKS, AngryKeystones, AstralKeys, MythicKeystone
-- TX is hooked via hooksecurefunc(C_ChatInfo, "SendAddonMessage"); RX comes
-- from CHAT_MSG_ADDON. Dry-run blocks our own send functions (see Addon.dryrun
-- checks in LibMythicKeystone.lua and the plugins) and logs them as DRY.
-- ============================================================================

local PREFIXES = { "LibKS", "AngryKeystones", "AstralKeys", "MythicKeystone" }
local COMM_BUFFER_SIZE = 500
local STATUS_INTERVAL = 1.0
local INSPECT_INTERVAL = 2.0
local TAB_ORDER = { "Inspect", "Comms", "DB", "Fixtures", "UI" }

local prefixSet = {}
for _, p in ipairs(PREFIXES) do prefixSet[p] = true end

----------------------------------------------------------------------
-- Options helpers
----------------------------------------------------------------------

local function EnsureOptions()
    LibMythicKeystoneDB = LibMythicKeystoneDB or {}
    LibMythicKeystoneDB["options"] = LibMythicKeystoneDB["options"] or {}
    return LibMythicKeystoneDB["options"]
end

local function GetOption(key, default)
    local opts = EnsureOptions()
    if opts[key] == nil then return default end
    return opts[key]
end

local function SetOption(key, value)
    EnsureOptions()[key] = value
end

----------------------------------------------------------------------
-- Trace (legacy chat dump, used internally and by old debug buttons)
----------------------------------------------------------------------

function Addon.trace(o)
    if Addon.debug then
        DevTools_Dump(o)
    end
end

local function CountTable(t)
    if not t then return 0 end
    local n = 0
    for _ in pairs(t) do n = n + 1 end
    return n
end

----------------------------------------------------------------------
-- Comm capture
----------------------------------------------------------------------

local commBuffer = {}
local commOnNew  -- set by Comms tab when visible

local function PushComm(direction, prefix, channel, sender, message)
    if not GetOption("commLogOn", true) then return end
    if not prefixSet[prefix] then return end
    local entry = {
        time = date("%H:%M:%S"),
        direction = direction,
        prefix = prefix,
        channel = channel or "",
        sender = sender or "",
        message = message or "",
    }
    table.insert(commBuffer, entry)
    if #commBuffer > COMM_BUFFER_SIZE then
        table.remove(commBuffer, 1)
    end
    if commOnNew then commOnNew(entry) end
end

function Addon.DebugLogDryRun(prefix, channel, message)
    PushComm("DRY", prefix, channel, "--", message)
end

local commCapture = CreateFrame("Frame")
commCapture:RegisterEvent("CHAT_MSG_ADDON")
commCapture:SetScript("OnEvent", function(_, _, prefix, message, channel, sender)
    PushComm("RX", prefix, channel, sender, message)
end)

hooksecurefunc(C_ChatInfo, "SendAddonMessage", function(prefix, message, channel, target)
    PushComm("TX", prefix, channel, target, message)
end)

----------------------------------------------------------------------
-- Fixtures
----------------------------------------------------------------------

local SYLLABLES = { "thor","ven","del","ari","mal","ren","lyn","dar","ker","fey","sil","gor","nim","vyn","ros","tan" }
local REALMS = { "Hyjal","Sargeras","Kazzak","Stormrage","Argent-Dawn","Silvermoon","Ysondre","Dalaran" }

local function RandomClass()
    local _, classFile = GetClassInfo(math.random(GetNumClasses()))
    return classFile or "WARRIOR"
end

local function RandomName()
    local parts = math.random(2, 3)
    local name = ""
    for i = 1, parts do
        local syl = SYLLABLES[math.random(#SYLLABLES)]
        if i == 1 then syl = syl:sub(1, 1):upper() .. syl:sub(2) end
        name = name .. syl
    end
    return name
end

local function RandomFullname()
    return RandomName() .. "-" .. REALMS[math.random(#REALMS)]
end

local function RandomMapID()
    local maps = C_ChallengeMode and C_ChallengeMode.GetMapTable and C_ChallengeMode.GetMapTable() or nil
    if maps and #maps > 0 then return maps[math.random(#maps)] end
    return 245
end

local function MakeFakeEntry(scope)
    local fullname = RandomFullname()
    local name, realm = strsplit("-", fullname)
    local guild = GetGuildInfo("player")
    local entry = {
        class = RandomClass(),
        name = name,
        realm = realm,
        fullname = fullname,
        current_key = RandomMapID(),
        current_keylevel = math.random(2, 25),
        mplus_score = math.random(0, 4000),
        _fake = true,
    }
    if scope ~= "party" then
        entry.guild = guild or "none"
        entry.week = Addon.GetWeek and Addon.GetWeek() or 0
        entry.weeklybest = math.random(0, 25)
        entry.weeklycount = math.random(0, 10)
    end
    return entry, fullname, name
end

local function AddFakeAlt()
    LibMythicKeystoneDB = LibMythicKeystoneDB or {}
    LibMythicKeystoneDB["Alts"] = LibMythicKeystoneDB["Alts"] or {}
    local entry, fullname = MakeFakeEntry("alt")
    LibMythicKeystoneDB["Alts"][fullname] = entry
end

local function AddFakeParty()
    Addon.PartyKeys = Addon.PartyKeys or {}
    local entry, _, name = MakeFakeEntry("party")
    Addon.PartyKeys[name] = entry
end

local function AddFakeGuild()
    local guild = GetGuildInfo("player")
    if not guild then
        print("|cffff5555LMK:|r Cannot add fake guild member, not in a guild.")
        return
    end
    LibMythicKeystoneDB = LibMythicKeystoneDB or {}
    LibMythicKeystoneDB["Guilds"] = LibMythicKeystoneDB["Guilds"] or {}
    LibMythicKeystoneDB["Guilds"][guild] = LibMythicKeystoneDB["Guilds"][guild] or {}
    local entry, fullname = MakeFakeEntry("guild")
    LibMythicKeystoneDB["Guilds"][guild][fullname] = entry
end

local function WipeFakes()
    local count = 0
    local function wipe(t)
        if not t then return end
        for k, v in pairs(t) do
            if type(v) == "table" and v._fake then
                t[k] = nil
                count = count + 1
            end
        end
    end
    wipe(Addon.PartyKeys)
    if LibMythicKeystoneDB then
        wipe(LibMythicKeystoneDB["Alts"])
        if LibMythicKeystoneDB["Guilds"] then
            for _, g in pairs(LibMythicKeystoneDB["Guilds"]) do wipe(g) end
        end
    end
    return count
end

local function CountFakes(t)
    if not t then return 0 end
    local n = 0
    for _, v in pairs(t) do
        if type(v) == "table" and v._fake then n = n + 1 end
    end
    return n
end

----------------------------------------------------------------------
-- Panel
----------------------------------------------------------------------

local panel
local tabs = {}

local function ColorForDirection(dir)
    if dir == "RX" then return "|cff66ff66" end
    if dir == "TX" then return "|cffffcc55" end
    if dir == "DRY" then return "|cffff8844" end
    return "|cffffffff"
end

----------------------------------------------------------------------
-- Tab: Inspect
----------------------------------------------------------------------

local function BuildInspectTab(parent)
    local scroll = CreateFrame("ScrollFrame", nil, parent, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 8, -8)
    scroll:SetPoint("BOTTOMRIGHT", -28, 8)

    local edit = CreateFrame("EditBox", nil, scroll)
    edit:SetMultiLine(true)
    edit:SetFontObject("ChatFontNormal")
    edit:SetWidth(540)
    edit:SetAutoFocus(false)
    edit:SetMaxLetters(0)
    edit:EnableMouse(true)
    edit:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    scroll:SetScrollChild(edit)
    parent.editBox = edit

    local elapsed = 0
    parent:SetScript("OnUpdate", function(_, e)
        elapsed = elapsed + e
        if elapsed < INSPECT_INTERVAL then return end
        elapsed = 0
        Addon.RefreshInspect()
    end)
end

function Addon.RefreshInspect()
    if not panel or not tabs.Inspect or not tabs.Inspect.content:IsShown() then return end
    local edit = tabs.Inspect.content.editBox
    if not edit then return end

    local lines = {}
    local function add(s) lines[#lines + 1] = s end

    add("|cffaaaaff== Mykey ==|r")
    if Addon.Mykey then
        for k, v in pairs(Addon.Mykey) do
            add(string.format("  %s = %s", tostring(k), tostring(v)))
        end
    else
        add("  (nil)")
    end
    add("")

    add(string.format("|cffaaaaff== PartyKeys (%d) ==|r", CountTable(Addon.PartyKeys)))
    for name, key in pairs(Addon.PartyKeys or {}) do
        local fake = key._fake and " |cffffaa00*fake|r" or ""
        add(string.format("  [%s]%s class=%s key=%s:%s score=%s",
            name, fake,
            tostring(key.class), tostring(key.current_key), tostring(key.current_keylevel),
            tostring(key.mplus_score)))
    end
    add("")

    local alts = LibMythicKeystoneDB and LibMythicKeystoneDB.Alts or {}
    add(string.format("|cffaaaaff== Alts (%d) ==|r", CountTable(alts)))
    for fullname, key in pairs(alts) do
        local fake = key._fake and " |cffffaa00*fake|r" or ""
        add(string.format("  %s%s [%s] key=%s:%s score=%s guild=%s",
            fullname, fake, tostring(key.class),
            tostring(key.current_key), tostring(key.current_keylevel),
            tostring(key.mplus_score), tostring(key.guild)))
    end
    add("")

    local guild = GetGuildInfo("player") or "none"
    local g = LibMythicKeystoneDB and LibMythicKeystoneDB.Guilds and LibMythicKeystoneDB.Guilds[guild] or {}
    add(string.format("|cffaaaaff== Guilds[%s] (%d) ==|r", guild, CountTable(g)))
    for fullname, key in pairs(g) do
        local fake = key._fake and " |cffffaa00*fake|r" or ""
        add(string.format("  %s%s [%s] key=%s:%s score=%s",
            fullname, fake, tostring(key.class),
            tostring(key.current_key), tostring(key.current_keylevel),
            tostring(key.mplus_score)))
    end

    edit:SetText(table.concat(lines, "\n"))
end

----------------------------------------------------------------------
-- Tab: Comms
----------------------------------------------------------------------

local function RenderCommEntry(smf, e)
    smf:AddMessage(string.format("%s %s%-3s|r %-15s %-13s %-22s %s",
        e.time, ColorForDirection(e.direction), e.direction,
        e.prefix, e.channel,
        (e.sender ~= "" and e.sender or "--"),
        e.message))
end

local function PassesFilter(e, filter)
    if not filter or filter == "" then return true end
    filter = filter:lower()
    return (e.prefix:lower():find(filter, 1, true)
        or e.channel:lower():find(filter, 1, true)
        or e.sender:lower():find(filter, 1, true)
        or e.message:lower():find(filter, 1, true)
        or e.direction:lower():find(filter, 1, true)) ~= nil
end

local function BuildCommsTab(parent)
    -- Filter / controls bar
    local filterLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    filterLabel:SetPoint("TOPLEFT", 8, -8)
    filterLabel:SetText("Filter:")

    local filterBox = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    filterBox:SetSize(200, 20)
    filterBox:SetPoint("TOPLEFT", filterLabel, "TOPRIGHT", 10, 4)
    filterBox:SetAutoFocus(false)
    filterBox:SetMaxLetters(64)
    parent.filterBox = filterBox

    local function makeBtn(text, onClick, anchor, anchorPoint, x, y)
        local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
        b:SetSize(80, 22)
        b:SetText(text)
        b:SetPoint("TOPLEFT", anchor, anchorPoint or "TOPRIGHT", x or 4, y or 0)
        b:SetScript("OnClick", onClick)
        return b
    end

    local clearBtn = makeBtn("Clear", function()
        wipe(commBuffer)
        if parent.smf then parent.smf:Clear() end
    end, filterBox, "TOPRIGHT", 10, 4)

    local pauseBtn = makeBtn("Pause", function(self)
        local on = not GetOption("commLogOn", true)
        SetOption("commLogOn", on)
        self:SetText(on and "Pause" or "Resume")
    end, clearBtn)
    if not GetOption("commLogOn", true) then pauseBtn:SetText("Resume") end

    local dryBtn = makeBtn("Dry-run", function(self)
        Addon.dryrun = not Addon.dryrun
        SetOption("dryrun", Addon.dryrun)
        self:SetText(Addon.dryrun and "Dry-run *ON*" or "Dry-run")
    end, pauseBtn)
    dryBtn:SetWidth(110)
    if Addon.dryrun then dryBtn:SetText("Dry-run *ON*") end

    -- Scrolling log
    local smf = CreateFrame("ScrollingMessageFrame", nil, parent)
    smf:SetPoint("TOPLEFT", 8, -40)
    smf:SetPoint("BOTTOMRIGHT", -8, 26)
    smf:SetFontObject("ChatFontSmall")
    smf:SetJustifyH("LEFT")
    smf:SetMaxLines(COMM_BUFFER_SIZE)
    smf:SetFading(false)
    smf:SetHyperlinksEnabled(false)
    smf:EnableMouseWheel(true)
    smf:SetScript("OnMouseWheel", function(self, delta)
        if delta > 0 then self:ScrollUp() else self:ScrollDown() end
    end)
    parent.smf = smf

    -- CTL stats
    local stats = parent:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    stats:SetPoint("BOTTOMLEFT", 8, 6)
    stats:SetPoint("BOTTOMRIGHT", -8, 6)
    stats:SetJustifyH("LEFT")
    parent.stats = stats

    local statsElapsed = 0
    parent:SetScript("OnUpdate", function(_, e)
        statsElapsed = statsElapsed + e
        if statsElapsed < 1.0 then return end
        statsElapsed = 0
        if ChatThrottleLib then
            stats:SetText(string.format(
                "CTL: BPS %.0f / %d  |  MSGS/s %.0f  |  Bypass %d  |  Buffer %d / %d",
                ChatThrottleLib.avgBPS or 0,
                ChatThrottleLib.MAX_CPS or 0,
                ChatThrottleLib.MSG_THROTTLE or 0,
                ChatThrottleLib.nBypass or 0,
                #commBuffer, COMM_BUFFER_SIZE))
        else
            stats:SetText(string.format("Buffer %d / %d  (ChatThrottleLib not loaded)", #commBuffer, COMM_BUFFER_SIZE))
        end
    end)

    -- Refresh callbacks
    local function rerender()
        smf:Clear()
        local f = filterBox:GetText()
        for _, e in ipairs(commBuffer) do
            if PassesFilter(e, f) then RenderCommEntry(smf, e) end
        end
    end
    filterBox:SetScript("OnTextChanged", rerender)

    tabs.Comms.onShow = function()
        rerender()
        commOnNew = function(e)
            if PassesFilter(e, filterBox:GetText() or "") then RenderCommEntry(smf, e) end
        end
    end
    tabs.Comms.onHide = function() commOnNew = nil end
end

----------------------------------------------------------------------
-- Tab: DB
----------------------------------------------------------------------

local function BuildDBTab(parent)
    local stats = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    stats:SetPoint("TOPLEFT", 12, -12)
    stats:SetJustifyH("LEFT")
    stats:SetWidth(560)
    parent.stats = stats

    local function row(text, onClick, anchor, y)
        local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
        b:SetSize(180, 24)
        b:SetText(text)
        b:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, y or -8)
        b:SetScript("OnClick", onClick)
        return b
    end

    local refresh = row("Refresh keystone", function() if Addon.getKeystone then Addon.getKeystone() end end, stats, -16)

    local wipeFakes = row("Wipe fakes", function()
        local n = WipeFakes()
        print(string.format("|cff66ff66LMK:|r removed %d fake entries.", n))
    end, refresh)

    local resetState = { confirming = false }
    local resetBtn
    resetBtn = row("Reset DB", function()
        if not resetState.confirming then
            resetState.confirming = true
            resetBtn:SetText("Click again to CONFIRM")
            C_Timer.After(5, function()
                resetState.confirming = false
                if resetBtn then resetBtn:SetText("Reset DB") end
            end)
        else
            resetState.confirming = false
            LibMythicKeystoneDB["Alts"] = {}
            LibMythicKeystoneDB["Guilds"] = {}
            print("|cffff5555LMK:|r DB reset (Alts + Guilds wiped).")
            resetBtn:SetText("Reset DB")
        end
    end, wipeFakes)

    tabs.DB.onShow = function()
        local alts = LibMythicKeystoneDB and LibMythicKeystoneDB.Alts or {}
        local guilds = LibMythicKeystoneDB and LibMythicKeystoneDB.Guilds or {}
        local altFakes = CountFakes(alts)
        local lines = {}
        lines[#lines+1] = string.format("Alts: %d  (fake: %d)", CountTable(alts), altFakes)
        local total, totalFakes = 0, 0
        for guildName, g in pairs(guilds) do
            local n = CountTable(g)
            local f = CountFakes(g)
            total = total + n
            totalFakes = totalFakes + f
            lines[#lines+1] = string.format("Guilds[%s]: %d  (fake: %d)", guildName, n, f)
        end
        if not next(guilds) then lines[#lines+1] = "Guilds: (empty)" end
        lines[#lines+1] = ""
        lines[#lines+1] = string.format("Total guild entries: %d  (fake: %d)", total, totalFakes)
        stats:SetText(table.concat(lines, "\n"))
    end
end

----------------------------------------------------------------------
-- Tab: Fixtures
----------------------------------------------------------------------

local function BuildFixturesTab(parent)
    local title = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", 12, -12)
    title:SetText("Generate fake entries (flagged with _fake=true)")

    local function row(text, onClick, anchor)
        local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
        b:SetSize(180, 24)
        b:SetText(text)
        b:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -8)
        b:SetScript("OnClick", onClick)
        return b
    end

    local b1 = row("+ Fake party member", AddFakeParty, title)
    local b2 = row("+ Fake alt", AddFakeAlt, b1)
    local b3 = row("+ Fake guild member", AddFakeGuild, b2)
    local b4 = row("Wipe all fakes", function()
        local n = WipeFakes()
        print(string.format("|cff66ff66LMK:|r removed %d fake entries.", n))
    end, b3)

    local counts = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    counts:SetPoint("TOPLEFT", b4, "BOTTOMLEFT", 0, -16)
    counts:SetWidth(560)
    counts:SetJustifyH("LEFT")

    tabs.Fixtures.onShow = function()
        local altsF = CountFakes(LibMythicKeystoneDB and LibMythicKeystoneDB.Alts)
        local partyF = CountFakes(Addon.PartyKeys)
        local guild = GetGuildInfo("player") or "none"
        local guildF = CountFakes(LibMythicKeystoneDB and LibMythicKeystoneDB.Guilds and LibMythicKeystoneDB.Guilds[guild])
        counts:SetText(string.format("Current fakes  |  party: %d  |  alts: %d  |  guild[%s]: %d", partyF, altsF, guild, guildF))
    end

    local elapsed = 0
    parent:SetScript("OnUpdate", function(_, e)
        elapsed = elapsed + e
        if elapsed < 1.0 then return end
        elapsed = 0
        if tabs.Fixtures.onShow then tabs.Fixtures.onShow() end
    end)
end

----------------------------------------------------------------------
-- Tab: UI
----------------------------------------------------------------------

local function BuildUITab(parent)
    local function row(text, onClick, anchor, y)
        local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
        b:SetSize(180, 24)
        b:SetText(text)
        b:SetPoint("TOPLEFT", anchor, anchor == parent and "TOPLEFT" or "BOTTOMLEFT", anchor == parent and 12 or 0, y or -8)
        b:SetScript("OnClick", onClick)
        return b
    end

    local blackscreen = CreateFrame("Frame", nil, UIParent)
    blackscreen:SetAllPoints(UIParent)
    blackscreen:SetFrameStrata("FULLSCREEN_DIALOG")
    blackscreen.tex = blackscreen:CreateTexture(nil, "ARTWORK")
    blackscreen.tex:SetAllPoints(blackscreen)
    blackscreen.tex:SetColorTexture(0, 0, 0, 1)
    blackscreen:Hide()

    local reload = row("ReloadUI", C_UI.Reload, parent, -12)
    local black = row("Toggle black screen", function()
        if blackscreen:IsShown() then blackscreen:Hide() else blackscreen:Show() end
    end, reload)
    row("Reset frame position", function()
        SetOption("debugFramePos", nil)
        if panel then
            panel:ClearAllPoints()
            panel:SetPoint("CENTER")
        end
    end, black)
end

----------------------------------------------------------------------
-- Panel construction
----------------------------------------------------------------------

local function CreatePanel()
    if panel then return panel end

    panel = CreateFrame("Frame", "LMKDebugPanel", UIParent, "BackdropTemplate")
    panel:SetSize(620, 460)
    panel:SetFrameStrata("HIGH")
    panel:SetMovable(true)
    panel:EnableMouse(true)
    panel:SetClampedToScreen(true)
    panel:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 },
    })

    local pos = GetOption("debugFramePos")
    if pos and pos.point then
        panel:ClearAllPoints()
        panel:SetPoint(pos.point, UIParent, pos.relativePoint or pos.point, pos.x or 0, pos.y or 0)
    else
        panel:SetPoint("CENTER")
    end

    -- Title bar
    local title = CreateFrame("Frame", nil, panel)
    title:SetPoint("TOPLEFT", 12, -12)
    title:SetPoint("TOPRIGHT", -12, -12)
    title:SetHeight(20)
    title:EnableMouse(true)
    title:RegisterForDrag("LeftButton")
    title:SetScript("OnDragStart", function() panel:StartMoving() end)
    title:SetScript("OnDragStop", function()
        panel:StopMovingOrSizing()
        local point, _, relativePoint, x, y = panel:GetPoint(1)
        SetOption("debugFramePos", { point = point, relativePoint = relativePoint, x = x, y = y })
    end)
    local titleText = title:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleText:SetPoint("LEFT")
    titleText:SetText("LMK Debug")

    local close = CreateFrame("Button", nil, panel, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -4, -4)
    close:SetScript("OnClick", function() Addon.HideDebug() end)

    -- Status bar
    local status = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    status:SetPoint("TOPLEFT", 16, -36)
    status:SetPoint("TOPRIGHT", -16, -36)
    status:SetJustifyH("LEFT")
    status:SetWordWrap(false)
    panel.statusText = status

    local statusElapsed = 0
    panel:SetScript("OnUpdate", function(_, e)
        statusElapsed = statusElapsed + e
        if statusElapsed < STATUS_INTERVAL then return end
        statusElapsed = 0
        Addon.UpdateDebugStatus()
    end)

    -- Tab strip
    local tabStrip = CreateFrame("Frame", nil, panel)
    tabStrip:SetPoint("TOPLEFT", 12, -56)
    tabStrip:SetPoint("TOPRIGHT", -12, -56)
    tabStrip:SetHeight(24)

    local tabContent = CreateFrame("Frame", nil, panel, "BackdropTemplate")
    tabContent:SetPoint("TOPLEFT", 16, -84)
    tabContent:SetPoint("BOTTOMRIGHT", -16, 16)
    tabContent:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    tabContent:SetBackdropColor(0, 0, 0, 0.4)
    panel.tabContent = tabContent

    local x = 0
    for _, name in ipairs(TAB_ORDER) do
        local btn = CreateFrame("Button", nil, tabStrip, "UIPanelButtonTemplate")
        btn:SetSize(100, 22)
        btn:SetPoint("TOPLEFT", x, 0)
        btn:SetText(name)
        btn:SetScript("OnClick", function() Addon.SwitchDebugTab(name) end)
        local content = CreateFrame("Frame", nil, tabContent)
        content:SetAllPoints()
        content:Hide()
        tabs[name] = { button = btn, content = content }
        x = x + 102
    end

    BuildInspectTab(tabs.Inspect.content)
    BuildCommsTab(tabs.Comms.content)
    BuildDBTab(tabs.DB.content)
    BuildFixturesTab(tabs.Fixtures.content)
    BuildUITab(tabs.UI.content)

    panel:Hide()
    return panel
end

function Addon.SwitchDebugTab(name)
    if not panel or not tabs[name] then return end
    SetOption("debugTab", name)
    for n, t in pairs(tabs) do
        if n == name then
            t.content:Show()
            t.button:Disable()
            if t.onShow then t.onShow() end
        else
            t.content:Hide()
            t.button:Enable()
            if t.onHide then t.onHide() end
        end
    end
end

function Addon.UpdateDebugStatus()
    if not panel or not panel:IsShown() then return end
    local week = Addon.GetWeek and Addon.GetWeek() or 0
    local key, level, score = 0, 0, 0
    if Addon.Mykey then
        key = Addon.Mykey.current_key or 0
        level = Addon.Mykey.current_keylevel or 0
        score = Addon.Mykey.mplus_score or 0
    end
    local guild = GetGuildInfo("player") or "none"
    local partyN = CountTable(Addon.PartyKeys)
    local altsN = CountTable(LibMythicKeystoneDB and LibMythicKeystoneDB.Alts)
    local guildN = CountTable(LibMythicKeystoneDB and LibMythicKeystoneDB.Guilds and LibMythicKeystoneDB.Guilds[guild])
    local tx, rx, dry = 0, 0, 0
    for _, e in ipairs(commBuffer) do
        if e.direction == "TX" then tx = tx + 1
        elseif e.direction == "RX" then rx = rx + 1
        elseif e.direction == "DRY" then dry = dry + 1 end
    end
    local flags = ""
    if Addon.dryrun then flags = flags .. "   |cffff8844[DRY-RUN]|r" end
    if not Addon.legacyWire then flags = flags .. "   |cffff8844[LEGACY OFF]|r" end
    panel.statusText:SetText(string.format(
        "Week %d  |  Key %d:%d  |  Score %d   ||   Party %d  |  Alts %d  |  Guild[%s] %d   ||   TX %d  RX %d  DRY %d%s",
        week, key, level, score, partyN, altsN, guild, guildN, tx, rx, dry, flags))
end

----------------------------------------------------------------------
-- Public show/hide/toggle
----------------------------------------------------------------------

function Addon.ShowDebug()
    Addon.debug = true
    SetOption("debug", true)
    CreatePanel()
    panel:Show()
    Addon.SwitchDebugTab(GetOption("debugTab", "Inspect"))
end

function Addon.HideDebug()
    if panel then panel:Hide() end
    Addon.debug = false
    SetOption("debug", false)
end

function Addon.ToggleDebug()
    if panel and panel:IsShown() then Addon.HideDebug() else Addon.ShowDebug() end
end

----------------------------------------------------------------------
-- Bootstrap
----------------------------------------------------------------------

local boot = CreateFrame("Frame")
boot:RegisterEvent("PLAYER_LOGIN")
boot:SetScript("OnEvent", function(self)
    self:UnregisterEvent("PLAYER_LOGIN")
    Addon.dryrun = GetOption("dryrun", false) and true or false
    Addon.legacyWire = GetOption("legacyWire", true) and true or false
    if GetOption("debug", false) then Addon.ShowDebug() end
end)

----------------------------------------------------------------------
-- Slash commands
----------------------------------------------------------------------

local function Dump(label, t)
    print("|cffaaaaff" .. label .. ":|r")
    DevTools_Dump(t)
end

local function PrintHelp()
    print("|cff66ff66LMK debug commands:|r")
    print("  /lmk debug            toggle panel")
    print("  /lmk debug on|off     force panel on/off (persisted)")
    print("  /lmk show <party|mykey|alts|guild|all>")
    print("  /lmk broadcast        LKS.Request PARTY + GUILD")
    print("  /lmk request          alias of broadcast")
    print("  /lmk reset            wipe Alts + Guilds (no confirmation)")
    print("  /lmk fake <party|alt|guild>")
    print("  /lmk wipefakes        remove all _fake entries")
    print("  /lmk dryrun on|off    block outgoing TX (log as DRY)")
    print("  /lmk legacy on|off    toggle legacy MythicKeystone wire compat")
    print("  /lmk log on|off|clear")
end

SLASH_LMK1 = "/lmk"
SlashCmdList["LMK"] = function(msg)
    msg = msg or ""
    local cmd, rest = msg:match("^(%S*)%s*(.*)$")
    cmd = (cmd or ""):lower()
    rest = (rest or ""):lower()

    if cmd == "" or cmd == "debug" then
        if rest == "on" then Addon.ShowDebug()
        elseif rest == "off" then Addon.HideDebug()
        else Addon.ToggleDebug() end
        return
    end

    if cmd == "help" or cmd == "?" then PrintHelp() return end

    if cmd == "show" then
        local target = rest
        if target == "party" then Dump("PartyKeys", Addon.PartyKeys)
        elseif target == "mykey" then Dump("Mykey", Addon.Mykey)
        elseif target == "alts" then Dump("Alts", LibMythicKeystoneDB and LibMythicKeystoneDB.Alts)
        elseif target == "guild" then
            local g = GetGuildInfo("player") or "none"
            Dump("Guilds[" .. g .. "]", LibMythicKeystoneDB and LibMythicKeystoneDB.Guilds and LibMythicKeystoneDB.Guilds[g])
        elseif target == "all" or target == "" then
            Dump("Mykey", Addon.Mykey)
            Dump("PartyKeys", Addon.PartyKeys)
            Dump("Alts", LibMythicKeystoneDB and LibMythicKeystoneDB.Alts)
            local g = GetGuildInfo("player") or "none"
            Dump("Guilds[" .. g .. "]", LibMythicKeystoneDB and LibMythicKeystoneDB.Guilds and LibMythicKeystoneDB.Guilds[g])
        else
            print("|cffff5555LMK:|r unknown show target '" .. target .. "'")
        end
        return
    end

    if cmd == "broadcast" or cmd == "request" then
        local LKS = LibStub("LibKeystone", true)
        if LKS then
            LKS.Request("PARTY")
            LKS.Request("GUILD")
            print("|cff66ff66LMK:|r broadcast requested.")
        else
            print("|cffff5555LMK:|r LibKeystone not loaded.")
        end
        return
    end

    if cmd == "reset" then
        LibMythicKeystoneDB = LibMythicKeystoneDB or {}
        LibMythicKeystoneDB["Alts"] = {}
        LibMythicKeystoneDB["Guilds"] = {}
        print("|cffff5555LMK:|r DB reset.")
        return
    end

    if cmd == "fake" then
        if rest == "party" then AddFakeParty(); print("|cff66ff66LMK:|r fake party member added.")
        elseif rest == "alt" then AddFakeAlt(); print("|cff66ff66LMK:|r fake alt added.")
        elseif rest == "guild" then AddFakeGuild()
        else print("|cffff5555LMK:|r usage: /lmk fake <party|alt|guild>") end
        return
    end

    if cmd == "wipefakes" then
        local n = WipeFakes()
        print(string.format("|cff66ff66LMK:|r removed %d fake entries.", n))
        return
    end

    if cmd == "dryrun" then
        if rest == "on" then Addon.dryrun = true; SetOption("dryrun", true); print("|cffff8844LMK:|r dry-run ON.")
        elseif rest == "off" then Addon.dryrun = false; SetOption("dryrun", false); print("|cff66ff66LMK:|r dry-run OFF.")
        else print("|cffff5555LMK:|r usage: /lmk dryrun <on|off>") end
        return
    end

    if cmd == "log" then
        if rest == "on" then SetOption("commLogOn", true); print("|cff66ff66LMK:|r comm log ON.")
        elseif rest == "off" then SetOption("commLogOn", false); print("|cff66ff66LMK:|r comm log OFF.")
        elseif rest == "clear" then wipe(commBuffer); print("|cff66ff66LMK:|r comm log cleared.")
        else print("|cffff5555LMK:|r usage: /lmk log <on|off|clear>") end
        return
    end

    if cmd == "legacy" then
        if rest == "on" then Addon.legacyWire = true; SetOption("legacyWire", true); print("|cff66ff66LMK:|r legacy wire ON.")
        elseif rest == "off" then Addon.legacyWire = false; SetOption("legacyWire", false); print("|cffff8844LMK:|r legacy wire OFF.")
        else print("|cffff5555LMK:|r usage: /lmk legacy <on|off>") end
        return
    end

    print("|cffff5555LMK:|r unknown command '" .. cmd .. "'. Try /lmk help")
end
