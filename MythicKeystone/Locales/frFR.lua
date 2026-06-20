local myname = ...

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

-- Boutons de téléportation
L["TELEPORT_hide"] = "Masquer les téléports"
L["TELEPORT_show"] = "Afficher les téléports"

-- Popup À propos
L["ABOUT_btn_tooltip"]      = "À propos de l'addon"
L["ABOUT_title"]            = "À propos de MythicKeystone"
L["ABOUT_author"]           = "Par Willou"
L["ABOUT_description"]      = "Vos clés, celles de vos alts, de votre groupe et de votre guilde — rassemblées dans la fenêtre LFG, en temps réel."
L["ABOUT_other_header"]     = "Découvrez aussi Mythic Dungeon Notes"
L["ABOUT_other_pitch"]      = "Toutes les stratégies de donjon et notes de boss directement en jeu, accessibles en un clic."
L["ABOUT_other_feature_1"]  = "• Tous les donjons Mythique+ couverts"
L["ABOUT_other_feature_2"]  = "• Stratégies de boss, trash, interrupts"
L["ABOUT_other_feature_3"]  = "• Détection automatique de la zone"
L["ABOUT_other_feature_4"]  = "• Boutons de téléportation intégrés"
L["ABOUT_other_companion"]  = "Le tout dans un lecteur clair en deux colonnes, avec cartes et icônes de sorts."
L["ABOUT_links_header"]     = "Liens"
L["ABOUT_link_curseforge"]  = "CurseForge"
L["ABOUT_link_wago"]        = "Wago"
L["ABOUT_link_github"]      = "GitHub"
L["ABOUT_url_popup_text"]   = "Copiez cette URL avec Ctrl+C :"