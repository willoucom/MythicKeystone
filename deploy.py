#!/usr/bin/env python3
"""
deploy.py - Build and deploy WoW addons to the local WoW installation.

Pre-processing steps (run before the copy):
  1. fetch_deps.py  – download / update external dependencies
  2. convert_assets.py – convert source images to TGA

Then each addon folder is mirrored to the WoW AddOns directory via robocopy.

Usage:
  python deploy.py                  # fetch missing deps, convert assets, deploy all
  python deploy.py --update         # also update already-present deps
  python deploy.py --addon NAME     # single addon (skips fetch/convert for others)
  python deploy.py --dry-run        # print what would be done, no copy
"""

import argparse
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).parent

_WIN_WOW_PATH = r"C:\Games\World of Warcraft\_retail_\Interface\AddOns"

def _resolve_wow_base() -> Path:
    """Return the WoW AddOns path for the current platform (Windows or WSL)."""
    platform = sys.platform  # avoid Pyright's static sys.platform narrowing
    # WSL: convert C:\foo\bar → /mnt/c/foo/bar
    if platform != "win32":
        drive = _WIN_WOW_PATH[0].lower()
        rest = _WIN_WOW_PATH[2:].replace("\\", "/")
        return Path(f"/mnt/{drive}{rest}")
    return Path(_WIN_WOW_PATH)

WOW_BASE = _resolve_wow_base()

ADDONS: list[dict] = [
    {
        "name": "LibMythicKeystone",
        "exclude": ["README.md", "DEVELOPERS.md", ".pkgmeta"],
    },
    {
        "name": "MythicKeystone",
        "exclude": ["README.md", ".pkgmeta"],
    },
    {
        "name": "MythicKeystone_LibDataBroker",
        "exclude": ["README.md", ".pkgmeta"],
    },
    {
        "name": "MythicDungeonNotes",
        "exclude": ["README.md", ".pkgmeta", "deploy.ps1", "convert_assets.py", "Assets"],
    },
]

# Directories always excluded from the copy
EXCLUDED_DIRS = {".git", ".github", ".vscode", ".svn"}


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _run_script(script: Path, extra_args: list[str] | None = None) -> bool:
    cmd = [sys.executable, str(script)] + (extra_args or [])
    print(f"\n>>> {' '.join(cmd)}")
    result = subprocess.run(cmd, cwd=ROOT)
    return result.returncode == 0


def _mirror(source: Path, dest: Path, exclude_files: set[str], dry_run: bool) -> bool:
    """Recursively mirror source into dest, skipping excluded dirs and files."""
    errors: list[str] = []

    def _copy_tree(src: Path, dst: Path) -> None:
        dst.mkdir(parents=True, exist_ok=True)
        for item in src.iterdir():
            if item.is_dir():
                if item.name in EXCLUDED_DIRS:
                    continue
                _copy_tree(item, dst / item.name)
            else:
                if item.name in exclude_files:
                    continue
                dst_file = dst / item.name
                if dry_run:
                    print(f"  [dry-run] {item.relative_to(source)} -> {dst_file.relative_to(dest)}")
                    return
                try:
                    shutil.copy2(item, dst_file)
                except OSError as exc:
                    print(f"  ERR {item}: {exc}")
                    errors.append(str(item))

    _copy_tree(source, dest)
    return not errors


# ---------------------------------------------------------------------------
# Pre-processing steps
# ---------------------------------------------------------------------------

def step_fetch_deps(update: bool) -> bool:
    print("\n" + "=" * 60)
    print("STEP 1 – Fetching external dependencies")
    print("=" * 60)
    script = ROOT / "fetch_deps.py"
    args = ["--update"] if update else []
    ok = _run_script(script, args)
    if not ok:
        print("fetch_deps.py failed.")
    return ok


def step_convert_assets() -> bool:
    print("\n" + "=" * 60)
    print("STEP 2 – Converting assets to TGA")
    print("=" * 60)
    script = ROOT / "convert_assets.py"
    ok = _run_script(script)
    if not ok:
        print("convert_assets.py failed.")
    return ok


# ---------------------------------------------------------------------------
# Deploy step
# ---------------------------------------------------------------------------

def step_deploy(addon_filter: str | None, dry_run: bool) -> bool:
    print("\n" + "=" * 60)
    print("STEP 3 – Deploying addons")
    print("=" * 60)

    has_error = False

    for addon in ADDONS:
        name = addon["name"]
        if addon_filter and name != addon_filter:
            continue

        source = ROOT / name
        dest = WOW_BASE / name

        print(f"\nDeploying {name}...")
        print(f"  From : {source}")
        print(f"  To   : {dest}")

        ok = _mirror(source, dest, set(addon["exclude"]), dry_run)

        if ok:
            print("  Done.")
        else:
            print(f"  Deploy error for {name}.")
            has_error = True

    return not has_error


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

def main() -> None:
    parser = argparse.ArgumentParser(
        description="Fetch deps, convert assets, then deploy WoW addons.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    parser.add_argument(
        "--update", action="store_true",
        help="Also update already-present external dependencies.",
    )
    parser.add_argument(
        "--addon", metavar="NAME",
        help="Only deploy the addon whose directory name matches NAME.",
    )
    parser.add_argument(
        "--dry-run", action="store_true",
        help="Print what would be done without copying any files.",
    )
    parser.add_argument(
        "--skip-fetch", action="store_true",
        help="Skip the fetch_deps pre-processing step.",
    )
    parser.add_argument(
        "--skip-convert", action="store_true",
        help="Skip the convert_assets pre-processing step.",
    )
    args = parser.parse_args()

    ok = True

    if not args.skip_fetch:
        ok = step_fetch_deps(update=args.update) and ok

    if not args.skip_convert:
        ok = step_convert_assets() and ok

    ok = step_deploy(addon_filter=args.addon, dry_run=args.dry_run) and ok

    print()
    if ok:
        print("All steps completed successfully.")
    else:
        print("One or more steps failed.")
        sys.exit(1)


if __name__ == "__main__":
    main()
