read the README.md

## Addons

This monorepo ships 4 addons:
- LibMythicKeystone — shared library
- MythicKeystone — LFG-frame keystone tracker
- MythicKeystone_LibDataBroker — Titan/Fubar broker
- MythicDungeonNotes — M+ dungeon guides (in-game + web)

## Commits

Conventional commits with scope: `type(scope): description`
- Types: `feat`, `fix`, `chore`, `refactor`, `ci`, `docs`
- Scope: addon name or area (e.g. `about`, `locales`, `ci`, `web`, `autokeystone`, `teleport`)

## Scripts (repo root)

- `deploy.py` — copy all addons to local WoW install (runs `fetch_deps.py` + `convert_assets.py` first)
- `fetch_deps.py` — resolve pkgmeta externals
- `convert_assets.py` — convert source images to TGA
- `preview_guides.py` — local guide preview

## Releases

- Release tag: `v.<YYYYMMDD>.<N>` (ex. `v.20260517.1`)
- Beta tag: `v.Beta.<YYYYMMDD>.<N>`
- `<N>` starts at 1 each day and increments if multiple tags are created the same day
- `.toc` files use `@project-version@` — no version bump in files
- Annotated tag from `main` after `git status` clean, then push
