local myname, ns = ...

local L = LibStub("AceLocale-3.0"):NewLocale(myname, "enUS", true)

L["Ready"] = "Ready ?"
L["DungeonCountdown"] = "MythicKeystone: Keystone activation in 5 seconds, fasten your seatbelt and get ready."
L["DungeonStarted"] = "MythicKeystone: Keystone inserted, enjoy the run, do your best and watch out for the flames!"
L["DungeonCountdownStop"] = "MythicKeystone: Keystone activation stopped."

L["AddonName"] = "Mythic Keystones"
L["Alts"] = "Alts"
L["Guild"] = "Guild"
L["Group"] = "Group"
L["Refresh"] = "Clic to refresh."
L["ReadyCheck"] = "Ready Check"
L["Countdown"] = "Countdown"
L["Countdown_cancel"] = "Cancel"
ns.completionMessagesSuccess = {
    "MythicKeystone: GG everyone, thanks for the run!",
    "MythicKeystone: We crushed it! Great run everyone!",
    "MythicKeystone: That's a wrap! Amazing group!",
    "MythicKeystone: Well played everyone, see you next time!",
    "MythicKeystone: Dungeon down! Thanks for the run!",
    "MythicKeystone: Outstanding work team, you were flawless!",
    "MythicKeystone: Flawless victory! Nice run!",
    "MythicKeystone: Champions! Thanks for the run!",
    "MythicKeystone: Key done! Upgraded or not, you were awesome!",
    "MythicKeystone: You're all legends. Thanks for the run!",
    "MythicKeystone: The dungeon didn't stand a chance. GG!",
    "MythicKeystone: Smooth run! Thanks everyone!",
    "MythicKeystone: Keystoned to perfection! Well done!",
    "MythicKeystone: We made it look easy. GG!",
    "MythicKeystone: Hats off to this group! Amazing run!",
    "MythicKeystone: All bosses down! Thanks for the run!",
    "MythicKeystone: Perfect teamwork! GG everyone!",
    "MythicKeystone: Run complete! You're all stars!",
}
ns.completionMessagesFailure = {
    "MythicKeystone: We didn't time it, but thanks for the effort everyone!",
    "MythicKeystone: Not our best run, but we finished it. GG!",
    "MythicKeystone: The timer beat us today, but thanks for sticking through!",
    "MythicKeystone: No upgrade this time, but we'll get it next time!",
    "MythicKeystone: Rough one, but we made it. Thanks for the run!",
}
L["Options"] = "Options"
L["CompletionMessage"] = "Chat message on completion"
