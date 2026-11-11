#!/usr/bin/env bash
# Install the Fern configuration into $HOME.
#
#   bash install.sh [--dry-run]
#
# Copies everything under ./home to $HOME, overwriting files of the same name
# (no backup). Files that are not part of this repo are left alone.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY=0
case "${1:-}" in
  "") ;;
  --dry-run) DRY=1 ;;
  *) echo "usage: bash install.sh [--dry-run]" >&2; exit 2 ;;
esac

run() { if [ "$DRY" = 1 ]; then echo "[dry-run] $*"; else "$@"; fi; }

# Copy the tree.
while IFS= read -r -d '' src; do
  rel="${src#"$ROOT/home/"}"
  run mkdir -p "$(dirname "$HOME/$rel")"
  run cp "$src" "$HOME/$rel"
  echo "installed ~/$rel"
done < <(find "$ROOT/home" -type f -print0 | sort -z)

# Refresh the font cache and confirm the font is visible.
if [ "$DRY" = 0 ]; then
  fc-cache -f
  if fc-list | grep -i "JetBrainsMono Nerd Font Mono" > /dev/null; then
    echo "font OK"
  else
    echo "warning: JetBrainsMono Nerd Font Mono not found" >&2
  fi
fi

echo "Done. Log out and back in to apply the Wayland-only settings."
