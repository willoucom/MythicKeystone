# LibMythicKeystone

LibMythicKeystone is a library that retrieves and synchronizes Mythic+ keystones.
The library exposes keystone data across your characters for use in various addons.

## Usage

In your addon:
```lua
local lib = LibStub("LibMythicKeystone-1.0")
if not lib then return end
```

Then you can access keystones with the following methods:

- Get the current character's keystone: `lib.getMyKeystone()`
- Get alts' keystones: `lib.getAltsKeystone()`
- Get party keystones (in beta, subject to change): `lib.getPartyKeystone()`
- Get guild keystones (in beta, subject to change): `lib.getGuildKeystone()`

Data format:
```lua
{
    ["class"] = CLASSNAME,          -- Uppercase, use with C_ClassColor.GetClassColor(key["class"]):GenerateHexColorMarkup()
    ["name"] = "CharacterName",
    ["realm"] = "RealmName",
    ["guild"] = "GuildName",
    ["fullname"] = "Name-Realm",    -- Unique key, use with C_ChallengeMode.GetMapUIInfo()
    ["current_key"] = 0,            -- Dungeon map ID, use with C_ChallengeMode.GetMapUIInfo(key["current_key"])
    ["current_keylevel"] = 0,       -- Level of the keystone
    ["weeklybest"] = 0,             -- Best keystone level completed this week
    ["weeklycount"] = 0,            -- Number of Mythic+ runs completed this week
    ["mplus_score"] = 0,            -- Mythic+ rating for the current season (may be nil for peers using a protocol that does not carry it)
    ["week"] = 0,                   -- Week number, data is only valid for the current week
}
```

## Wire protocol

Two addon-message prefixes are used:

- **`LibKS`** — provided by [LibKeystone](https://github.com/BigWigsMods/LibKeystone),
  interoperable with BigWigs, recent AstralKeys, Keystone Manager, etc.
  Carries the currently-logged-in character on `PARTY` and `GUILD`.
- **`MythicKeystone`** — LMK-specific, used to broadcast the player's *other*
  characters (offline alts) on `GUILD` only. Payload format
  `"<mapID>:<level>:<class>:<fullname>:<mplus_score>"`. The 5th field is
  optional (older 4-field messages are still accepted).

**Legacy compatibility (sunset 2026-07-15):** LMK clients prior to 2026-05 only
spoke the `MythicKeystone` prefix on both `PARTY` and `GUILD`, with the 4-field
form and the `requestPartyKeystone` / `requestGuildKeystone` request messages.
The current code keeps a bilingual receiver permanently and an opt-out emitter
controlled by `Addon.legacyWire` (default on, toggle via `/lmk legacy on|off`).
On sunset the LEGACY EMITTER block in `LibMythicKeystone.lua` can be removed
together with the legacy request keywords in `OnLegacyReceived`.

Two reception sources also exist purely for interop with other addons:

- [AngryKeystones](https://github.com/Ermad/angry-keystones) — prefix
  `AngryKeystones`, module `Schedule`, format `"<mapID>:<level>"` on `PARTY`.
- [AstralKeys](https://github.com/astralguild/AstralKeys) — prefix `AstralKeys`,
  sub-prefixes `updateV9` and `sync6` on `GUILD` (and `SavedVariable` import
  when the addon is installed locally).

See `plugin_angrykeystones.lua` and `plugin_astralkeys.lua` for the wire
details.

## Debug

- `/lmk debug` — toggle the debug panel (no reload required)
- `/lmk help` — list all slash commands (show, broadcast, reset, fake,
  wipefakes, dryrun, legacy, log, …)

State is persisted in `LibMythicKeystoneDB.options`.

## Libraries used

- [LibStub](https://wowpedia.fandom.com/wiki/LibStub)
- [LibKeystone](https://github.com/BigWigsMods/LibKeystone)
- [ChatThrottleLib](https://wowpedia.fandom.com/wiki/ChatThrottleLib) — throttles
  the `MythicKeystone` alts broadcast so a large guild key push does not flood
  the addon-message channel.
