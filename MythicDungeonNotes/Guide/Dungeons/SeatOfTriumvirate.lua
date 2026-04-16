local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Seat of the Triumvirate (SoT) — Midnight S1 Legacy
-- uiMapId: 903
-- Bosses: Zuraal the Ascended, Saprish, Viceroy Nezhar, L'ura
-------------------------------------------------------------------------------

-- HTML helpers
local function h1(s) return "<h1>" .. s .. "</h1>" end
local function p(s)  return "<p>"  .. s .. "</p>"  end
local function fmt(key, ...) return string.format(L[key], ...) end

ns.guideData[#ns.guideData + 1] = {
    id        = "SOT",
    name      = L["SOT_name"],
    shortName = "SoT",
    groups = {"LEGION","S1"},
    icon = "interface/lfgframe/lfgicon-seatofthetriumvirate",
    background = "interface/encounterjournal/ui-ej-background-seatofthetriumvirate",
    vignette = "interface/lfgframe/ui-lfg-background-seatofthetriumvirate",
    spellportalid = 1254551,
    mapIds    = { 903 },
    sections  = {
        -- ── Introduction ──────────────────────────────────────────────────
        {
            name = L["COMMON_intro_label"],
            htmlContent = table.concat({
                p(L["SOT_intro_desc1"]),
                p(L["SOT_intro_desc2"]),
            }),
        },
        -- ── Trash notable ─────────────────────────────────────────────────
        {
            name = L["COMMON_notable_trash"],
            htmlContent = table.concat({
                h1(L["SOT_trash1_name"]),
                p(L["COMMON_cc_immune"]),
                p(fmt("SOT_trash1_desc1", ns.Spell(1262509), ns.Spell(1262506))),
                h1(L["SOT_trash2_name"]),
                p(fmt("SOT_trash2_desc1", ns.Spell(1262523), ns.Spell(1262510))),
                h1(L["SOT_trash3_name"]),
                p(L["COMMON_cc_immune"]),
                p(fmt("SOT_trash3_desc1", ns.Spell(1264464), ns.Spell(1280330), ns.Spell(1264569))),
                h1(L["SOT_trash4_name"]),
                p(fmt("SOT_trash4_desc1", ns.Spell(1262514), ns.Spell(1264036))),
                h1(L["SOT_trash5_name"]),
                p(fmt("SOT_trash5_desc1", ns.Spell(1262526))),
            }),
        },
        -- ── Boss 1 : Zuraal the Ascended ──────────────────────────────────
        {
            name = L["SOT_boss1_name"],
            htmlContent = table.concat({
                h1(L["SOT_boss1_name"]),
                p(fmt("SOT_boss1_desc1", ns.Spell(1263399), ns.Spell(1263297))),
                p(fmt("SOT_boss1_desc2", ns.Spell(1263282), ns.Spell(1263440), ns.Spell(1268916))),
            }),
        },
        -- ── Boss 2 : Saprish ──────────────────────────────────────────────
        {
            name = L["SOT_boss2_name"],
            htmlContent = table.concat({
                h1(L["SOT_boss2_name"]),
                p(fmt("SOT_boss2_desc1", ns.Spell(1263523), ns.Spell(1280067), ns.Spell(246026))),
                p(fmt("SOT_boss2_desc2", ns.Spell(248831), ns.Spell(245742))),
            }),
        },
        -- ── Boss 3 : Viceroy Nezhar ───────────────────────────────────────
        {
            name = L["SOT_boss3_name"],
            htmlContent = table.concat({
                h1(L["SOT_boss3_name"]),
                p(fmt("SOT_boss3_desc1", ns.Spell(1277358), ns.Spell(1264257), ns.Spell(1263529))),
                p(fmt("SOT_boss3_desc2", ns.Spell(1263538), ns.Spell(244750), ns.Spell(1263542))),
            }),
        },
        -- ── Boss 4 : L'ura ────────────────────────────────────────────────
        {
            name = L["SOT_boss4_name"],
            htmlContent = table.concat({
                h1(L["SOT_boss4_name"]),
                p(fmt("SOT_boss4_desc1", ns.Spell(1265421), ns.Spell(1265650), ns.Spell(1265464), ns.Spell(1265419))),
                p(fmt("SOT_boss4_desc2", ns.Spell(1265689), ns.Spell(1264196))),
                p(fmt("SOT_boss4_desc3", ns.Spell(1267207), ns.Spell(1265999))),
            }),
        },
    },
}
