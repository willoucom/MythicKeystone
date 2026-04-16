#!/usr/bin/env python3
"""
fetch_deps.py - Download WoW addon external dependencies declared in .pkgmeta files.

Reads every .pkgmeta found under the repository root, parses the `externals`
section, and checks out/clones each dependency next to the source files —
exactly as the BigWigs packager would during a CI build.

Requires:
  pip install pyyaml

Usage:
  python fetch_deps.py              # fetch missing deps only
  python fetch_deps.py --update     # also update already-present deps
  python fetch_deps.py --addon MythicKeystone   # single addon
  python fetch_deps.py --list       # dry-run: print what would be fetched
"""

import argparse
import os
import subprocess
import sys
from pathlib import Path

try:
    import yaml
except ImportError:
    print("PyYAML is required.  Run:  pip install pyyaml")
    sys.exit(1)


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _run(cmd: list[str], cwd: Path | None = None) -> bool:
    result = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"    ERROR: {result.stderr.strip() or result.stdout.strip()}")
        return False
    return True


def _svn_available() -> bool:
    try:
        subprocess.run(["svn", "--version", "--quiet"], capture_output=True, check=True)
        return True
    except (FileNotFoundError, subprocess.CalledProcessError):
        return False


def _git_available() -> bool:
    try:
        subprocess.run(["git", "--version"], capture_output=True, check=True)
        return True
    except (FileNotFoundError, subprocess.CalledProcessError):
        return False


# ---------------------------------------------------------------------------
# Fetch strategies
# ---------------------------------------------------------------------------

def fetch_svn(url: str, dest: Path, update: bool) -> bool:
    if (dest / ".svn").exists():
        if update:
            print(f"  svn update  {dest.name}")
            return _run(["svn", "update"], cwd=dest)
        print(f"  skip (present)  {dest.name}")
        return True

    if dest.exists() and any(dest.iterdir()):
        # Directory exists but not an SVN working copy (e.g. tracked in git).
        # We leave it alone so as not to overwrite the developer's files.
        print(f"  skip (non-svn dir exists)  {dest.name}")
        return True

    print(f"  svn checkout  {url}  ->  {dest}")
    dest.parent.mkdir(parents=True, exist_ok=True)
    return _run(["svn", "checkout", url, str(dest)])


def fetch_git(url: str, dest: Path, tag: str | None, update: bool) -> bool:
    if (dest / ".git").exists():
        if update:
            print(f"  git pull  {dest.name}")
            return _run(["git", "-C", str(dest), "pull"])
        print(f"  skip (present)  {dest.name}")
        return True

    if dest.exists() and any(dest.iterdir()):
        print(f"  skip (non-git dir exists)  {dest.name}")
        return True

    print(f"  git clone  {url}  ->  {dest}")
    dest.parent.mkdir(parents=True, exist_ok=True)
    cmd = ["git", "clone", "--depth", "1"]
    if tag:
        cmd += ["--branch", tag]
    cmd += [url, str(dest)]
    return _run(cmd)


# ---------------------------------------------------------------------------
# .pkgmeta processing
# ---------------------------------------------------------------------------

def parse_external(rel_path: str, spec) -> dict:
    """Normalise an external entry to a canonical dict."""
    if isinstance(spec, str):
        return {"path": rel_path, "url": spec, "type": "svn", "tag": None}
    return {
        "path": rel_path,
        "url": spec.get("url", ""),
        "type": spec.get("type", "svn").lower(),
        "tag": spec.get("tag"),
    }


def process_pkgmeta(pkgmeta_path: Path, update: bool, dry_run: bool) -> int:
    addon_dir = pkgmeta_path.parent
    print(f"\n[{addon_dir.name}]  ({pkgmeta_path})")

    with open(pkgmeta_path, encoding="utf-8") as f:
        meta = yaml.safe_load(f) or {}

    externals = meta.get("externals", {})
    if not externals:
        print("  (no externals)")
        return 0

    errors = 0
    for rel_path, raw_spec in externals.items():
        ext = parse_external(rel_path, raw_spec)

        if not ext["url"]:
            print(f"  WARNING: no URL for {rel_path}")
            errors += 1
            continue

        dest = addon_dir / Path(rel_path)  # Path handles / on all platforms

        if dry_run:
            print(f"  [{ext['type']}]  {rel_path}  <-  {ext['url']}")
            continue

        ok = False
        if ext["type"] == "svn":
            if not _svn_available():
                print("  ERROR: svn not found in PATH.  Install Subversion.")
                errors += 1
                continue
            ok = fetch_svn(ext["url"], dest, update)
        elif ext["type"] in ("git", "github"):
            if not _git_available():
                print("  ERROR: git not found in PATH.")
                errors += 1
                continue
            ok = fetch_git(ext["url"], dest, ext["tag"], update)
        else:
            print(f"  WARNING: unknown type '{ext['type']}' for {rel_path}")
            errors += 1
            continue

        if not ok:
            errors += 1

    return errors


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

def main() -> None:
    parser = argparse.ArgumentParser(
        description="Fetch WoW addon external dependencies from .pkgmeta files.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    parser.add_argument(
        "--update", action="store_true",
        help="Update already-present dependencies (svn update / git pull).",
    )
    parser.add_argument(
        "--addon", metavar="NAME",
        help="Only process the addon whose directory name matches NAME.",
    )
    parser.add_argument(
        "--list", action="store_true",
        help="Dry-run: print dependencies without fetching anything.",
    )
    args = parser.parse_args()

    repo_root = Path(__file__).parent
    pkgmeta_files = sorted(repo_root.glob("**/.pkgmeta"))

    if not pkgmeta_files:
        print("No .pkgmeta files found.")
        return

    total_errors = 0
    for pkgmeta in pkgmeta_files:
        if args.addon and pkgmeta.parent.name != args.addon:
            continue
        total_errors += process_pkgmeta(pkgmeta, update=args.update, dry_run=args.list)

    print()
    if total_errors:
        print(f"Finished with {total_errors} error(s).")
        sys.exit(1)
    elif not args.list:
        print("All dependencies are up to date.")


if __name__ == "__main__":
    main()
