local myname, ns = ...

local L = LibStub("AceLocale-3.0"):NewLocale(myname, "frFR", false)
if not L then return end

L["AddonName"] = "Clés Mythiques"
L["Alts"] = "Personnages"
L["Guild"] = "Guilde"
L["Group"] = "Groupe"
L["Refresh"] = "Cliquez pour rafraîchir."
L["ReadyCheck"] = "Appel"
L["Countdown"] = "Décompte"
L["Countdown_cancel"] = "Annuler"
L["Ready"] = "Prêt ?"
L["DungeonCountdown"] = "MythicKeystone: Activation de la clé dans 5 secondes, attachez votre ceinture et préparez-vous."
L["DungeonStarted"] = "MythicKeystone: Clé insérée, profitez de la run, faites de votre mieux et attention aux flammes !"
L["DungeonCountdownStop"] = "MythicKeystone: Activation de la clé annulée."
ns.completionMessagesSuccess = {
    "MythicKeystone : GG tout le monde, merci pour la run !",
    "MythicKeystone : Bien joué à tous, à la prochaine !",
    "MythicKeystone : Donjon terminé ! Merci pour la run !",
    "MythicKeystone : Run complétée ! Merci à tous !",
}
ns.completionMessagesFailure = {
    "MythicKeystone : On n'a pas passé le timer, mais merci à tous pour l'effort !",
    "MythicKeystone : Pas notre meilleure run, mais on a fini. GG !",
    "MythicKeystone : Le timer nous a eu cette fois, mais merci d'être restés !",
    "MythicKeystone : On fera mieux la prochaine fois. Merci pour la run !",
}
L["Options"] = "Options"
L["CompletionMessage"] = "Message chat à la complétion"