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

### Class on `GUILD` comes from the roster, not the wire

`LibKS` carries no class at all, and the `<class>` field of the `MythicKeystone`
payload is **ignored on `GUILD`**. Both receivers instead read it from the guild
club roster (`C_Club.GetGuildClubId` → `GetClubMembers` → `GetMemberInfo().classID`
→ `C_CreatureInfo.GetClassInfo`), the source Blizzard's own guild roster UI uses.
It covers offline members, so nothing has to travel on the wire.

The roster is asynchronous — `C_GuildInfo.GuildRoster()` only requests it — so
keystones arriving before it is ready are backfilled on `GUILD_ROSTER_UPDATE`.
Name matching is deliberate: the roster returns same-realm members bare
(`Arkama`) and connected-realm ones suffixed (`Bob-OtherRealm`), so bare names
get our realm appended rather than suffixed names being stripped — a short key
would collide between two members sharing a name across connected realms.

The `<class>` field is still *emitted* so that peers on older builds keep their
class colours. A future sunset will emit it empty (`525:12::Name-Realm:2500`);
the field itself stays in the format forever. Removing it would shift `fullname`
into slot 3, and an old client would then read `class="Name-Realm"` and
`fullname="2500"`, creating a junk entry — the empty field costs one byte and
avoids that entirely.

Note that `Alts` entries keep a **stored** class on purpose: an alt may be
guildless or in another guild, and no API reports the class of a character you
are not logged in on, so the capture made while playing it is the only source.

**Legacy compatibility (sunset 2026-07-15, done):** LMK clients prior to 2026-05
only spoke the `MythicKeystone` prefix on both `PARTY` and `GUILD`, with the
4-field form and the `requestPartyKeystone` / `requestGuildKeystone` request
messages. The emitter for that protocol was removed on the sunset date, along
with the `Addon.legacyWire` option and the `/lmk legacy` command; LibKeystone is
the wire for the active character. Reception remains tolerant — `PARTY` payloads
and 4-field messages are still accepted — which costs nothing and keeps data
flowing from any peer still on an old build.

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
  wipefakes, dryrun, log, …)

State is persisted in `LibMythicKeystoneDB.options`.

## Libraries used

- [LibStub](https://wowpedia.fandom.com/wiki/LibStub)
- [LibKeystone](https://github.com/BigWigsMods/LibKeystone)
- [ChatThrottleLib](https://wowpedia.fandom.com/wiki/ChatThrottleLib) — throttles
  the `MythicKeystone` alts broadcast so a large guild key push does not flood
  the addon-message channel.
