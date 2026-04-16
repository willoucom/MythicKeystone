local myname, ns = ...
local L = ns.L

-------------------------------------------------------------------------------
-- demo — for testing HTML rendering in GuideFrame
-- uiMapId: none
-- Bosses: none
-------------------------------------------------------------------------------

local ICON_BRONZE = "|TInterface/Icons/INV_Misc_Head_Dragon_Bronze:20:20|t"
local ICON_RED    = "|TInterface/Icons/INV_Misc_Head_Dragon_Red:20:20|t"
local ICON_GREEN  = "|TInterface/Icons/INV_Misc_Head_Dragon_Green:20:20|t"
local ICON_BLUE   = "|TInterface/Icons/INV_Misc_Head_Dragon_Blue:20:20|t"
local ICON_BLACK  = "|TInterface/Icons/INV_Misc_Head_Dragon_Black:20:20|t"

ns.guideData[#ns.guideData + 1] = {
    id        = "TT",
    name      = "Demo HTML",
    shortName = "TT",
    groups = {"demo"},
    icon = "interface/lfgframe/lfgicon-theacademy",
    background = "interface/encounterjournal/ui-ej-background-theacademy",
    vignette = "interface/lfgframe/ui-lfg-background-theacademy",
    spellportalid = 393273,
    mapIds    = { 2097 },
    sections  = {
        {
            name = "Test — Démo HTML",
            htmlContent =
                -- ── Titres (h1–h3 : taille via GuideFrame:SetFont) ───────────
                "<h1>Titre h1</h1>" ..
                "<h2>Titre h2</h2>" ..
                "<h3>Titre h3</h3>" ..
                "<br/>" ..

                -- ── Couleurs via escape codes WoW (|cffRRGGBB...|r) ──────────
                -- C'est la SEULE façon de coloriser du texte dans SimpleHTML.
                -- Les balises <font>, <b>, <i>, <u> ne sont pas supportées.
                "<p>" ..
                    "|cffFF4444Rouge|r  " ..
                    "|cff44FF44Vert|r  " ..
                    "|cff6699FFBleu|r  " ..
                    "|cffFFCC00Jaune|r  " ..
                    "|cffFF9900Orange|r  " ..
                    "|cffCC44FFViolet|r  " ..
                    "|cffAAAAAAGris|r" ..
                "</p>" ..
                "<br/>" ..

                -- ── Icônes inline via |T...:W:H|t ────────────────────────────
                -- <img> sert aux grandes textures fichier (ex: cartes).
                -- Pour les icônes inline, utiliser l'escape |T...:W:H|t.
                "<p>" ..
                    "|TInterface/Icons/INV_Misc_Head_Dragon_Bronze:16:16|t 16px  " ..
                    "|TInterface/Icons/INV_Misc_Head_Dragon_Red:24:24|t 24px  " ..
                    "|TInterface/Icons/INV_Misc_Head_Dragon_Green:32:32|t 32px  " ..
                    "|TInterface/Icons/INV_Misc_Head_Dragon_Blue:40:40|t 40px  " ..
                    "|TInterface/Icons/INV_Misc_Head_Dragon_Black:48:48|t 48px" ..
                "</p>" ..
                "<br/>" ..

                -- ── Liens sorts cliquables (hyperlink |Hspell:ID|h) ──────────
                "<p>" .. ns.Spell(388796) .. "  " .. ns.Spell(388625) .. "  " .. ns.Spell(396640) .. "</p>" ..
                "<br/>" ..

                -- ── Simulation de liste (pas de <ul>/<ol> dans SimpleHTML) ────
                "<p>|cffFFD700• |rÉlément A</p>" ..
                "<p>|cffFFD700• |rÉlément B</p>" ..
                "<p>|cffFFD700• |rÉlément C</p>" ..
                "<br/>" ..

                -- ── Grande image fichier via <img> ────────────────────────────
                "<img src='Interface/Addons/" .. L["AddonCodeName"] .. "/Guide/Dungeons/Images/AA_map' width='500' height='300'/>" ..
                "<br/>",
        }
    },
}
