#!/usr/bin/env python3
"""
Convert images from ./Assets to TGA format in ./Guide/Dungeons/Assets/
Supported input formats: PNG, JPG, JPEG, BMP, WEBP
"""

import sys
from pathlib import Path

try:
    from PIL import Image
except ImportError:
    print("Pillow n'est pas installé. Lance : pip install Pillow")
    sys.exit(1)

SCRIPT_DIR = Path(__file__).parent
SRC_DIR = SCRIPT_DIR / "MythicDungeonNotes" / "Assets"
DST_DIR = SCRIPT_DIR / "MythicDungeonNotes" / "Guide" / "Dungeons" / "Images"
SUPPORTED = {".png", ".jpg", ".jpeg", ".bmp", ".webp"}


def convert(src: Path, dst: Path) -> None:
    img = Image.open(src)
    # TGA supporte RGBA et RGB ; on convertit selon la présence d'alpha
    if img.mode in ("RGBA", "LA"):
        img = img.convert("RGBA")
    else:
        img = img.convert("RGB")
    dst.parent.mkdir(parents=True, exist_ok=True)
    img.save(dst, format="TGA")


def main() -> None:
    if not SRC_DIR.exists():
        print(f"Dossier source introuvable : {SRC_DIR}")
        sys.exit(1)

    images = [f for f in SRC_DIR.iterdir() if f.is_file() and f.suffix.lower() in SUPPORTED]

    if not images:
        print(f"Aucune image trouvée dans {SRC_DIR}")
        return

    print(f"Source      : {SRC_DIR}")
    print(f"Destination : {DST_DIR}")
    print(f"Images      : {len(images)}\n")

    errors = []
    for src in sorted(images):
        dst = DST_DIR / (src.stem + ".tga")
        try:
            convert(src, dst)
            print(f"  OK  {src.name} -> {dst.name}")
        except Exception as exc:
            print(f"  ERR {src.name} : {exc}")
            errors.append(src.name)

    print(f"\n{len(images) - len(errors)}/{len(images)} fichier(s) convertis.")
    if errors:
        print("Erreurs :", ", ".join(errors))
        sys.exit(1)


if __name__ == "__main__":
    main()
