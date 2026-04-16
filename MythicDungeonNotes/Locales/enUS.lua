local myname, ns = ...

local L = LibStub("AceLocale-3.0"):NewLocale(myname, "enUS", true)

-- Guide UI strings
L["GUIDE_back_btn"]       = "Back to List"
L["GUIDE_coming_soon"]    = "(Coming soon)"
L["GUIDE_wip"]            = "The guide for this dungeon is being written."
L["GUIDE_s1_header"]      = "Midnight Dungeons — Season 1"
L["GUIDE_other_dungeons"] = "Other Dungeons"
L["GUIDE_tooltip_click"]  = "Left-click: open / close"
L["GUIDE_tooltip_drag"]   = "Drag: move the button"
L["GUIDE_vignette_tooltip"] = "Open dungeon guide"
L["GUIDE_portal_tooltip"]   = "Teleport to this dungeon"

-- Common section labels
L["COMMON_intro_label"]     = "Introduction"
L["COMMON_notable_trash"]   = "Notable Trash"
L["COMMON_cc_immune"]       = "• Immune to CC"

-------------------------------------------------------------------------------
-- Midnight — Legacy Dungeons (S1)
-------------------------------------------------------------------------------

-- Algeth'ar Academy (AA) — uiMapId 2097
L["AA_name"]              = "Algeth'ar Academy"
L["AA_entrance_label"]    = "Entrance"
L["AA_entrance_desc"]     = "Each teacher grants a buff depending on their dragonflight."
L["AA_bronze_drake_desc"] = "Bronze Dragonflight Recruiter"
L["AA_bronze_drake"]      = "5% Haste"
L["AA_red_drake_desc"]    = "Red Dragonflight Recruiter"
L["AA_red_drake"]         = "5% Versatility"
L["AA_green_drake_desc"]  = "Green Dragonflight Recruiter"
L["AA_green_drake"]       = "10% Healing taken"
L["AA_blue_drake_desc"]   = "Blue Dragonflight Recruiter"
L["AA_blue_drake"]        = "Mastery (584 rating)"
L["AA_black_drake_desc"]  = "Black Dragonflight Recruiter"
L["AA_black_drake"]       = "5% Critical Strike"

-- Section names
L["AA_boss1"]             = "First boss: Overgrown Ancient"
L["AA_boss2"]             = "Second boss: Crawth"
L["AA_boss3"]             = "Third boss: Vexamus"
L["AA_boss4"]             = "Fourth boss: Echo of Doragosa"
L["AA_trash_label"]       = "Trash"

-- Mob names
L["AA_boss1_name"]        = "Overgrown Ancient"
L["AA_boss1_branch_name"] = "Ancient Branch"
L["AA_boss2_name"]        = "Crawth"
L["AA_boss3_name"]        = "Vexamus"
L["AA_boss4_name"]        = "Echo of Doragosa"
L["AA_trash1_mob1_name"]  = "Vile Lasher"
L["AA_trash1_mob2_name"]  = "Aggravated Skitterfly"
L["AA_trash2_mob1_name"]  = "Guardian Sentry"
L["AA_trash2_mob2_name"]  = "Alpha Eagle"
L["AA_trash3_mob1_name"]  = "Corrupted Manafiend"
L["AA_trash3_mob2_name"]  = "Spellbound Battleaxe"
L["AA_trash3_mob3_name"]  = "Arcane Ravager"
L["AA_trash3_mob4_name"]  = "Arcane Forager"
L["AA_trash3_mob5_name"]  = "Unruly Textbook"
L["AA_trash4_mob1_name"]  = "Algeth'ar Echoknight"
L["AA_trash4_mob2_name"]  = "Spectral Invoker"

-- Descriptions — Trash 1
L["AA_trash1_mob1_desc1"] = "• %s — Targets the tank; watch stacks and use defensives or purge the bleed if needed."
L["AA_trash1_mob1_desc2"] = "• %s — Spawns a whirlwind under each player, dodge it."
L["AA_trash1_mob2_desc1"] = "Stay grouped to cleave these mobs efficiently."
L["AA_trash1_mob2_desc2"] = "Try to Pacify them if possible."
L["AA_trash1_mob2_desc3"] = "• The tank must watch %s stacks."
L["AA_trash1_mob2_desc4"] = "• %s — Targets a random player."

-- Descriptions — Boss 1
L["AA_boss1_desc0"]       = "Stay as grouped as possible on the tank."
L["AA_boss1_desc1"]       = "Watch out for %s: slowly circle left, staying grouped."
L["AA_boss1_desc2"]       = "• At 100 energy, the boss casts %s and spawns an |cff44FF44Ancient Branch|r."
L["AA_boss1_desc3"]       = "• Always interrupt its healing spell %s."
L["AA_boss1_desc4"]       = "• On death, the |cff44FF44Ancient Branch|r leaves %s (green circle on the ground) that removes %s if you step inside."

-- Descriptions — Trash 2
L["AA_trash2_mob1_desc1"] = "• %s — Targets the tank, use a defensive."
L["AA_trash2_mob1_desc2"] = "• %s — Targets a random player and spawns a tornado to dodge."
L["AA_trash2_mob1_desc3"] = "• %s — Zonal AoE, run out or use Line of Sight."
L["AA_trash2_mob2_desc1"] = "• %s — Frontal aimed at a random target, dodge or you may fall."

-- Descriptions — Boss 2
L["AA_boss2_desc0"]       = "• The tank must have a defensive active on each hit of %s and for its DoT."
L["AA_boss2_desc0b"]      = "Note: this effect is not considered a bleed in Midnight."
L["AA_boss2_desc1"]       = "• Spread out and stop all casts during %s."
L["AA_boss2_desc2"]       = "• At 75% and 45%, throw all three balls in the same direction."

-- Descriptions — Trash 3
L["AA_trash3_mob1_desc1"] = "• %s — Targets a random player, interrupt it."
L["AA_trash3_mob1_desc2"] = "• %s — Targets a random player; don't stack, use a defensive if needed."
L["AA_trash3_mob2_desc1"] = "• The tank should note that these mobs deal passive bonus arcane damage via the %s buff."
L["AA_trash3_mob3_desc1"] = "• %s — Charges the furthest player; use a defensive and stay grouped to cleave easily."
L["AA_trash3_mob3_desc2"] = "• Immediately after the charge, a %s frontal is aimed at the tank: sidestep to avoid it."
L["AA_trash3_mob4_desc1"] = "• %s — Targets a random player; watch burst damage in packs with multiple of these mobs."
L["AA_trash3_mob5_desc1"] = "• %s — Channels on a random player; interrupt, or once started: CC or magic dispel."

-- Descriptions — Boss 3
L["AA_boss3_desc0"]       = "• %s — Frontal on the tank: orient away from the group and use a defensive."
L["AA_boss3_desc1"]       = "• Absorb one %s per wave; orbs must not reach the boss. Take one each."
L["AA_boss3_desc2"]       = "• %s places exactly 3 zones on the ground; move enough to avoid them but don't run all over."

-- Descriptions — Trash 4
L["AA_trash4_mob1_desc1"] = "• %s — AoE under a random player, dodge quickly."
L["AA_trash4_mob1_desc2"] = "• %s — Heavy raid hit; watch HP and use defensives if needed."
L["AA_trash4_mob2_desc1"] = "• %s — Debuff on a random player: high interrupt priority."
L["AA_trash4_mob2_desc2"] = "• %s — Targets a random player, use available interrupts."

-- Descriptions — Boss 4
L["AA_boss4_desc0"]       = "Tank the boss close to the wall, backing up progressively to avoid pools."
L["AA_boss4_desc1"]       = "On pull, the boss immediately casts %s."
L["AA_boss4_desc2"]       = "• Each ability hit gives a stack of %s. At 3 stacks, a %s appears under the player's feet — place them along the wall."
L["AA_boss4_desc3"]       = "• %s periodically fire %s orbs to dodge."
L["AA_boss4_desc4"]       = "• %s — Targets a random player: stay slightly spread, use a defensive (beware of %s — potentially lethal combo)."
L["AA_boss4_desc5"]       = "• %s — Pulls all players toward the boss: Run!"

-- The Seat of the Triumvirate (SOT) — uiMapId 903
L["SOT_name"]             = "Seat of the Triumvirate"
-- Intro
L["SOT_intro_desc1"]      = "Seat of the Triumvirate — Legion Heritage, Mac'Aree (Argus)."
L["SOT_intro_desc2"]      = "4 bosses: Zuraal the Ascended -> Saprish -> Viceroy Nezhar -> L'ura."
-- Notable Trash
L["SOT_trash1_name"]      = "Merciless Subjugator"
L["SOT_trash1_desc1"]     = "%s: targets all players — spread slightly to avoid splash damage. %s: absorption on a random target — prioritize healing."
L["SOT_trash2_name"]      = "Dark Conjuror"
L["SOT_trash2_desc1"]     = "%s: interrupt every cast without exception. %s: secondary interrupt target."
L["SOT_trash3_name"]      = "Rift Warden"
L["SOT_trash3_desc1"]     = "%s: stay within 30 yards at all times — otherwise a lethal explosion. %s: magic debuff on random players — dispel. %s: massive group damage with circles to dodge."
L["SOT_trash4_name"]      = "Shadowguard Champion"
L["SOT_trash4_desc1"]     = "%s: gains dangerous stacks if nobody is in melee — maintain contact. %s: enrage — Soothe or tank defensives."
L["SOT_trash5_name"]      = "Dire Voidbender"
L["SOT_trash5_desc1"]     = "%s: powerful buff — interrupt or purge immediately."
-- Boss 1: Zuraal the Ascended
L["SOT_boss1_name"]       = "Zuraal the Ascended"
L["SOT_boss1_desc1"]      = "%s: applies a DoT and summons 2 Coalesced Void that explode on boss contact. %s: accelerates them and pulls players — move away immediately and kill adds before they reach the boss."
L["SOT_boss1_desc2"]      = "%s: leaps on a random player creating a pool — move away. %s: tank buster — defensive. %s: frontal on a random target — dodge."
-- Boss 2: Saprish
L["SOT_boss2_name"]       = "Saprish"
L["SOT_boss2_desc1"]      = "%s: massive group damage with DoT — be at full health before the cast. %s: dash creating circles to detonate %s bombs — dodge residual bombs."
L["SOT_boss2_desc2"]      = "%s: Darkfang ability requiring 2 interrupts — often overlaps with Phase Dash. %s: damage on a random Darkfang target."
-- Boss 3: Viceroy Nezhar
L["SOT_boss3_name"]       = "Viceroy Nezhar"
L["SOT_boss3_desc1"]      = "%s: summons 3 gates generating %s — stay mobile and anticipate trajectories. %s: move toward the boss during the channel to reduce group damage."
L["SOT_boss3_desc2"]      = "%s: summons 5 adds channeling Mind Flay — kill quickly with cleave. %s: targeting the tank — maintain an interrupt rotation. %s: targets 3 players — defensives."
-- Boss 4: L'ura
L["SOT_boss4_name"]       = "L'ura"
L["SOT_boss4_desc1"]      = "%s: group strike summoning 6 Notes. %s: each active note applies a stack every 2s — use %s to silence them upon appearance via %s."
L["SOT_boss4_desc2"]      = "%s: repositions notes and applies Anguish stacks — silence notes first. %s: rotating beams — keep moving."
L["SOT_boss4_desc3"]      = "%s: stacking debuff on the tank — at 3 stacks triggers a powerful shadow strike; use a defensive or rotate the boss. %s: boss debuff during intermission — save cooldowns for this phase."

-- Skyreach (SKY) — uiMapId 601/602
L["SKY_name"]             = "Skyreach"
-- Intro
L["SKY_intro_desc1"]      = "Skyreach — Warlords of Draenor Heritage, Arakkoa structure."
L["SKY_intro_desc2"]      = "4 bosses: Ranjit -> Araknath -> Rukhran -> High Sage Viryx."
-- Notable Trash
L["SKY_trash1_name"]      = "Soaring Chakram Master"
L["SKY_trash1_desc1"]     = "%s: chakram bouncing between nearby players — spread away from allies to limit bounces."
L["SKY_trash2_name"]      = "Blinding Sun Priestess"
L["SKY_trash2_desc1"]     = "%s: interrupt without exception. %s: self-buff — purge immediately."
L["SKY_trash3_name"]      = "Adorned Bladetalon"
L["SKY_trash3_desc1"]     = "%s: charge targeting the tank and 2 random players. %s: tank buster — defensive."
L["SKY_trash4_name"]      = "Driving Gale-Caller"
L["SKY_trash4_desc1"]     = "%s: interrupt to prevent the group knockback."
L["SKY_trash5_name"]      = "Solar Elemental"
L["SKY_trash5_desc1"]     = "%s: summons Solar Orbs — kill priority to avoid %s (fire circles)."
L["SKY_trash6_name"]      = "Dread Raven"
L["SKY_trash6_desc1"]     = "%s: AoE knockback — position against a wall. %s: high damage — defensives."
-- Boss 1: Ranjit
L["SKY_boss1_name"]       = "Ranjit"
L["SKY_boss1_desc1"]      = "%s: creates wind orbs with knockback — drop orbs outside the group's movement path. %s: summons tornadoes — stay mobile."
L["SKY_boss1_desc2"]      = "%s: applies a bleed to the entire group — healing cooldowns. %s: projectile toward a random player that returns to the boss — move laterally to avoid it."
-- Boss 2: Araknath
L["SKY_boss2_name"]       = "Araknath"
L["SKY_boss2_desc1"]      = "%s: Lesser Constructs send beams toward the boss in groups of 3 — kill them before they reach it, otherwise %s deals massive group damage."
L["SKY_boss2_desc2"]      = "%s: avoidable if the tank stays in permanent melee. %s: 5-yard AoE under the boss — never stand there. %s: line attack — tank position perpendicular to the group."
-- Boss 3: Rukhran
L["SKY_boss3_name"]       = "Rukhran"
L["SKY_boss3_desc1"]      = "%s: summons Sunwings — swap kill priority to adds. %s: fixates on a player with pulses — that player moves away from the group."
L["SKY_boss3_desc2"]      = "%s: hide behind the central pillar to block projectiles. %s: tank buster — defensive every cast. %s: cast if the tank leaves melee — stay in melee."
-- Boss 4: High Sage Viryx
L["SKY_boss4_name"]       = "High Sage Viryx"
L["SKY_boss4_desc1"]      = "%s: maintain an interrupt rotation. %s: targets 3 players — spread to reduce splash damage."
L["SKY_boss4_desc2"]      = "%s: pulls a random player off the platform — return immediately via the side path. %s: pursuing beam leaving a fire trail — run in a circle to avoid blocking the area."

-- Pit of Saron (POS) — uiMapId 184
L["POS_name"]             = "Pit of Saron"
-- Intro
L["POS_intro_desc1"]      = "Pit of Saron — Wrath of the Lich King Heritage, Icecrown."
L["POS_intro_desc2"]      = "3 bosses: Forgemaster Garfrost -> Ick &amp; Krick -> Scourgelord Tyrannus."
L["POS_intro_desc3"]      = "A Frostsworn Generals gauntlet precedes the third boss."
-- Notable Trash
L["POS_trash1_name"]      = "Dreadpulse Lich"
L["POS_trash1_desc1"]     = "%s: cast targeting the tank — interrupt, very high damage. %s: triggered at 50%% health, pulses every 2s — group cooldowns. %s: random target — defensive."
L["POS_trash2_name"]      = "Deathwhisper Necrolyte"
L["POS_trash2_desc1"]     = "%s: minions are immune while the Necrolyte is alive — focus the caster first. %s: buff on a random minion — purge."
L["POS_trash3_name"]      = "Arcanist Cadaver"
L["POS_trash3_desc1"]     = "%s: large AoE to interrupt — high priority."
L["POS_trash4_name"]      = "Lumbering Plaguehorror"
L["POS_trash4_desc1"]     = "%s: enrage — Soothe. %s: creates intermittent pools — keep the combat area clear."
L["POS_trash5_name"]      = "Rimebone Coldwraith"
L["POS_trash5_desc1"]     = "%s: interruptible cast. %s: debuff on 2 players — dispel or use a freedom effect."
L["POS_trash6_name"]      = "Glacieth (mini-boss)"
L["POS_trash6_desc1"]     = "%s: AoE on the entire group — spread and kite. %s: directional shield — position behind the mob to guarantee critical hits."
L["POS_trash7_name"]      = "Quarry Tormentor & Wrathbone Enforcer"
L["POS_trash7_desc1"]     = "%s: curse on a random target — dispel. %s: stacking debuff on the tank — monitor the counter."
-- Boss 1: Forgemaster Garfrost
L["POS_boss1_name"]       = "Forgemaster Garfrost"
L["POS_boss1_desc1"]      = "%s: creates dangerous ground pools by targeting 2 players — move away and destroy ore chunks to clear the area."
L["POS_boss1_desc2"]      = "%s: the tank must break nearby ore chunks to avoid the stun."
L["POS_boss1_desc3"]      = "%s: the boss channels toward the nearest furnace — take cover behind a remaining ore chunk to reduce damage."
L["POS_boss1_desc4"]      = "%s: destroys an ore chunk and applies a magic debuff to 2 players. %s: the boss's passive damage increases with active magic debuffs — dispel quickly."
-- Boss 2: Ick & Krick
L["POS_boss2_name"]       = "Ick & Krick"
L["POS_boss2_desc1"]      = "%s: both bosses share a health pool — focusing one is sufficient."
L["POS_boss2_desc2"]      = "%s: summons 2 shadows carrying %s, a curse on random targets — dispel immediately."
L["POS_boss2_desc3"]      = "%s: interruptible Krick cast — keep an interrupt available. %s: tank strike creating a pool — move the boss off the pool."
L["POS_boss2_desc4"]      = "%s: creates pools under 4 random players — spread out. %s: fixates on a random player for 7s — that player moves away; the group helps manage Ick."
-- Boss 3: Scourgelord Tyrannus
L["POS_boss3_name"]       = "Scourgelord Tyrannus"
L["POS_boss3_desc1"]      = "%s: knockback on the tank followed by a leaping attack — defensive and anticipate movement. %s and %s: ground circles and channels — keep moving."
L["POS_boss3_desc2"]      = "%s: activates %s bone piles that spawn Rotlings and Plaguespreaders. %s: Rotlings apply disease stacks on the tank — defensives. %s: interruptible Plaguespreader cast — interrupt priority. %s: target nearby bone piles to mitigate damage."

-------------------------------------------------------------------------------
-- Midnight — New Dungeons (S1)
-------------------------------------------------------------------------------

-- The Blinding Vale (BV) — uiMapId 2500
L["BV_name"]              = "The Blinding Vale"

-- Den of Nalorakk (DN) — uiMapId 2513
L["DN_name"]              = "Den of Nalorakk"
L["DN_intro_label"]       = "Introduction"
L["DN_intro_desc"]        = "Den of Nalorakk — New dungeon, Midnight Season 1."
L["DN_incense_label"]     = "Warding Incense"
L["DN_incense_desc"]      = "A Warding Incense brazier is located near the dungeon entrance."
L["DN_buff_alchemy_desc"] = "Midnight Alchemists (skill 25) and Bear Form Druids can burn incense: +1% Versatility for 10 minutes for the whole party."

-- Magisters' Terrace (MT) — uiMapId 2520
L["MT_name"]              = "Magisters' Terrace"
L["MT_intro_label"]       = "Introduction"
L["MT_intro_desc1"]       = "Magisters' Terrace — New dungeon, Midnight Season 1."
L["MT_intro_desc2"]       = "4 bosses: Arcanotron Custos -> Seranel Sunlash -> Gemellus -> Degentrius."
L["MT_library_note"]      = "After defeating the first enemy in the library, a book appears on the lectern — click it to grant the group +5%% Haste for 30 minutes."
L["MT_trash_label"]       = "Notable Trash"
-- Boss names (used as section titles)
L["MT_boss1"]             = "Arcanotron Custos"
L["MT_boss2"]             = "Seranel Sunlash"
L["MT_boss3"]             = "Gemellus"
L["MT_boss4"]             = "Degentrius"
-- Notable Trash mob names
L["MT_trash_arcane_sentry_name"]      = "Arcane Sentry"
L["MT_trash_arcane_magister_name"]    = "Arcane Magister"
L["MT_trash_sunblade_name"]           = "Sunblade Enforcer"
L["MT_trash_lightward_name"]          = "Lightward Healer"
L["MT_trash_codex_name"]              = "Animated Codex"
L["MT_trash_pyromancer_name"]         = "Blazing Pyromancer"
L["MT_trash_familiar_name"]           = "Spellwoven Familiar"
L["MT_trash_wyrm_name"]               = "Brightscale Wyrm"
L["MT_trash_spellbreaker_name"]       = "Runed Spellbreaker"
L["MT_trash_voidling_name"]           = "Voidling"
L["MT_trash_shredder_name"]           = "Hollowsoul Shredder"
L["MT_trash_voidwalker_name"]         = "Dreaded Voidwalker"
L["MT_trash_voidcaller_name"]         = "Shadowrift Voidcaller"
L["MT_trash_unstable_name"]           = "Unstable Voidling"
L["MT_trash_void_infuser_name"]       = "Void Infuser"
L["MT_trash_tyrant_name"]             = "Devouring Tyrant"
-- Trash descriptions — Arcane Sentry
L["MT_trash_arcane_sentry_desc1"]     = "• %s — Targets the tank; use a root break or magic dispel to remove the effect."
L["MT_trash_arcane_sentry_desc2"]     = "• %s — Channel on a random player; avoid the pools it leaves on the ground."
L["MT_trash_arcane_sentry_desc3"]     = "• Monitor health and positioning during the AoE hit and knockback from %s."
-- Trash descriptions — Arcane Magister
L["MT_trash_arcane_magister_desc1"]   = "• %s — Random player target; high interrupt priority; if one goes through: magic dispel to remove it."
L["MT_trash_arcane_magister_desc2"]   = "• %s — Random player target; use available interrupts."
-- Trash descriptions — Sunblade Enforcer
L["MT_trash_sunblade_desc1"]          = "• The tank should monitor the magic buff %s and purge if possible; otherwise use a defensive to absorb the amplified strikes."
L["MT_trash_sunblade_desc2"]          = "• These mobs are difficult to kite as they use %s to close the gap."
-- Trash descriptions — Lightward Healer
L["MT_trash_lightward_desc1"]         = "• %s — Random player target; use a magic dispel to remove it."
L["MT_trash_lightward_desc2"]         = "• %s — Buffs a random ally; purge if possible."
-- Trash descriptions — Animated Codex
L["MT_trash_codex_desc1"]             = "• These mobs constantly pulse AoE damage via %s; don't pull too many at once and be ready with defensives or healing cooldowns."
-- Trash descriptions — Blazing Pyromancer
L["MT_trash_pyromancer_desc1"]        = "• |cffFF4444Interrupt|r every cast of %s without exception."
L["MT_trash_pyromancer_desc2"]        = "• Be ready with defensives or healing cooldowns when %s is active."
L["MT_trash_pyromancer_desc3"]        = "• Avoid the AoE hit and pool created by %s."
L["MT_trash_pyromancer_note"]         = "After the Pyromancer, the library door opens and the Librarians disappear. In the next courtyard, |cffFFD700Energy Crystals|r are scattered — interact with them to drain them and gain a temporary damage and healing bonus."
-- Trash descriptions — Spellwoven Familiar
L["MT_trash_familiar_desc1"]          = "• Beware the group AoE hit from %s, particularly dangerous when fighting other mobs that also deal AoE damage."
-- Trash descriptions — Brightscale Wyrm
L["MT_trash_wyrm_desc1"]              = "• Stagger the kills to avoid being overwhelmed by their death cast %s; stay close when they die to collect the stacking buff it applies."
-- Trash descriptions — Runed Spellbreaker
L["MT_trash_spellbreaker_desc1"]      = "• %s — Targets 2 random players; monitor HP if targeted and be ready to use defensives or health potions."
L["MT_trash_spellbreaker_desc2"]      = "• %s — Fires a line toward the tank; orient it away from the group and sidestep to dodge it."
L["MT_trash_spellbreaker_note"]       = "After defeating Seranel Sunlash, climb the platform behind her arena and channel on the |cffAA88FFCynosure of Twilight|r to summon a wave of void mobs to fight through."
-- Trash descriptions — Voidling
L["MT_trash_voidling_desc1"]          = "• The tank should know that these mobs deal additional shadow damage in melee through the passive %s."
-- Trash descriptions — Hollowsoul Shredder
L["MT_trash_shredder_desc1"]          = "• %s — Random player target; stay close to the group to cleave these mobs easily."
-- Trash descriptions — Dreaded Voidwalker
L["MT_trash_voidwalker_desc1"]        = "• %s — Random player target; use available interrupts."
-- Trash descriptions — Shadowrift Voidcaller
L["MT_trash_voidcaller_desc1"]        = "• The tank should pick up mobs created by %s."
L["MT_trash_voidcaller_desc2"]        = "• %s — Deals heavy group damage; be ready with healing cooldowns or defensives, and use Line of Sight if needed to avoid damage entirely."
-- Trash descriptions — Unstable Voidling
L["MT_trash_unstable_desc1"]          = "• Stagger the kills to avoid being overwhelmed by their death cast %s."
-- Trash descriptions — Void Infuser
L["MT_trash_void_infuser_desc1"]      = "• |cffFF4444Interrupt|r every cast of %s without exception."
L["MT_trash_void_infuser_desc2"]      = "• %s — Debuff on a random player; healers should dispel targets quickly or use defensives and cooldowns if too many targets are debuffed simultaneously."
-- Trash descriptions — Devouring Tyrant
L["MT_trash_tyrant_desc1"]            = "• %s — Targets the tank; be ready with a defensive and any self-healing available to help the healer overcome the massive healing absorption it applies."
L["MT_trash_tyrant_desc2"]            = "• %s — Random player target; avoid cleaving allies and use any self-healing available to help the healer overcome the healing absorption it applies."
-- Boss 1: Arcanotron Custos
L["MT_boss1_desc1"]                   = "• %s — AoE hit + knockback that drops a pool under the boss for 2 minutes. Try to place them on the room's edges or overlapping with existing pools to preserve space."
L["MT_boss1_desc2"]                   = "• %s — Targets 2 random players; use a magic dispel or freedom effect to remove it; otherwise use a defensive if it overlaps with %s."
L["MT_boss1_desc3"]                   = "• The tank must have a defensive ready for the arcane hit and knockback from %s; use the room's geometry to limit the knockback if needed."
L["MT_boss1_desc4"]                   = "• At 0 energy, the boss casts %s: use damage cooldowns here and spread slightly to soak incoming %s. Note: orbs drop additional pools and apply the DoT %s — use a defensive if needed."
-- Boss 2: Seranel Sunlash
L["MT_boss2_desc1"]                   = "• The boss drops a %s under itself; try to place it near the center of the arena to make managing the %s debuff easier, while staying spread to avoid cleaving each other."
L["MT_boss2_desc2"]                   = "• When %s is purged/expires, the 2 targets must leave space between them to avoid comboing the group with multiple %s hits. The 2nd player to clear their debuff may need a defensive."
L["MT_boss2_desc3"]                   = "• If a purge is available, use it to remove the buff %s; otherwise the tank must use a defensive while it is active."
L["MT_boss2_desc4"]                   = "• During %s's cast, step into %s just before the cast ends to avoid the 8-second pacify it applies."
-- Boss 3: Gemellus
L["MT_boss3_desc1"]                   = "• %s — Cast at the start of the fight and at 50%% health. Cleave clones as much as possible since they share HP. Each clone focuses its abilities on a different player — below 50%%, all players (including the tank) are targeted."
L["MT_boss3_desc2"]                   = "• %s — Drops a pool under the target; place them outside movement paths."
L["MT_boss3_desc3"]                   = "• %s — Debuff on a player: run toward the clone indicated by the arrow under their feet and touch it to remove the debuff and the boss's shield."
L["MT_boss3_desc4"]                   = "• %s — If targeted, move away from the pull-in and simultaneously avoid circles that appear around all clones."
-- Boss 4: Degentrius
L["MT_boss4_desc1"]                   = "• Avoid the %s beam that cuts the arena in two, and split the group on both sides of the beam to soak %s."
L["MT_boss4_desc2"]                   = "• The tank must avoid cleaving allies with %s, then back away and get dispelled by the healer to remove the magic DoT and place the pool away from melee. The boss does not melee: it uses %s on the tank regardless of position."
L["MT_boss4_desc3"]                   = "• %s — Debuffs multiple players with different durations; be ready with a defensive if the duration is long, and aim orbs so other players can see them."

-- Maisara Caverns (MC) — uiMapId 2501
L["MC_name"]              = "Maisara Caverns"
-- Intro
L["MC_intro_desc1"]       = "Maisara Caverns — Midnight Season 1, new dungeon."
L["MC_intro_desc2"]       = "3 bosses: Muro'jin &amp; Nekraxx -> Vordaza -> Rak'tul (Vessel of Souls)."
-- Notable Trash mob names
L["MC_trash_berserker_name"]   = "Frenzied Berserker & Keen Headhunter"
L["MC_trash_juggernaut_name"]  = "Hulking Juggernaut"
L["MC_trash_hexxer_name"]      = "Ritual Hexxer"
L["MC_trash_guardian_name"]    = "Hex Guardian"
L["MC_trash_skirmisher_name"]  = "Grim Skirmisher"
L["MC_trash_soulrender_name"]  = "Hollow Soulrender"
L["MC_trash_defender_name"]    = "Bound Defender"
-- Trash descriptions
L["MC_trash_berserker_desc1"]  = "%s: frenzy buff — Soothe or equivalent. %s: passive healing — use healing reduction effects."
L["MC_trash_berserker_desc2"]  = "%s (Keen Headhunter): interrupt or use a freedom effect on the target. %s: stack in melee to avoid damage on ranged targets."
L["MC_trash_juggernaut_desc1"] = "%s: interrupt. If the cast goes through, everyone must stop casting immediately. %s: bleed on the tank — defensive or purge."
L["MC_trash_hexxer_desc1"]     = "%s: interrupt every cast without exception. If the hex goes through, dispel is priority. %s: use remaining interrupts."
L["MC_trash_guardian_desc1"]   = "%s: permanent AoE pulses — offensive and defensive cooldowns on this mob. %s: magic debuff on two players with circles — dispel and dodge. %s: attack line toward a random player — position to avoid hitting allies."
L["MC_trash_skirmisher_desc1"] = "%s: magic shield — alternate purges to break it efficiently."
L["MC_trash_soulrender_desc1"] = "%s: channel that detonates nearby Lost Souls — must interrupt. %s: interrupt. %s: freeze on a random player — dispel or immunity."
L["MC_trash_defender_desc1"]   = "%s: shadow AoE damage on each strike. %s: rotating mechanics around the mob — move to avoid. %s: the tank must position the mob to avoid reflecting damage onto the group."
-- Boss 1: Muro'jin & Nekraxx
L["MC_boss1_name"]             = "Muro'jin & Nekraxx"
L["MC_boss1_desc1"]            = "Priority: kill Nekraxx first. If Muro'jin dies first, she gains massive buffs via %s. If Nekraxx dies, Muro'jin will attempt to resurrect her via %s — interrupt without fail."
L["MC_boss1_desc2"]            = "%s: Nekraxx dashes toward a target in flight. %s on the ground stop her if she flies through them — position them in her path."
L["MC_boss1_desc3"]            = "%s: tank buster with bleed — use a defensive or purge the bleed."
L["MC_boss1_desc4"]            = "%s: group disease — dispel quickly to reduce incoming damage."
L["MC_boss1_desc5"]            = "%s: ground circles to dodge."
L["MC_boss1_desc6"]            = "%s: frontal channel with magic slow — stand still; slowed allies must exit the cone."
-- Boss 2: Vordaza
L["MC_boss2_name"]             = "Vordaza"
L["MC_boss2_desc1"]            = "%s: spectres are summoned and move toward players. They explode on contact — dodge their path."
L["MC_boss2_desc2"]            = "%s: channel targeting the tank — use a strong defensive."
L["MC_boss2_desc3"]            = "%s: frontal sweep — reposition behind the boss."
L["MC_boss2_desc4"]            = "%s: channel protected by a shield — break the shield then interrupt the cast."
-- Boss 3: Rak'tul, Vessel of Souls
L["MC_boss3_name"]             = "Rak'tul, Vessel of Souls"
L["MC_boss3_desc1"]            = "%s: passive aura creating circles around the boss — keep moving."
L["MC_boss3_desc2"]            = "%s: attack combo dropping pools on the ground — use defensives and mobility."
L["MC_boss3_desc3"]            = "%s: targets three players simultaneously and summons a %s per target — destroy the totems quickly to break the link."
L["MC_boss3_desc4"]            = "%s: sends players to the bridge for a gauntlet phase. Interrupt and control Malignant Souls to gain %s and reduce %s — damage escalates progressively if you delay."
L["MC_boss3_desc5"]            = "%s: on the bridge, Lost Souls root players — use freedom effects or break the bonds quickly."

-- Nexus-Point Xenas (NPX) — uiMapId 2556
L["NPX_name"]             = "Nexus-Point Xenas"
-- Intro
L["NPX_intro_desc1"]      = "Nexus-Point Xenas — Midnight Season 1, new dungeon."
L["NPX_intro_desc2"]      = "3 bosses: Chief Corewright Kasreth -> Corewarden Nysarra -> Lothraxion."
-- Notable Trash mob names
L["NPX_trash_arcanist_name"]   = "Corewright Arcanist"
L["NPX_trash_engineer_name"]   = "Flux Engineer"
L["NPX_trash_seer_name"]       = "Circuit Seer"
L["NPX_trash_scrounger_name"]  = "Hollowsoul Scrounger"
L["NPX_trash_nullifier_name"]  = "Grand Nullifier"
L["NPX_trash_dreadflail_name"] = "Dreadflail"
L["NPX_trash_lightwrought_name"] = "Lightwrought"
L["NPX_trash_voidcaller_name"] = "Cursed Voidcaller"
-- Trash descriptions
L["NPX_trash_arcanist_desc1"]  = "%s: channel to interrupt. %s: magic debuff — dispel quickly."
L["NPX_trash_engineer_desc1"]  = "%s: move away before the cast to avoid hitting allies. On death, leaves an active Mana Battery on the ground — avoid activating it accidentally."
L["NPX_trash_seer_desc1"]      = "%s: channel with significant damage — defensive cooldowns. %s: activates nearby Mana Batteries — kill this mob away from batteries or destroy them first."
L["NPX_trash_scrounger_desc1"] = "%s: healing channel triggered at 45%% health — interruptible and CC-able."
L["NPX_trash_nullifier_desc1"] = "%s: interrupt. %s: fear zone to dodge. Transforms into a Smudge on death."
L["NPX_trash_dreadflail_desc1"] = "%s: tank buster — defensive. %s: AoE zone — kite the mob or use group cooldowns."
L["NPX_trash_lightwrought_desc1"] = "%s: interruptible spell targeting a random player. %s: magic debuff on 2 players — dispel."
L["NPX_trash_voidcaller_desc1"] = "%s: channel applying lethal damage — dispel curses immediately."
-- Boss 1: Chief Corewright Kasreth
L["NPX_boss1_name"]            = "Chief Corewright Kasreth"
L["NPX_boss1_desc1"]           = "%s: energy beams cross the room. Players affected by %s can stand at beam intersections to deactivate them."
L["NPX_boss1_desc2"]           = "%s: creates pools — drag them toward the room's edges to keep the center clear."
L["NPX_boss1_desc3"]           = "%s: applies a healing absorption and knockback — anticipate the movement."
L["NPX_boss1_desc4"]           = "%s: instant arcane damage replacing the boss's normal strikes."
-- Boss 2: Corewarden Nysarra
L["NPX_boss2_name"]            = "Corewarden Nysarra"
L["NPX_boss2_desc1"]           = "%s: targets two players — use a defensive and position to avoid hitting allies."
L["NPX_boss2_desc2"]           = "%s: summons a Dreadflail and 2 Grand Nullifiers. Kill adds before the channel ends — if the channel ends with adds alive, %s consumes them and empowers the boss."
L["NPX_boss2_desc3"]           = "%s: channel targeting the tank — use a strong defensive."
L["NPX_boss2_desc4"]           = "%s: an image creates a frontal with 300%% damage amplification — never stand in the cone."
-- Boss 3: Lothraxion
L["NPX_boss3_name"]            = "Lothraxion"
L["NPX_boss3_desc1"]           = "%s: leaves persistent pools on the ground — drop them on the room's edges."
L["NPX_boss3_desc2"]           = "%s: targets 3 players — spread away from allies to avoid splash damage."
L["NPX_boss3_desc3"]           = "%s: dash hitting players in its path — move laterally."
L["NPX_boss3_desc4"]           = "%s: the boss hides among images. %s: images strike anyone within 5 yards. Identify and interrupt the real target to trigger %s."

-- Windrunner Spire (WRS) — uiMapId 2492+
L["WRS_name"]             = "Windrunner Spire"
-- Intro
L["WRS_intro_desc1"]      = "Windrunner Spire — Midnight Season 1, new dungeon."
L["WRS_intro_desc2"]      = "4 bosses: Emberdawn -> Derelict Duo (Kalis &amp; Latch) -> Commander Kroluk -> The Restless Heart."
-- Notable Trash mob names
L["WRS_trash_magus_name"]       = "Spellguard Magus"
L["WRS_trash_steward_name"]     = "Restless Steward"
L["WRS_trash_woebringer_name"]  = "Devoted Woebringer"
L["WRS_trash_behemoth_name"]    = "Flesh Behemoth"
L["WRS_trash_mystic_name"]      = "Phantasmal Mystic"
-- Trash descriptions
L["WRS_trash_magus_desc1"]      = "%s: group damage — defensive cooldowns. %s: at 50%% health, creates a 99%% damage reduction zone — never remain in this zone; kill the mob quickly."
L["WRS_trash_steward_desc1"]    = "%s: interrupt. %s: magic debuff — dispel."
L["WRS_trash_woebringer_desc1"] = "%s: interrupt. %s: cast protected by a shield — break the shield or interrupt."
L["WRS_trash_behemoth_desc1"]   = "%s: spread to avoid splash damage. %s: tank buster — defensive."
L["WRS_trash_mystic_desc1"]     = "%s: interrupt. %s: enrage at 50%% health — Soothe immediately."
-- Boss 1: Emberdawn
L["WRS_boss1_name"]             = "Emberdawn"
L["WRS_boss1_desc1"]            = "%s: debuff on 2 players — move toward the arena's edges to drop the pool before it explodes."
L["WRS_boss1_desc2"]            = "%s: intermission with massive damage and fire frontals — group cooldowns and move out of cones. %s: tank buster with DoT — defensive on every cast."
-- Boss 2: Derelict Duo (Kalis & Latch)
L["WRS_boss2_name"]             = "Derelict Duo (Kalis & Latch)"
L["WRS_boss2_desc1"]            = "%s: Kalis cast — permanent interrupt rotation. %s: curse — dispel immediately."
L["WRS_boss2_desc2"]            = "%s + %s: both bosses combine their effects simultaneously — defensives and mobility. %s: spread to avoid splash damage."
L["WRS_boss2_desc3"]            = "%s: channel targeting the tank — strong defensive."
-- Boss 3: Commander Kroluk
L["WRS_boss3_name"]             = "Commander Kroluk"
L["WRS_boss3_desc1"]            = "%s: bursts of casts, always targeting the farthest player — stay grouped near the tank except the designated target who moves away. %s: proximity mechanic — move away from the boss."
L["WRS_boss3_desc2"]            = "%s: summons adds at 66%% and 33%% — group cooldowns. %s: fixates on a player — kite in circles. %s: tank channel — defensive."
-- Boss 4: The Restless Heart
L["WRS_boss4_name"]             = "The Restless Heart"
L["WRS_boss4_desc1"]            = "%s: stacking debuff — stand on ground arrows to clear it before %s. %s: summons %s — dodge the moving arrows."
L["WRS_boss4_desc2"]            = "%s: spread — also clears ground pools; use wisely. %s: frontal toward a random player — the target stands still to help others dodge. %s: tank buster with knockback — defensive."

-- Murder Row (MR)
L["MR_name"]              = "Murder Row"

-- Voidscar Arena (VA)
L["VA_name"]              = "Voidscar Arena"
