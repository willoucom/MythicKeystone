local myname, ns = ...

local L = LibStub("AceLocale-3.0"):NewLocale(myname, "frFR")
if not L then return end


-- Chaînes de l'interface Guide
L["GUIDE_back_btn"]       = "Retour à la Liste"
L["GUIDE_coming_soon"]    = "(à venir)"
L["GUIDE_wip"]            = "Le guide de ce donjon est en cours de rédaction."
L["GUIDE_s1_header"]      = "Donjons Midnight — Saison 1"
L["GUIDE_other_dungeons"] = "Autres donjons"
L["GUIDE_tooltip_click"]  = "Clic gauche : ouvrir / fermer"
L["GUIDE_tooltip_drag"]   = "Glisser : déplacer le bouton"
L["GUIDE_vignette_tooltip"] = "Ouvrir le guide du donjon"
L["GUIDE_portal_tooltip"]   = "Se téléporter dans ce donjon"

-- Labels communs
L["COMMON_intro_label"]     = "Introduction"
L["COMMON_notable_trash"]   = "Trash notable"
L["COMMON_cc_immune"]       = "• Immunisé aux CC"

-------------------------------------------------------------------------------
-- Midnight — Donjons Legacy S1
-------------------------------------------------------------------------------

-- Académie d'Algeth'ar (AA) — uiMapId 2097
L["AA_name"]              = "Académie d'Algeth'ar"
L["AA_entrance_label"]    = "Entrée"
L["AA_entrance_desc"]     = "Chaque professeur vous octroie un buff selon le type de sa Légion."
L["AA_bronze_drake_desc"] = "Bronze"
L["AA_bronze_drake"]      = "Hâte"
L["AA_red_drake_desc"]    = "Rouge"
L["AA_red_drake"]         = "Polyvalence"
L["AA_green_drake_desc"]  = "Vert"
L["AA_green_drake"]       = "Soins"
L["AA_blue_drake_desc"]   = "Bleu"
L["AA_blue_drake"]        = "Maîtrise"
L["AA_black_drake_desc"]  = "Noir"
L["AA_black_drake"]       = "Chance de Coup Critique"

-- Noms des sections
L["AA_boss1"]             = "Premier boss : Ancien Embroussaillé"
L["AA_boss2"]             = "Deuxième boss : Tricérabec"
L["AA_boss3"]             = "Troisième boss : Vexamus"
L["AA_boss4"]             = "Quatrième boss : Écho de Doragosa"
L["AA_trash_label"]       = "Trash"

-- Noms des mobs
L["AA_boss1_name"]        = "Ancien Embroussaillé"
L["AA_boss1_branch_name"] = "Branche Ancienne"
L["AA_boss2_name"]        = "Tricérabec"
L["AA_boss3_name"]        = "Vexamus"
L["AA_boss4_name"]        = "Écho de Doragosa"
L["AA_trash1_mob1_name"]  = "Flagellant ignoble"
L["AA_trash1_mob2_name"]  = "Libellonne exaspérée"
L["AA_trash2_mob1_name"]  = "Factionnaire Gardien"
L["AA_trash2_mob2_name"]  = "Aigle Alpha"
L["AA_trash3_mob1_name"]  = "Corrupted Manafiend"
L["AA_trash3_mob2_name"]  = "Spellbound Battleaxe"
L["AA_trash3_mob3_name"]  = "Arcane Ravager"
L["AA_trash3_mob4_name"]  = "Arcane Forager"
L["AA_trash3_mob5_name"]  = "Unruly Textbook"
L["AA_trash4_mob1_name"]  = "Algeth'ar Echoknight"
L["AA_trash4_mob2_name"]  = "Spectral Invoker"

-- Descriptions — Trash 1
L["AA_trash1_mob1_desc1"] = "• %s — Cible le tank, surveiller les stacks ; utiliser des défensifs ou purger le saignement si nécessaire."
L["AA_trash1_mob1_desc2"] = "• %s — Fait apparaître un tourbillon sous chaque joueur, à esquiver."
L["AA_trash1_mob2_desc1"] = "Restez groupés pour cleaver efficacement ces mobs."
L["AA_trash1_mob2_desc2"] = "Essayez de les Apaiser si possible."
L["AA_trash1_mob2_desc3"] = "• Le tank doit surveiller les stacks de %s."
L["AA_trash1_mob2_desc4"] = "• %s — Cible un joueur aléatoire."

-- Descriptions — Boss 1
L["AA_boss1_desc0"]       = "Restez groupés sur le tank le plus possible."
L["AA_boss1_desc1"]       = "Attention à %s : tournez lentement sur la gauche en restant groupés."
L["AA_boss1_desc2"]       = "• À 100 énergie, le boss utilise %s et fait apparaître une |cff44FF44Branche Ancienne|r."
L["AA_boss1_desc3"]       = "• Interrompez absolument le soin %s."
L["AA_boss1_desc4"]       = "• À sa mort, la |cff44FF44Branche Ancienne|r laisse %s (cercle vert au sol) qui retire les %s si vous y entrez."

-- Descriptions — Trash 2
L["AA_trash2_mob1_desc1"] = "• %s — Cible le tank, utiliser un défensif."
L["AA_trash2_mob1_desc2"] = "• %s — Cible un joueur aléatoire et fait apparaître une tornade à éviter."
L["AA_trash2_mob1_desc3"] = "• %s — AoE de zone à fuir ou à passer en Line of Sight."
L["AA_trash2_mob2_desc1"] = "• %s — Frontal dirigé vers une cible aléatoire, à éviter (risque de chûte)."

-- Descriptions — Boss 2
L["AA_boss2_desc0"]       = "• Le tank doit avoir un défensif actif à chaque hit de %s et pour son DoT."
L["AA_boss2_desc0b"]      = "À noter : cet effet n'est pas considéré comme un saignement en Midnight."
L["AA_boss2_desc1"]       = "• Écartez-vous et arrêtez tous les sorts pendant %s."
L["AA_boss2_desc2"]       = "• À 75% et 45%, lancez les trois balles dans la même direction."

-- Descriptions — Trash 3
L["AA_trash3_mob1_desc1"] = "• %s — Cible un joueur aléatoire, à interrompre."
L["AA_trash3_mob1_desc2"] = "• %s — Cible un joueur aléatoire ; ne restez pas groupés, utiliser un défensif si nécessaire."
L["AA_trash3_mob2_desc1"] = "• Le tank doit savoir que ces mobs infligent des dégâts arcaniques bonus passifs via le buff %s."
L["AA_trash3_mob3_desc1"] = "• %s — Charge le joueur le plus éloigné ; utiliser un défensif et rester groupé pour cleaver facilement."
L["AA_trash3_mob3_desc2"] = "• Immédiatement après la charge, un frontal %s est dirigé vers le tank : se décaler pour l'éviter."
L["AA_trash3_mob4_desc1"] = "• %s — Cible un joueur aléatoire ; attention aux burst damage en pack avec plusieurs de ces mobs."
L["AA_trash3_mob5_desc1"] = "• %s — Canal sur un joueur aléatoire ; interrompre, ou une fois commencé : CC ou dispel de magie."

-- Descriptions — Boss 3
L["AA_boss3_desc0"]       = "• %s — Frontal sur le tank : orienter loin du groupe et utiliser un défensif."
L["AA_boss3_desc1"]       = "• Absorbez une %s par vague, les orbes ne doivent pas toucher le boss. Prenez une orbe chacun."
L["AA_boss3_desc2"]       = "• %s pose exactement 3 zones au sol, bougez assez pour les éviter mais ne courrez pas partout."

-- Descriptions — Trash 4
L["AA_trash4_mob1_desc1"] = "• %s — AoE sous un joueur aléatoire, à esquiver rapidement."
L["AA_trash4_mob1_desc2"] = "• %s — Gros hit de raid, surveiller les PV et utiliser des défensifs si nécessaire."
L["AA_trash4_mob2_desc1"] = "• %s — Debuff sur un joueur aléatoire : priorité haute sur les interrupts."
L["AA_trash4_mob2_desc2"] = "• %s — Cible un joueur aléatoire, utiliser les interrupts disponibles."

-- Descriptions — Boss 4
L["AA_boss4_desc0"]       = "Tanker le boss près du mur, reculer progressivement pour éviter les flaques."
L["AA_boss4_desc1"]       = "Au pull, le boss lance immédiatement %s."
L["AA_boss4_desc2"]       = "• Chaque capacité encaissée donne un stack de %s. À 3 stacks, un %s apparaît sous les pieds — les placer le long du mur."
L["AA_boss4_desc3"]       = "• Les %s tirent périodiquement des orbes %s à esquiver."
L["AA_boss4_desc4"]       = "• %s — Cible un joueur aléatoire : restez légèrement espacés, utiliser un défensif (attention à %s — combo potentiellement fatal)."
L["AA_boss4_desc5"]       = "• %s — Aspire tous les joueurs vers le boss : Courez !"

-- Siège du Triumvirat (SOT) — uiMapId 903
L["SOT_name"]             = "Siège du Triumvirat"
-- Intro
L["SOT_intro_desc1"]      = "Siège du Triumvirat — Héritage Légion, Mac'Aree (Argus)."
L["SOT_intro_desc2"]      = "4 bosses : Zuraal the Ascended -> Saprish -> Viceroy Nezhar -> L'ura."
-- Trash notable
L["SOT_trash1_name"]      = "Subjugateur Impitoyable"
L["SOT_trash1_desc1"]     = "%s : cible tous les joueurs — se disperser légèrement pour éviter les dégâts de débordement. %s : absorption sur une cible aléatoire — soins prioritaires."
L["SOT_trash2_name"]      = "Invocateur des ténèbres"
L["SOT_trash2_desc1"]     = "%s : interrompre chaque cast sans exception. %s : cible secondaire pour les interruptions restantes."
L["SOT_trash3_name"]      = "Gardien de la Faille"
L["SOT_trash3_desc1"]     = "%s : rester impérativement dans les 30 yards — sinon explosion létale. %s : debuff magique sur des joueurs aléatoires — dispel. %s : dégâts massifs de groupe avec cercles à esquiver."
L["SOT_trash4_name"]      = "Champion des Gardes-ombres"
L["SOT_trash4_desc1"]     = "%s : gagne des stacks dangereux si personne n'est en mêlée — maintenir le contact. %s : enrage — soothe ou cooldowns défensifs du tank."
L["SOT_trash5_name"]      = "Fendeur du Vide acharne"
L["SOT_trash5_desc1"]     = "%s : buff puissant — interrompre ou purger immédiatement."
-- Boss 1 : Zuraal the Ascended
L["SOT_boss1_name"]       = "Zuraal l'Ascendant"
L["SOT_boss1_desc1"]      = "%s : applique un DoT et invoque 2 Coalesced Void qui explosent au contact du boss. %s : les accélère et aspire les joueurs — s'éloigner immédiatement du boss et tuer les adds avant qu'ils l'atteignent."
L["SOT_boss1_desc2"]      = "%s : saut sur un joueur aléatoire créant une flaque — se déplacer. %s : tank buster — défensif. %s : frontal sur une cible aléatoire — esquiver."
-- Boss 2 : Saprish
L["SOT_boss2_name"]       = "Saprish"
L["SOT_boss2_desc1"]      = "%s : dégâts massifs de groupe avec DoT — être au maximum de vie avant le cast. %s : dash créant des cercles pour éliminer les bombes de %s — esquiver les bombes résiduelles."
L["SOT_boss2_desc2"]      = "%s : capacité de la pet Darkfang nécessitant 2 interruptions — se superpose souvent à Phase Dash. %s : dégâts sur une cible aléatoire de la pet."
-- Boss 3 : Viceroy Nezhar
L["SOT_boss3_name"]       = "Vice-roi Nezhar"
L["SOT_boss3_desc1"]      = "%s : invoque 3 portes générant des %s — rester mobile et anticiper les trajectoires. %s : se rapprocher du boss pendant le canal pour réduire les dégâts de groupe."
L["SOT_boss3_desc2"]      = "%s : invoque 5 adds canalisant Mind Flay — les tuer en cleave rapidement. %s : ciblant le tank — maintenir une rotation d'interruptions. %s : cible 3 joueurs — défensifs."
-- Boss 4 : L'ura
L["SOT_boss4_name"]       = "L'ura"
L["SOT_boss4_desc1"]      = "%s : frappe de groupe invoquant 6 Notes. %s : chaque note active applique un stack toutes les 2s — utiliser %s pour les silencer dès leur apparition via %s."
L["SOT_boss4_desc2"]      = "%s : repositionne les notes et applique des stacks d'Anguish — silencer les notes en priorité. %s : rayons rotatifs — se déplacer constamment."
L["SOT_boss4_desc3"]      = "%s : debuff stackant sur le tank — à 3 stacks déclenche une frappe ombre puissante ; utiliser un défensif ou tourner le boss. %s : debuff du boss pendant l'intermission — garder les cooldowns pour cette phase."

-- Orée-du-Ciel (SKY) — uiMapId 601/602
L["SKY_name"]             = "Orée-du-Ciel"
-- Intro
L["SKY_intro_desc1"]      = "Orée-du-Ciel — Héritage Warlords of Draenor, structure Arakkoa."
L["SKY_intro_desc2"]      = "4 bosses : Ranjit -> Araknath -> Rukhran -> High Sage Viryx."
-- Trash notable
L["SKY_trash1_name"]      = "Maître-chakram Planant"
L["SKY_trash1_desc1"]     = "%s : chakram ricochant entre les joueurs proches — s'écarter des alliés pour limiter les rebonds."
L["SKY_trash2_name"]      = "Prêtresse du Soleil Aveuglant"
L["SKY_trash2_desc1"]     = "%s : interrompre sans exception. %s : buff sur elle-même — purger immédiatement."
L["SKY_trash3_name"]      = "Tranchegriffe Orné"
L["SKY_trash3_desc1"]     = "%s : charge ciblant le tank et 2 joueurs aléatoires. %s : tank buster — défensif."
L["SKY_trash4_name"]      = "Invocateur de Bourrasque"
L["SKY_trash4_desc1"]     = "%s : interrompre pour éviter le knockback de groupe."
L["SKY_trash5_name"]      = "Élémentaire Solaire"
L["SKY_trash5_desc1"]     = "%s : invoque des Solar Orbs — kill prioritaire pour éviter %s (cercles de feu)."
L["SKY_trash6_name"]      = "Corbeau Sinistre"
L["SKY_trash6_desc1"]     = "%s : knockback de zone — se positionner contre un mur. %s : dégâts élevés — défensifs."
-- Boss 1 : Ranjit
L["SKY_boss1_name"]       = "Ranjit"
L["SKY_boss1_desc1"]      = "%s : crée des orbes de vent avec knockback — déposer les orbes hors du couloir de déplacement du groupe. %s : invoque des tornades — rester mobile."
L["SKY_boss1_desc2"]      = "%s : applique un saignement à tout le groupe — cooldowns de soins. %s : projectile vers un joueur aléatoire qui revient vers le boss — se déplacer latéralement pour l'éviter."
-- Boss 2 : Araknath
L["SKY_boss2_name"]       = "Araknath"
L["SKY_boss2_desc1"]      = "%s : des Lesser Constructs envoient des faisceaux vers le boss par groupes de 3 — les tuer avant qu'ils l'atteignent, sinon %s inflige des dégâts massifs de groupe."
L["SKY_boss2_desc2"]      = "%s : évitable si le tank reste en mêlée permanente. %s : AoE de 5 yards sous le boss — ne jamais rester dessous. %s : attaque en ligne — tank se positionner perpendiculairement au groupe."
-- Boss 3 : Rukhran
L["SKY_boss3_name"]       = "Rukhran"
L["SKY_boss3_desc1"]      = "%s : invoque des Sunwings — swap prioritaire sur les adds. %s : fixate sur un joueur avec pulsations — ce joueur s'éloigne du groupe."
L["SKY_boss3_desc2"]      = "%s : se cacher derrière le pilier central pour bloquer les projectiles. %s : tank buster — défensif à chaque cast. %s : cast si le tank sort du corps-à-corps — rester en mêlée."
-- Boss 4 : High Sage Viryx
L["SKY_boss4_name"]       = "Haute Sage Viryx"
L["SKY_boss4_desc1"]      = "%s : maintenir une rotation d'interruptions. %s : cible 3 joueurs — se disperser pour éviter les dégâts de débordement."
L["SKY_boss4_desc2"]      = "%s : entraîne un joueur aléatoire hors de la plateforme — retourner immédiatement via le chemin latéral. %s : rayon poursuivant laissant un sillage de feu — courir en cercle pour ne pas bloquer la zone."

-- Fosse de Saron (POS) — uiMapId 184
L["POS_name"]             = "Fosse de Saron"
-- Intro
L["POS_intro_desc1"]      = "Fosse de Saron — Héritage Wrath of the Lich King, Icecouronne."
L["POS_intro_desc2"]      = "3 bosses : Forgemaster Garfrost -> Ick &amp; Krick -> Scourgelord Tyrannus."
L["POS_intro_desc3"]      = "Un gauntlet de Frostsworn Generals précède le troisième boss."
-- Trash notable
L["POS_trash1_name"]      = "Liche Pulsante de Terreur"
L["POS_trash1_desc1"]     = "%s : cast ciblant le tank — interrompre absolument, dégâts très élevés. %s : déclenché à 50%% de vie, pulse toutes les 2s — cooldowns de groupe. %s : cible aléatoire — défensif."
L["POS_trash2_name"]      = "Nécrolyte de Chuchotmort"
L["POS_trash2_desc1"]     = "%s : les sbires sont immunisés tant que le Necrolyte est vivant — focus le caster en premier. %s : buff sur un sbire aléatoire — purger."
L["POS_trash3_name"]      = "Cadavre Arcaniste"
L["POS_trash3_desc1"]     = "%s : grand AoE à interrompre — priorité haute."
L["POS_trash4_name"]      = "Pestiféré Traînant"
L["POS_trash4_desc1"]     = "%s : enrage — à calmer (Soothe). %s : crée des flaques intermittentes — garder la zone de combat dégagée."
L["POS_trash5_name"]      = "Spectre d'Os Givré"
L["POS_trash5_desc1"]     = "%s : cast interruptible. %s : debuff sur 2 joueurs — dispel ou effet de liberté."
L["POS_trash6_name"]      = "Glacieth (mini-boss)"
L["POS_trash6_desc1"]     = "%s : AoE sur tout le groupe — se disperser et kiter. %s : bouclier directionnel — se positionner dans le dos du mob pour garantir des coups critiques."
L["POS_trash7_name"]      = "Tourmenteur de Carrière & Exécuteur de Colère"
L["POS_trash7_desc1"]     = "%s : malédiction sur une cible aléatoire — dispel. %s : stacks sur le tank — surveiller le compteur."
-- Boss 1 : Forgemaster Garfrost
L["POS_boss1_name"]       = "Forgemaître Garfrost"
L["POS_boss1_desc1"]      = "%s : crée des flaques dangereuses au sol en ciblant 2 joueurs — s'écarter et détruire les morceaux de minerai pour dégager la zone."
L["POS_boss1_desc2"]      = "%s : le tank doit briser les blocs de minerai proches pour éviter l'étourdissement."
L["POS_boss1_desc3"]      = "%s : le boss canalise vers le fourneau le plus proche — se mettre à couvert derrière un bloc de minerai restant pour réduire les dégâts."
L["POS_boss1_desc4"]      = "%s : détruit un bloc de minerai et applique un debuff magique à 2 joueurs. %s : les dégâts passifs du boss augmentent avec le nombre de debuffs magiques actifs — les dispeler rapidement."
-- Boss 2 : Ick & Krick
L["POS_boss2_name"]       = "Ick & Krick"
L["POS_boss2_desc1"]      = "%s : les deux boss partagent leur pool de vie — focus sur un seul suffit."
L["POS_boss2_desc2"]      = "%s : invoque 2 ombres portant %s, une malédiction sur des cibles aléatoires — dispeler immédiatement."
L["POS_boss2_desc3"]      = "%s : cast interruptible de Krick — garder une interruption disponible. %s : frappe de tank créant une flaque — déplacer le boss hors de la flaque."
L["POS_boss2_desc4"]      = "%s : crée des flaques sous 4 joueurs aléatoires — se disperser. %s : fixate sur un joueur aléatoire pendant 7s — ce joueur doit s'éloigner, le groupe aide à gérer Ick."
-- Boss 3 : Scourgelord Tyrannus
L["POS_boss3_name"]       = "Seigneur-fléau Tyrannus"
L["POS_boss3_desc1"]      = "%s : knockback sur le tank suivi d'un saut d'attaque — défensif et anticipez le déplacement. %s et %s : cercles et canaux au sol — se déplacer constamment."
L["POS_boss3_desc2"]      = "%s : active les tas d'ossements %s qui invoquent des Rotlings et des Plaguespreaders. %s : les Rotlings appliquent des stacks de maladie sur le tank — défensifs. %s : cast interruptible des Plaguespreaders — priorité aux interruptions. %s : cibler les tas d'ossements proches pour mitiger les dégâts."

-------------------------------------------------------------------------------
-- Midnight — Nouveaux donjons S1
-------------------------------------------------------------------------------

-- Le val Aveuglant (BV) — uiMapId 2500
L["BV_name"]              = "Le val Aveuglant"

-- Tanière de Nalorakk (DN) — uiMapId 2513
L["DN_name"]              = "Tanière de Nalorakk"
L["DN_intro_label"]       = "Introduction"
L["DN_intro_desc"]        = "Tanière de Nalorakk — Midnight Saison 1, nouveau donjon."
L["DN_incense_label"]     = "Encens Protecteur"
L["DN_incense_desc"]      = "Un brasero d'Encens Protecteur est situé près de l'entrée du donjon."
L["DN_buff_alchemy_desc"] = "Les Alchimistes de Minuit (compétence 25) et les Druides en forme d'ours peuvent brûler l'encens : +1% Polyvalence pendant 10 minutes pour tout le groupe."

-- Terrasse des Magistères (MT) — uiMapId 2520
L["MT_name"]              = "Terrasse des Magistères"
L["MT_intro_label"]       = "Introduction"
L["MT_intro_desc1"]       = "Terrasse des Magistères — Midnight Saison 1, nouveau donjon."
L["MT_intro_desc2"]       = "4 bosses : Arcanotron Custos -> Seranel Cinglesoleil -> Gemellus -> Degentrius."
L["MT_library_note"]      = "Après la mort du premier ennemi dans la bibliothèque, un livre apparaît sur le lutrin — cliquez dessus pour octroyer +5%% de Hâte au groupe pendant 30 minutes."
L["MT_trash_label"]       = "Trash notable"
-- Noms de sections (titres de boss)
L["MT_boss1"]             = "Arcanotron Custos"
L["MT_boss2"]             = "Seranel Cinglesoleil"
L["MT_boss3"]             = "Gemellus"
L["MT_boss4"]             = "Degentrius"
-- Noms des mobs du trash
L["MT_trash_arcane_sentry_name"]      = "Sentinelle Arcanique"
L["MT_trash_arcane_magister_name"]    = "Magistre Arcanique"
L["MT_trash_sunblade_name"]           = "Exécuteur Lamélame du Soleil"
L["MT_trash_lightward_name"]          = "Guérisseur de la Lumière"
L["MT_trash_codex_name"]              = "Codex Animé"
L["MT_trash_pyromancer_name"]         = "Pyromancien Embrasé"
L["MT_trash_familiar_name"]           = "Familier Tissé de Sorts"
L["MT_trash_wyrm_name"]               = "Wyrm aux Écailles Scintillantes"
L["MT_trash_spellbreaker_name"]       = "Brise-sorts Gravé de Runes"
L["MT_trash_voidling_name"]           = "Voidling"
L["MT_trash_shredder_name"]           = "Déchiqueteur Âme-creuse"
L["MT_trash_voidwalker_name"]         = "Marcheur du Vide Redouté"
L["MT_trash_voidcaller_name"]         = "Invocateur du Vide de la Fissure Obscure"
L["MT_trash_unstable_name"]           = "Voidling Instable"
L["MT_trash_void_infuser_name"]       = "Terreur du Vide"
L["MT_trash_tyrant_name"]             = "Tyran Dévoreur"
-- Descriptions trash — Sentinelle Arcanique
L["MT_trash_arcane_sentry_desc1"]     = "• %s — Cible le tank ; utiliser un brise-racine ou un dispel de magie pour retirer l'effet."
L["MT_trash_arcane_sentry_desc2"]     = "• %s — Canal dirigé vers un joueur aléatoire ; éviter les flaques qu'il laisse au sol."
L["MT_trash_arcane_sentry_desc3"]     = "• Surveiller les PV et le positionnement lors du hit AoE et du knockback de %s."
-- Descriptions trash — Magistre Arcanique
L["MT_trash_arcane_magister_desc1"]   = "• %s — Cible un joueur aléatoire ; priorité haute sur les interrupts, et si l'un passe : dispel de magie pour le retirer."
L["MT_trash_arcane_magister_desc2"]   = "• %s — Cible un joueur aléatoire ; utiliser les interrupts disponibles."
-- Descriptions trash — Sunblade Enforcer
L["MT_trash_sunblade_desc1"]          = "• Le tank doit surveiller le buff magie %s et le purger si possible, sinon utiliser un défensif pour absorber les frappes amplifiées."
L["MT_trash_sunblade_desc2"]          = "• Ces mobs sont difficiles à kiter car ils utilisent %s pour combler l'écart."
-- Descriptions trash — Lightward Healer
L["MT_trash_lightward_desc1"]         = "• %s — Cible un joueur aléatoire ; utiliser un dispel de magie pour le retirer."
L["MT_trash_lightward_desc2"]         = "• %s — Buffe un allié aléatoire ; purger si possible."
-- Descriptions trash — Animated Codex
L["MT_trash_codex_desc1"]             = "• Ces mobs pulsent en permanence des dégâts AoE avec %s ; ne pas en pull trop à la fois, et être prêt avec des défensifs ou cooldowns de heal."
-- Descriptions trash — Blazing Pyromancer
L["MT_trash_pyromancer_desc1"]        = "• Interrompre |cffFF4444absolument|r chaque cast de %s."
L["MT_trash_pyromancer_desc2"]        = "• Être prêt avec des défensifs ou cooldowns de heal quand %s est actif."
L["MT_trash_pyromancer_desc3"]        = "• Éviter le hit AoE et la flaque créés par %s."
L["MT_trash_pyromancer_note"]         = "Après la Pyromancer, la porte de la bibliothèque s'ouvre et les bibliothécaires disparaissent. Dans la cour suivante, des |cffFFD700Energy Crystals|r sont dispersés : les interagir pour les drainer et obtenir un bonus temporaire de dégâts et de soins."
-- Descriptions trash — Spellwoven Familiar
L["MT_trash_familiar_desc1"]          = "• Attention au hit AoE de groupe de %s, particulièrement dangereux en combat avec d'autres mobs infligeant eux aussi des dégâts AoE."
-- Descriptions trash — Brightscale Wyrm
L["MT_trash_wyrm_desc1"]              = "• Échelonner les kills de ces mobs pour ne pas être submergé par leur cast à la mort %s ; se tenir proche d'eux à leur mort pour récupérer le buff à stacks qu'il applique."
-- Descriptions trash — Runed Spellbreaker
L["MT_trash_spellbreaker_desc1"]      = "• %s — Cible 2 joueurs aléatoires ; surveiller les PV si ciblé, et être prêt à utiliser défensifs ou potions de vie."
L["MT_trash_spellbreaker_desc2"]      = "• %s — Tire une ligne vers le tank ; l'orienter loin du groupe et se décaler soi-même pour l'esquiver."
L["MT_trash_spellbreaker_note"]       = "Après avoir vaincu Seranel Sunlash, monter sur la plateforme derrière son arène et canaliser sur le |cffAA88FFCynosure of Twilight|r pour faire apparaître une vague de mobs du vide à traverser."
-- Descriptions trash — Voidling
L["MT_trash_voidling_desc1"]          = "• Le tank doit savoir que ces mobs infligent des dégâts d'ombre supplémentaires en mêlée grâce au passif %s."
-- Descriptions trash — Hollowsoul Shredder
L["MT_trash_shredder_desc1"]          = "• %s — Cible un joueur aléatoire ; rester proche du groupe pour cleaver facilement ces mobs."
-- Descriptions trash — Dreaded Voidwalker
L["MT_trash_voidwalker_desc1"]        = "• %s — Cible un joueur aléatoire ; utiliser les interrupts disponibles."
-- Descriptions trash — Shadowrift Voidcaller
L["MT_trash_voidcaller_desc1"]        = "• Le tank doit récupérer les mobs créés par %s."
L["MT_trash_voidcaller_desc2"]        = "• %s — Inflige de lourds dégâts de groupe ; être prêt avec des cooldowns de heal ou défensifs, et si nécessaire passer en Line of Sight pour éviter les dégâts entièrement."
-- Descriptions trash — Unstable Voidling
L["MT_trash_unstable_desc1"]          = "• Échelonner les kills pour ne pas être submergé par leur cast à la mort %s."
-- Descriptions trash — Void Infuser
L["MT_trash_void_infuser_desc1"]      = "• Interrompre |cffFF4444absolument|r chaque cast de %s."
L["MT_trash_void_infuser_desc2"]      = "• %s — Debuff sur un joueur aléatoire ; les healers doivent dispel les cibles rapidement ou utiliser défensifs et cooldowns si trop de cibles sont debuffées simultanément."
-- Descriptions trash — Devouring Tyrant
L["MT_trash_tyrant_desc1"]            = "• %s — Cible le tank ; être prêt avec un défensif et toute auto-heal disponible pour aider le healer à retirer le massive absorb de soins qu'il applique."
L["MT_trash_tyrant_desc2"]            = "• %s — Cible un joueur aléatoire ; éviter de cleave les alliés et utiliser toute auto-heal disponible pour aider le healer à retirer l'absorb de soins qu'il applique."
-- Boss 1 : Arcanotron Custos
L["MT_boss1_desc1"]                   = "• %s — Hit AoE + knockback qui dépose une flaque sous le boss pendant 2 minutes. Tenter de les placer sur les bords de la salle ou en superposition avec les flaques existantes pour conserver de l'espace."
L["MT_boss1_desc2"]                   = "• %s — Cible 2 joueurs aléatoires ; utiliser un dispel de magie ou un effet de liberté pour le retirer, sinon utiliser un défensif si l'effet se cumule avec %s."
L["MT_boss1_desc3"]                   = "• Le tank doit avoir un défensif prêt pour le hit arcanique et le knockback de %s ; utiliser le terrain de la salle pour limiter le knockback si nécessaire."
L["MT_boss1_desc4"]                   = "• À 0 énergie, le boss lance %s : utiliser les cooldowns de dégâts ici et se disperser légèrement pour absorber les %s entrants. Attention : les sphères déposent des flaques supplémentaires et appliquent le DoT %s — utiliser un défensif si nécessaire."
-- Boss 2 : Seranel Sunlash
L["MT_boss2_desc1"]                   = "• Le boss dépose une %s sous lui-même ; essayer de la placer près du centre de l'arène pour faciliter la gestion du debuff %s tout en restant espacé pour éviter de se cleaver mutuellement."
L["MT_boss2_desc2"]                   = "• Lors de la purge de %s, les 2 cibles doivent laisser un espace entre elles pour éviter de combo le groupe avec plusieurs hits de %s. Le 2ème joueur à purger son debuff peut avoir besoin d'un défensif."
L["MT_boss2_desc3"]                   = "• Si une purge est disponible, l'utiliser pour retirer le buff %s ; sinon, le tank doit utiliser un défensif quand il est actif."
L["MT_boss2_desc4"]                   = "• Lors du cast de %s, entrer dans la %s juste avant la fin du cast pour éviter le pacify de 8 secondes qu'il applique."
-- Boss 3 : Gemellus
L["MT_boss3_desc1"]                   = "• %s — Casté au début du combat et à 50%% de vie. Cleaver les clones autant que possible car ils partagent les PV. Chaque clone concentre ses capacités sur un joueur différent — en dessous de 50%%, tous les joueurs (y compris le tank) sont ciblés."
L["MT_boss3_desc2"]                   = "• %s — Dépose une flaque sous la cible ; les placer en dehors des zones de passage."
L["MT_boss3_desc3"]                   = "• %s — Debuff sur un joueur : courir vers le clone indiqué par la flèche sous ses pieds et le toucher pour retirer son debuff et le bouclier sur le boss."
L["MT_boss3_desc4"]                   = "• %s — Si ciblé, s'éloigner du pull-in et éviter simultanément les cercles qui apparaissent autour de tous les clones."
-- Boss 4 : Degentrius
L["MT_boss4_desc1"]                   = "• Éviter le rayon %s qui coupe l'arène en deux, et répartir le groupe des deux côtés du rayon pour absorber les %s."
L["MT_boss4_desc2"]                   = "• Le tank doit éviter de cleave les alliés avec %s, puis reculer et se faire dispel par le healer pour retirer le DoT magique et déposer la flaque hors de la mêlée. Le boss ne mêle pas : il utilise %s sur le tank quelle que soit sa position."
L["MT_boss4_desc3"]                   = "• %s — Debuff plusieurs joueurs avec des durées différentes ; être prêt avec un défensif si la durée est longue, et orienter les orbes de façon à ce qu'ils soient visibles pour les autres joueurs."

-- Cavernes de Maisara (MC) — uiMapId 2501
L["MC_name"]              = "Cavernes de Maisara"
-- Intro
L["MC_intro_desc1"]       = "Cavernes de Maisara — Midnight Saison 1, nouveau donjon."
L["MC_intro_desc2"]       = "3 bosses : Muro'jin &amp; Nekraxx -> Vordaza -> Rak'tul (Vessel of Souls)."
-- Noms du trash
L["MC_trash_berserker_name"]   = "Berserk Frénétique & Chasseur de Têtes Acéré"
L["MC_trash_juggernaut_name"]  = "Colosse Massif"
L["MC_trash_hexxer_name"]      = "Ensorceleur Rituel"
L["MC_trash_guardian_name"]    = "Gardien Maléfique"
L["MC_trash_skirmisher_name"]  = "Tirailleur Sinistre"
L["MC_trash_soulrender_name"]  = "Déchireur d'Âmes Creux"
L["MC_trash_defender_name"]    = "Défenseur Enchaîné"
-- Descriptions trash
L["MC_trash_berserker_desc1"]  = "%s : buff de frénésie — à calmer (Soothe ou équivalent). %s : soin passif — utilisez des effets de réduction de soins."
L["MC_trash_berserker_desc2"]  = "%s (Keen Headhunter) : interrompre ou utiliser un effet de liberté sur la cible. %s : se regrouper en mêlée pour éviter les dégâts sur les cibles éloignées."
L["MC_trash_juggernaut_desc1"] = "%s : interrompre. Si le cast passe, tout le groupe doit arrêter de caster immédiatement. %s : saignement sur le tank — défensif ou purge."
L["MC_trash_hexxer_desc1"]     = "%s : interrompre chaque cast sans exception. Si le hex passe, le dispel est prioritaire. %s : utiliser les interruptions restantes."
L["MC_trash_guardian_desc1"]   = "%s : pulsations AoE permanentes — cooldowns offensifs et défensifs sur ce mob. %s : debuff magique sur deux joueurs avec cercles — dispel et esquiver. %s : ligne d'attaque vers un joueur aléatoire — se positionner pour ne pas couper les alliés."
L["MC_trash_skirmisher_desc1"] = "%s : bouclier magique — purger en alternance pour le briser efficacement."
L["MC_trash_soulrender_desc1"] = "%s : canal qui fait exploser les Lost Souls à proximité — interrompre impérativement. %s : interrompre. %s : gel sur un joueur aléatoire — dispel ou immunité."
L["MC_trash_defender_desc1"]   = "%s : dégâts AoE ombre sur chaque frappe. %s : mécaniques tournantes autour du mob — se déplacer pour éviter. %s : le tank doit positionner le mob pour éviter de renvoyer les dégâts sur le groupe."
-- Boss 1 : Muro'jin & Nekraxx
L["MC_boss1_name"]             = "Muro'jin & Nekraxx"
L["MC_boss1_desc1"]            = "Priorité : tuer Nekraxx en premier. Si Muro'jin meurt avant elle, elle gagne des buffs massifs via %s. Si Nekraxx meurt, Muro'jin tentera de la ressusciter via %s — interrompre absolument."
L["MC_boss1_desc2"]            = "%s : Nekraxx s'élance en vol vers une cible. Des %s au sol la bloquent si elle vole dedans — positionnez-les sur son trajet."
L["MC_boss1_desc3"]            = "%s : tank buster avec saignement — utilisez un défensif ou faites purger le saignement."
L["MC_boss1_desc4"]            = "%s : maladie de groupe — à dispel rapidement pour réduire les dégâts encaissés par l'équipe."
L["MC_boss1_desc5"]            = "%s : cercles au sol à esquiver."
L["MC_boss1_desc6"]            = "%s : canal frontal avec ralentissement magique — restez immobile, les alliés ralentis doivent sortir du cône."
-- Boss 2 : Vordaza
L["MC_boss2_name"]             = "Vordaza"
L["MC_boss2_desc1"]            = "%s : des spectres sont invoqués et se déplacent vers les joueurs. Ils explosent au contact — esquivez leur trajectoire."
L["MC_boss2_desc2"]            = "%s : canal ciblant le tank — utilisez un défensif puissant."
L["MC_boss2_desc3"]            = "%s : balayage frontal — replacez-vous derrière le boss."
L["MC_boss2_desc4"]            = "%s : canal protégé par un bouclier — briser le bouclier puis interrompre le cast."
-- Boss 3 : Rak'tul, Vessel of Souls
L["MC_boss3_name"]             = "Rak'tul, Vessel of Souls"
L["MC_boss3_desc1"]            = "%s : aura passive créant des cercles autour du boss — restez en mouvement."
L["MC_boss3_desc2"]            = "%s : combo d'attaques posant des flaques au sol — utilisez défensifs et mobilité."
L["MC_boss3_desc3"]            = "%s : cible trois joueurs simultanément et invoque un %s par cible — détruisez les totems rapidement pour briser le lien."
L["MC_boss3_desc4"]            = "%s : envoie les joueurs sur le pont pour une phase de gauntlet. Interrompez et contrôlez les Malignant Souls pour obtenir %s et réduire %s — les dégâts augmentent progressivement si vous tardez."
L["MC_boss3_desc5"]            = "%s : sur le pont, les Lost Souls enracinent les joueurs — utilisez des effets de liberté ou brisez les liens rapidement."

-- Point-nexus Xenas (NPX) — uiMapId 2556
L["NPX_name"]             = "Point-nexus Xenas"
-- Intro
L["NPX_intro_desc1"]      = "Point-nexus Xenas — Midnight Saison 1, nouveau donjon."
L["NPX_intro_desc2"]      = "3 bosses : Chef Constructeur de Noyau Kasreth -> Gardien du Noyau Nysarra -> Lothraxion."
-- Noms du trash
L["NPX_trash_arcanist_name"]   = "Arcaniste Constructeur de Noyau"
L["NPX_trash_engineer_name"]   = "Ingénieur de Flux"
L["NPX_trash_seer_name"]       = "Voyant de Circuit"
L["NPX_trash_scrounger_name"]  = "Chapardeur Âme-creuse"
L["NPX_trash_nullifier_name"]  = "Grand Annulateur"
L["NPX_trash_dreadflail_name"] = "Dreadflail"
L["NPX_trash_lightwrought_name"] = "Forgé-de-Lumière"
L["NPX_trash_voidcaller_name"] = "Invocateur du Vide Maudit"
-- Descriptions trash
L["NPX_trash_arcanist_desc1"]  = "%s : canal à interrompre. %s : debuff magique — à dispel rapidement."
L["NPX_trash_engineer_desc1"]  = "%s : s'écarter avant le cast pour éviter les alliés. À la mort, laisse une Mana Battery active au sol — éviter de l'activer accidentellement."
L["NPX_trash_seer_desc1"]      = "%s : canal avec dégâts importants — cooldowns défensifs. %s : active les Mana Batteries proches — tuer ce mob loin des batteries ou les détruire avant."
L["NPX_trash_scrounger_desc1"] = "%s : canal de soin déclenché à 45%% de vie — interruptible et CC-able."
L["NPX_trash_nullifier_desc1"] = "%s : interrompre. %s : zone de peur à esquiver. Se transforme en Smudge à la mort."
L["NPX_trash_dreadflail_desc1"] = "%s : tank buster — défensif. %s : AoE de zone — kiter le mob ou utiliser les cooldowns de groupe."
L["NPX_trash_lightwrought_desc1"] = "%s : sort interruptible ciblant un joueur aléatoire. %s : debuff magique sur 2 joueurs — à dispel."
L["NPX_trash_voidcaller_desc1"] = "%s : canal appliquant des dégâts mortels — dispeler les malédictions immédiatement."
-- Boss 1 : Chief Corewright Kasreth
L["NPX_boss1_name"]            = "Chef Constructeur de Noyau Kasreth"
L["NPX_boss1_desc1"]           = "%s : des faisceaux d'énergie traversent la salle. Les joueurs affectés par %s peuvent se placer aux intersections des faisceaux pour les désactiver."
L["NPX_boss1_desc2"]           = "%s : crée des flaques — attirer vers les bords de la salle pour dégager le centre."
L["NPX_boss1_desc3"]           = "%s : applique une absorption de soins et un knockback — anticipez le déplacement."
L["NPX_boss1_desc4"]           = "%s : dégâts arcaniques instantanés remplaçant les frappes normales du boss."
-- Boss 2 : Corewarden Nysarra
L["NPX_boss2_name"]            = "Gardien du Noyau Nysarra"
L["NPX_boss2_desc1"]           = "%s : cible deux joueurs — utilisez un défensif et positionnez-vous pour ne pas couper les alliés."
L["NPX_boss2_desc2"]           = "%s : invoque un Dreadflail et 2 Grand Nullifiers. Tuer les adds avant la fin du canal — si le canal se termine avec des adds vivants, %s les consume et renforce le boss."
L["NPX_boss2_desc3"]           = "%s : canal ciblant le tank — utilisez un défensif puissant."
L["NPX_boss2_desc4"]           = "%s : une image crée un frontal avec 300%% d'amplification de dégâts — ne jamais rester dans le cône."
-- Boss 3 : Lothraxion
L["NPX_boss3_name"]            = "Lothraxion"
L["NPX_boss3_desc1"]           = "%s : laisse des flaques persistantes au sol — les déposer sur les bords de la salle."
L["NPX_boss3_desc2"]           = "%s : cible 3 joueurs — écartez-vous des alliés pour éviter les dégâts de débordement."
L["NPX_boss3_desc3"]           = "%s : dash touchant les joueurs sur son trajet — se déplacer latéralement."
L["NPX_boss3_desc4"]           = "%s : le boss se dissimule parmi des images. %s : les images frappent ceux à moins de 5 yards. Identifiez et interrompez la vraie cible pour déclencher %s."

-- Flèche de Coursevent (WRS) — uiMapId 2492+
L["WRS_name"]             = "Flèche de Coursevent"
-- Intro
L["WRS_intro_desc1"]      = "Flèche de Coursevent — Midnight Saison 1, nouveau donjon."
L["WRS_intro_desc2"]      = "4 bosses : Emberdawn -> Duo Délabré (Kalis &amp; Latch) -> Commandant Kroluk -> Le Cœur sans repos."
-- Noms du trash
L["WRS_trash_magus_name"]       = "Magus de la Garde des Sorts"
L["WRS_trash_steward_name"]     = "Intendant Agité"
L["WRS_trash_woebringer_name"]  = "Porteur de Malheur Dévoué"
L["WRS_trash_behemoth_name"]    = "Béhémoth de Chair"
L["WRS_trash_mystic_name"]      = "Mystique Fantomatique"
-- Descriptions trash
L["WRS_trash_magus_desc1"]      = "%s : dégâts de groupe — cooldowns défensifs. %s : à 50%% de vie, crée une zone de réduction de dégâts à 99%% — ne jamais rester dans cette zone, tuer le mob rapidement."
L["WRS_trash_steward_desc1"]    = "%s : interrompre. %s : debuff magique — dispel."
L["WRS_trash_woebringer_desc1"] = "%s : interrompre. %s : cast protégé par un bouclier — briser le bouclier ou interrompre."
L["WRS_trash_behemoth_desc1"]   = "%s : se disperser pour éviter les dégâts de débordement. %s : tank buster — défensif."
L["WRS_trash_mystic_desc1"]     = "%s : interrompre. %s : enrage à 50%% de vie — soothe immédiat."
-- Boss 1 : Emberdawn
L["WRS_boss1_name"]             = "Emberdawn"
L["WRS_boss1_desc1"]            = "%s : debuff sur 2 joueurs — se diriger vers les bords de l'arène pour y déposer la flaque avant qu'elle explose."
L["WRS_boss1_desc2"]            = "%s : intermission avec dégâts massifs et frontales de feu — cooldowns de groupe et se déplacer hors des cônes. %s : tank buster avec DoT — défensif à chaque cast."
-- Boss 2 : Duo Délabré (Kalis & Latch)
L["WRS_boss2_name"]             = "Duo Délabré (Kalis & Latch)"
L["WRS_boss2_desc1"]            = "%s : cast de Kalis — rotation d'interruptions permanente. %s : malédiction — dispel immédiat."
L["WRS_boss2_desc2"]            = "%s + %s : les deux bosses combinent leurs effets simultanément — défensifs et mobilité. %s : se disperser pour éviter les dégâts de débordement."
L["WRS_boss2_desc3"]            = "%s : canal ciblant le tank — défensif puissant."
-- Boss 3 : Commander Kroluk
L["WRS_boss3_name"]             = "Commandant Kroluk"
L["WRS_boss3_desc1"]            = "%s : caste en rafale, cible toujours le joueur le plus éloigné — rester groupé près du tank sauf la cible désignée qui s'éloigne. %s : mécanique de proximité — s'éloigner du boss."
L["WRS_boss3_desc2"]            = "%s : invoque des adds à 66%% et 33%% — cooldowns de groupe. %s : fixate sur un joueur — kiter en cercle. %s : canal tank — défensif."
-- Boss 4 : The Restless Heart
L["WRS_boss4_name"]             = "Le Cœur sans repos"
L["WRS_boss4_desc1"]            = "%s : debuff stackant — se placer sur les flèches au sol pour l'effacer avant %s. %s : invoque des %s — esquiver les flèches en mouvement."
L["WRS_boss4_desc2"]            = "%s : spread — efface également les flaques au sol, utiliser à bon escient. %s : frontal vers un joueur aléatoire — la cible reste immobile pour faciliter l'esquive des autres. %s : tank buster avec knockback — défensif."

-- Murder Row (MR)
L["MR_name"]              = "Allée du meurtre"

-- Voidscar Arena (VA)
L["VA_name"]              = "Arène de la Cicatrice du Vide"
