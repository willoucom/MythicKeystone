# MythicKeystone — Monorepo

This repository contains three World of Warcraft addons related to Mythic+ keystone tracking.

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

---

## Supported Languages

🇺🇸 English &nbsp;|&nbsp; 🇫🇷 Français &nbsp;|&nbsp; 🇩🇪 Deutsch &nbsp;|&nbsp; 🇹🇼 繁體中文

---

## Local Deployment

Run `deploy.ps1` at the root to copy all three addons to your local WoW installation:

```powershell
.\deploy.ps1
```

---

## Feedback & Issues

Found a bug or have a suggestion? Open an issue on [GitHub](https://github.com/willoucom/MythicKeystone).
