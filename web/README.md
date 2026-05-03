# MythicDungeonNotes — Web

Site statique des guides M+ de l'addon `MythicDungeonNotes`, généré à partir des
fichiers Lua. Bilingue EN/FR. Hébergé sur GitHub Pages.

## Comment ça marche

Le script `scripts/build-content.mjs` :

1. parse `MythicDungeonNotes/Locales/{enUS,frFR}.lua` (regex AceLocale) → `src/data/locales/{en,fr}.json`
2. évalue chaque `MythicDungeonNotes/Guide/Dungeons/*.lua` dans une VM Lua (wasmoon),
   avec des stubs pour `ns.L`, `ns.Spell(id)`, `ns.NPC(id, name)` → `src/data/guides/{en,fr}/<id>.json`
3. transforme la markup WoW (`|cffXXX|r` couleurs, `|T...|t` icônes, marqueurs Spell/NPC)
   en HTML + liens Wowhead
4. copie les images de donjon vers `public/images/`

Astro consomme ensuite ces JSON et génère un site statique avec une page par guide
× par langue. Les liens vers Wowhead sont décorés (icône, nom, tooltip) côté client
par le script officiel `wow.zamimg.com/widgets/power.js`.

## Développement local

```sh
cd web
npm install
npm run dev
```

Puis ouvrir <http://localhost:4321/MythicKeystone/en/>.

Hot-reload : modifier un composant `.astro`, le CSS, ou un JSON déclenche un reload
automatique. **Modifier un fichier `.lua` nécessite de relancer `npm run dev`**
(le script `predev` régénère les JSON au démarrage).

## Build de production

```sh
npm run build       # produit dist/
npm run preview     # sert dist/ pour vérifier le rendu prod
```

## Déploiement

Automatique via `.github/workflows/deploy-web.yml` à chaque push sur `main` qui
modifie `MythicDungeonNotes/**` ou `web/**`.

À activer une fois : `Settings → Pages → Source : GitHub Actions`.
