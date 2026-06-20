# MythicKeystone — Monorepo

This repository contains four World of Warcraft addons for Mythic+ players: three for keystone tracking and one for in-game dungeon guides.

---

## Addons

### [LibMythicKeystone](LibMythicKeystone/)

A shared library that retrieves and synchronizes Mythic+ keystones across your characters and guild. Exposes keystone data for use by other addons. Does not display anything on its own — install as a dependency.

### [MythicKeystone](MythicKeystone/)

**Stop alt-tabbing. Stop asking in guild chat. Everything you need to plan your Mythic+ run is now right inside the LFG frame.**

Displays your alts' keystones, your party members' keystones, and your guild's keystones — all in one place, updated in real time.

**Features:**
- **Alts Panel** — all your characters' keystones at a glance (level, dungeon, weekly best)
- **Party Panel** — check what keys your group is holding before entering
- **Guild Panel** — browse guild keystones grouped by dungeon
- **Auto Keystone** — automatically slots your keystone when opening the Mythic+ UI, with Ready Check and Countdown buttons

**Requires:** LibMythicKeystone

### [MythicKeystone_LibDataBroker](MythicKeystone_LibDataBroker/)

**Your mythic keystones, right in your Titan Panel or Fubar bar.**

Exposes your current keystone as a broker data source with a tooltip showing all your alts' and guild members' keystones, grouped by dungeon.

**Features:**
- Broker text with current key level and dungeon
- Click to open/close the LFG frame
- Tooltip with alts and guild keystones grouped by dungeon
- WoW Addon Compartment support

**Requires:** LibMythicKeystone, MythicKeystone, and a LibDataBroker display (Titan Panel, Fubar, Bazooka…)

### [MythicDungeonNotes](MythicDungeonNotes/)

**Never tab out of the game again to check a strategy.**

A lightweight in-game guide for Mythic+ dungeons — boss mechanics, interrupt priorities, skip routes and positioning tips, one click away.

**Features:**
- **Dungeon list view** — all dungeons laid out as vignette cards with their artwork
- **Automatic zone detection** — opens straight to the guide of the dungeon you're in
- **Two-column layout** — section menu on the left, notes with maps and icons on the right
- **Draggable button and window** — positions saved between sessions

---

## Supported Languages

🇺🇸 English &nbsp;|&nbsp; 🇫🇷 Français &nbsp;|&nbsp; 🇷🇺 Русский &nbsp;|&nbsp; 🇩🇪 Deutsch &nbsp;|&nbsp; 🇹🇼 繁體中文

Coverage varies by addon: English, French and Russian are available across all addons; German and Traditional Chinese cover the MythicKeystone interface.

---

## Local Deployment

Run `deploy.py` at the root to copy all addons to your local WoW installation:

```powershell
python deploy.py
```

---

## Feedback & Issues

Found a bug or have a suggestion? Open an issue on [GitHub](https://github.com/willoucom/MythicKeystone).
