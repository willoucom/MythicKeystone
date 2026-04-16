local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Magisters' Terrace (MT) — Midnight S1 New
-- uiMapIds: 2520 (main), 2515 (library sub-zone)
-- Bosses: Arcanotron Custos, Seranel Sunlash, Gemellus, Degentrius
-------------------------------------------------------------------------------

-- HTML helpers
local function h1(s) return "<h1>" .. s .. "</h1>" end
local function p(s)  return "<p>"  .. s .. "</p>"  end
local function fmt(key, ...) return string.format(L[key], ...) end

ns.guideData[#ns.guideData + 1] = {
    id        = "MT",
    name      = L["MT_name"],
    shortName = "MT",
    groups    = { "S1" },
    icon      = "interface/lfgframe/lfgicon-magistersterrace-midnight",
    background = "interface/encounterjournal/ui-ej-background-magistersterrace-midnight",
    vignette   = "interface/lfgframe/ui-lfg-background-magistersterrace-midnight",
    spellportalid = 1254572,
    mapIds    = { 2515, 2520 },
    sections  = {
        -- ── Introduction ──────────────────────────────────────────────────
        {
            name = L["MT_intro_label"],
            htmlContent = table.concat({
                p(L["MT_intro_desc1"]),
                p(L["MT_intro_desc2"]),
                "<br/>",
                p(L["MT_library_note"]),
                "<img src='Interface/Addons/" .. myname .. "/Guide/Dungeons/Images/MT_book' width='500' height='300'/>",
            }),
        },
        -- ── Trash notable ─────────────────────────────────────────────────
        {
            name = L["MT_trash_label"],
            htmlContent = table.concat({
                h1(L["MT_trash_arcane_sentry_name"]),
                p(L["COMMON_cc_immune"]),
                p(fmt("MT_trash_arcane_sentry_desc1", ns.Spell(1282055))),
                p(fmt("MT_trash_arcane_sentry_desc2", ns.Spell(1282050))),
                p(fmt("MT_trash_arcane_sentry_desc3", ns.Spell(473258))),
                h1(L["MT_trash_arcane_magister_name"]),
                p(fmt("MT_trash_arcane_magister_desc1", ns.Spell(468966))),
                p(fmt("MT_trash_arcane_magister_desc2", ns.Spell(468962))),
                h1(L["MT_trash_sunblade_name"]),
                p(fmt("MT_trash_sunblade_desc1", ns.Spell(1252909))),
                p(fmt("MT_trash_sunblade_desc2", ns.Spell(1253224))),
                h1(L["MT_trash_lightward_name"]),
                p(fmt("MT_trash_lightward_desc1", ns.Spell(1255187))),
                p(fmt("MT_trash_lightward_desc2", ns.Spell(1254306))),
                h1(L["MT_trash_codex_name"]),
                p(fmt("MT_trash_codex_desc1", ns.Spell(1244985))),
                h1(L["MT_trash_pyromancer_name"]),
                p(L["COMMON_cc_immune"]),
                p(fmt("MT_trash_pyromancer_desc1", ns.Spell(1254294))),
                p(fmt("MT_trash_pyromancer_desc2", ns.Spell(1254338))),
                p(fmt("MT_trash_pyromancer_desc3", ns.Spell(1254301))),
                "<br/>",
                p(L["MT_trash_pyromancer_note"]),
                h1(L["MT_trash_familiar_name"]),
                p(fmt("MT_trash_familiar_desc1", ns.Spell(1279992))),
                h1(L["MT_trash_wyrm_name"]),
                p(fmt("MT_trash_wyrm_desc1", ns.Spell(1254595))),
                h1(L["MT_trash_spellbreaker_name"]),
                p(L["COMMON_cc_immune"]),
                p(fmt("MT_trash_spellbreaker_desc1", ns.Spell(1244907))),
                p(fmt("MT_trash_spellbreaker_desc2", ns.Spell(1283901))),
                "<br/>",
                p(L["MT_trash_spellbreaker_note"]),
                h1(L["MT_trash_voidling_name"]),
                p(fmt("MT_trash_voidling_desc1", ns.Spell(1255434))),
                h1(L["MT_trash_shredder_name"]),
                p(fmt("MT_trash_shredder_desc1", ns.Spell(1227020))),
                h1(L["MT_trash_voidwalker_name"]),
                p(fmt("MT_trash_voidwalker_desc1", ns.Spell(1256015))),
                h1(L["MT_trash_voidcaller_name"]),
                p(L["COMMON_cc_immune"]),
                p(fmt("MT_trash_voidcaller_desc1", ns.Spell(1255462))),
                p(fmt("MT_trash_voidcaller_desc2", ns.Spell(1265977))),
                h1(L["MT_trash_unstable_name"]),
                p(fmt("MT_trash_unstable_desc1", ns.Spell(1264951))),
                h1(L["MT_trash_void_infuser_name"]),
                p(fmt("MT_trash_void_infuser_desc1", ns.Spell(1264693))),
                p(fmt("MT_trash_void_infuser_desc2", ns.Spell(1245068))),
                h1(L["MT_trash_tyrant_name"]),
                p(L["COMMON_cc_immune"]),
                p(fmt("MT_trash_tyrant_desc1", ns.Spell(1264687))),
                p(fmt("MT_trash_tyrant_desc2", ns.Spell(1248219))),
            }),
        },
        -- ── Boss 1 : Arcanotron Custos ─────────────────────────────────────
        {
            name = L["MT_boss1"],
            htmlContent = table.concat({
                h1(L["MT_boss1"]),
                p(fmt("MT_boss1_desc1", ns.Spell(1214081))),
                p(fmt("MT_boss1_desc2", ns.Spell(1214038), ns.Spell(1214081))),
                p(fmt("MT_boss1_desc3", ns.Spell(474496))),
                p(fmt("MT_boss1_desc4", ns.Spell(474345), ns.Spell(474308), ns.Spell(1243905))),
            }),
        },
        -- ── Boss 2 : Seranel Sunlash ───────────────────────────────────────
        {
            name = L["MT_boss2"],
            htmlContent = table.concat({
                h1(L["MT_boss2"]),
                p(fmt("MT_boss2_desc1", ns.Spell(1224903), ns.Spell(1225792))),
                p(fmt("MT_boss2_desc2", ns.Spell(1225792), ns.Spell(1246446))),
                p(fmt("MT_boss2_desc3", ns.Spell(1248689))),
                p(fmt("MT_boss2_desc4", ns.Spell(1225193), ns.Spell(1224903))),
            }),
        },
        -- ── Boss 3 : Gemellus ──────────────────────────────────────────────
        {
            name = L["MT_boss3"],
            htmlContent = table.concat({
                h1(L["MT_boss3"]),
                p(fmt("MT_boss3_desc1", ns.Spell(1223847))),
                p(fmt("MT_boss3_desc2", ns.Spell(1284958))),
                p(fmt("MT_boss3_desc3", ns.Spell(1253709))),
                p(fmt("MT_boss3_desc4", ns.Spell(1224299))),
            }),
        },
        -- ── Boss 4 : Degentrius ────────────────────────────────────────────
        {
            name = L["MT_boss4"],
            htmlContent = table.concat({
                h1(L["MT_boss4"]),
                p(fmt("MT_boss4_desc1", ns.Spell(1214714), ns.Spell(1215157))),
                p(fmt("MT_boss4_desc2", ns.Spell(1280113), ns.Spell(1271066))),
                p(fmt("MT_boss4_desc3", ns.Spell(1215897))),
            }),
        },
    },
}
