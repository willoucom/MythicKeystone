local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- Windrunner Spire (WRS) — Midnight S1 New
-- uiMapIds: 2492, 2496, 2557, 2558 (spire split across multiple zones)
-- Bosses: Emberdawn, Derelict Duo (Kalis & Latch), Commander Kroluk,
--         The Restless Heart
-------------------------------------------------------------------------------

-- HTML helpers
local function h1(s) return "<h1>" .. s:gsub("&", "&amp;") .. "</h1>" end
local function p(s)  return "<p>"  .. s .. "</p>"  end
local function fmt(key, ...) return string.format(L[key], ...) end

ns.guideData[#ns.guideData + 1] = {
    id        = "WRS",
    name      = L["WRS_name"],
    shortName = "WRS",
    groups = {"S1"},
    icon = "interface/lfgframe/lfgicon-windrunnerspire",
    background = "interface/encounterjournal/ui-ej-background-windrunnerspire",
    vignette = "interface/lfgframe/ui-lfg-background-windrunnerspire",
    spellportal = "Path of the Windrunners",
    spellportalid = 1254400,
    mapIds    = { 2492, 2496, 2557, 2558 },
    sections  = {
        -- ── Introduction ──────────────────────────────────────────────────
        {
            name = L["COMMON_intro_label"],
            htmlContent = table.concat({
                p(L["WRS_intro_desc1"]),
                p(L["WRS_intro_desc2"]),
            }),
        },
        -- ── Trash notable ─────────────────────────────────────────────────
        {
            name = L["COMMON_notable_trash"],
            htmlContent = table.concat({
                h1(L["WRS_trash_magus_name"]),
                p(fmt("WRS_trash_magus_desc1", ns.Spell(1216250), ns.Spell(1253683))),
                h1(L["WRS_trash_steward_name"]),
                p(fmt("WRS_trash_steward_desc1", ns.Spell(1216135), ns.Spell(1216298))),
                h1(L["WRS_trash_woebringer_name"]),
                p(fmt("WRS_trash_woebringer_desc1", ns.Spell(473657), ns.Spell(473668))),
                h1(L["WRS_trash_behemoth_name"]),
                p(fmt("WRS_trash_behemoth_desc1", ns.Spell(473776), ns.Spell(1277799))),
                h1(L["WRS_trash_mystic_name"]),
                p(fmt("WRS_trash_mystic_desc1", ns.Spell(1251981), ns.Spell(1216459))),
            }),
        },
        -- ── Boss 1 : Emberdawn ────────────────────────────────────────────
        {
            name = L["WRS_boss1_name"],
            htmlContent = table.concat({
                h1(L["WRS_boss1_name"]),
                p(fmt("WRS_boss1_desc1", ns.Spell(466556))),
                p(fmt("WRS_boss1_desc2", ns.Spell(465904), ns.Spell(466064))),
            }),
        },
        -- ── Boss 2 : Duo Délabré (Kalis & Latch) ─────────────────────────
        {
            name = L["WRS_boss2_name"],
            htmlContent = table.concat({
                h1(L["WRS_boss2_name"]),
                p(fmt("WRS_boss2_desc1", ns.Spell(472724), ns.Spell(474105))),
                p(fmt("WRS_boss2_desc2", ns.Spell(472736), ns.Spell(472795), ns.Spell(472745))),
                p(fmt("WRS_boss2_desc3", ns.Spell(472888))),
            }),
        },
        -- ── Boss 3 : Commander Kroluk ─────────────────────────────────────
        {
            name = L["WRS_boss3_name"],
            htmlContent = table.concat({
                h1(L["WRS_boss3_name"]),
                p(fmt("WRS_boss3_desc1", ns.Spell(472054), ns.Spell(1253026))),
                p(fmt("WRS_boss3_desc2", ns.Spell(472043), ns.Spell(470963), ns.Spell(467620))),
            }),
        },
        -- ── Boss 4 : The Restless Heart ───────────────────────────────────
        {
            name = L["WRS_boss4_name"],
            htmlContent = table.concat({
                h1(L["WRS_boss4_name"]),
                p(fmt("WRS_boss4_desc1", ns.Spell(1216042), ns.Spell(468429), ns.Spell(472556), ns.Spell(1253977))),
                p(fmt("WRS_boss4_desc2", ns.Spell(1253986), ns.Spell(474528), ns.Spell(472662))),
            }),
        },
    },
}
