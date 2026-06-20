local myname, ns = ...

local L = LibStub("AceLocale-3.0"):NewLocale(myname, "zhTW", false)
if not L then return end

L["AddonName"] = "傳奇鑰石"
L["Alts"] = "其他角色"
L["Countdown"] = "倒數"
L["Countdown_cancel"] = "取消"
L["Group"] = "隊伍"
L["Guild"] = "公會"
L["ReadyCheck"] = "準備確認"
L["Refresh"] = "點擊來刷新。"
L["Ready"] = "準備好了？"
L["DungeonCountdown"] = "MythicKeystone: 鑰石將在5秒後啟動，繫好安全帶，準備出發。"
L["DungeonStarted"] = "MythicKeystone: 鑰石已插入，享受這次挑戰，盡力而為，小心火焰！"
L["DungeonCountdownStop"] = "MythicKeystone: 鑰石啟動已取消。"

-- 傳送按鈕
L["TELEPORT_hide"] = "隱藏傳送"
L["TELEPORT_show"] = "顯示傳送"

-- Options panel (English placeholders, awaiting Chinese translation)
L["OPT_showAlts"]       = "Show Alts panel"
L["OPT_showAlts_tip"]   = "Display your alts' keystones on the LFG frame."
L["OPT_showGroup"]      = "Show Group panel"
L["OPT_showGroup_tip"]  = "Display your party members' keystones."
L["OPT_showGuild"]      = "Show Guild panel"
L["OPT_showGuild_tip"]  = "Display your guild's keystones."
L["OPT_teleports"]      = "Show teleport buttons"
L["OPT_teleports_tip"]  = "Show dungeon teleport buttons on the Mythic+ UI."
L["OPT_autoSlot"]       = "Auto-slot keystone"
L["OPT_autoSlot_tip"]   = "Automatically slot your keystone when opening the Mythic+ UI."
L["OPT_readyCheck"]     = "Show Ready Check button"
L["OPT_readyCheck_tip"] = "Add a Ready Check button to the Mythic+ start dialog."
L["OPT_countdown"]      = "Show Countdown button"
L["OPT_countdown_tip"]  = "Add a Countdown button to the Mythic+ start dialog."

-- About popup (English placeholders, awaiting Chinese translation)
L["ABOUT_btn_tooltip"]      = "About this addon"
L["ABOUT_title"]            = "About MythicKeystone"
L["ABOUT_author"]           = "By Willou"
L["ABOUT_description"]      = "Your keys, your alts' keys, your party's keys and your guild's keys — all in the LFG frame, in real time."
L["ABOUT_other_header"]     = "Check out Mythic Dungeon Notes too"
L["ABOUT_other_pitch"]      = "Every dungeon strategy and boss note, in-game and one click away."
L["ABOUT_other_feature_1"]  = "• All Mythic+ dungeons covered"
L["ABOUT_other_feature_2"]  = "• Boss strategies, trash tips, interrupts"
L["ABOUT_other_feature_3"]  = "• Auto zone detection opens the right guide"
L["ABOUT_other_feature_4"]  = "• Integrated teleport buttons"
L["ABOUT_other_companion"]  = "Everything in a clean two-column reader, with maps and spell icons."
L["ABOUT_links_header"]     = "Links"
L["ABOUT_link_curseforge"]  = "CurseForge"
L["ABOUT_link_wago"]        = "Wago"
L["ABOUT_link_github"]      = "GitHub"
L["ABOUT_url_popup_text"]   = "Copy this URL with Ctrl+C:"
