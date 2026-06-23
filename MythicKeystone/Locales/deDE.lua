local myname, ns = ...

local L = LibStub("AceLocale-3.0"):NewLocale(myname, "deDE", false)
if not L then return end

L["AddonName"] = "Mythic Keystones"
L["Alts"] = "Figuren"
L["Countdown"] = "Countdown"
L["Countdown_cancel"] = "beenden"
L["Group"] = "Gruppe"
L["Guild"] = "Gilde"
L["ReadyCheck"] = "Bereitschaftsprüfung"
L["Refresh"] = "Klicken Sie zum Aktualisieren."
L["Ready"] = "Bereit ?"
L["DungeonCountdown"] = "MythicKeystone: Schlüsselaktivierung in 5 Sekunden, schnallt euch an und macht euch bereit."
L["DungeonStarted"] = "MythicKeystone: Schlüssel eingesetzt, viel Spaß beim Run, gebt euer Bestes und passt auf die Flammen auf!"
L["DungeonCountdownStop"] = "MythicKeystone: Schlüsselaktivierung gestoppt."

-- Teleport-Schaltflächen
L["TELEPORT_hide"] = "Teleports ausblenden"
L["TELEPORT_show"] = "Teleports anzeigen"

-- Options panel (English placeholders, awaiting German translation)
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
L["OPT_btn_tooltip"]    = "Optionen"

-- About popup (English placeholders, awaiting German translation)
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
