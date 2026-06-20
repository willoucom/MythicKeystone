#!/usr/bin/env python3
"""generate_teleports.py - Generate MythicKeystone's teleport spell table.

Single source of truth: the MythicDungeonNotes dungeon definitions, which carry
both `challengeMapID` (the ChallengesFrame map id MythicKeystone keys on) and
`spellportalid` (the teleport spell). This script reads those files and writes
`MythicKeystone/TeleportData.lua` (a generated `ns.TeleportSpells` table), so the
teleport spell ids live in exactly one place and cannot drift between addons.

Usage:
  python generate_teleports.py            # regenerate the table
  python generate_teleports.py --check    # exit 1 if the committed file is stale
"""

import argparse
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent
DUNGEONS_DIR = REPO / "MythicDungeonNotes" / "Guide" / "Dungeons"
OUTPUT = REPO / "MythicKeystone" / "TeleportData.lua"

RE_ID = re.compile(r'(?m)^\s*id\s*=\s*"([^"]+)"')
RE_PORTAL = re.compile(r'(?m)^\s*spellportalid\s*=\s*(\d+)')
RE_CHALLENGE = re.compile(r'(?m)^\s*challengeMapID\s*=\s*(\d+)')

HEADER = """\
-- AUTO-GENERATED - do not edit by hand.
-- Source of truth: MythicDungeonNotes/Guide/Dungeons/*.lua (challengeMapID + spellportalid).
-- Regenerate with: python generate_teleports.py
-- Drift is enforced in CI (.github/workflows/check-teleports.yml).

local _, ns = ...

-- challengeMapID -> teleport spellID
ns.TeleportSpells = {
"""

FOOTER = "}\n"


def collect_entries():
    """Return (entries, warnings).

    entries: list of (challengeMapID, spellID, shortId) sorted by challengeMapID.
    warnings: human-readable strings for dungeons with a portal but no map id.
    """
    entries = []
    warnings = []
    for path in sorted(DUNGEONS_DIR.glob("*.lua")):
        if path.name == "_demo.lua":
            continue
        text = path.read_text(encoding="utf-8")
        portal = RE_PORTAL.search(text)
        challenge = RE_CHALLENGE.search(text)
        short = RE_ID.search(text)
        short_id = short.group(1) if short else path.stem

        if portal and not challenge:
            warnings.append(
                f"{path.name}: has spellportalid but no challengeMapID "
                f"(no teleport button will be generated for '{short_id}')"
            )
            continue
        if not (portal and challenge):
            continue
        entries.append((int(challenge.group(1)), int(portal.group(1)), short_id))

    entries.sort(key=lambda e: e[0])
    return entries, warnings


def render(entries):
    width = max((len(str(c)) for c, _, _ in entries), default=1)
    lines = []
    for challenge, spell, short_id in entries:
        key = f"[{challenge}]".ljust(width + 2)
        lines.append(f"    {key} = {spell},  -- {short_id}")
    return HEADER + "\n".join(lines) + "\n" + FOOTER


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true",
                        help="Exit 1 if the committed file is out of date.")
    args = parser.parse_args()

    entries, warnings = collect_entries()
    for w in warnings:
        print(f"  WARNING: {w}")
    if not entries:
        print("ERROR: no dungeons with both challengeMapID and spellportalid found.")
        sys.exit(1)

    content = render(entries)

    if args.check:
        current = OUTPUT.read_text(encoding="utf-8") if OUTPUT.exists() else ""
        if current != content:
            print(f"ERROR: {OUTPUT.relative_to(REPO)} is out of date.")
            print("       Run `python generate_teleports.py` and commit the result.")
            sys.exit(1)
        print(f"OK: {OUTPUT.relative_to(REPO)} is up to date ({len(entries)} dungeons).")
        return

    # Write LF endings (.gitattributes normalises the repo to LF).
    with open(OUTPUT, "w", encoding="utf-8", newline="\n") as f:
        f.write(content)
    print(f"Wrote {OUTPUT.relative_to(REPO)} ({len(entries)} dungeons).")


if __name__ == "__main__":
    main()
