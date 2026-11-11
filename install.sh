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

# Thunar rewrites its settings file on exit, so close it before copying.
run thunar -q 2>/dev/null || true

# Copy the tree.
while IFS= read -r -d '' src; do
  rel="${src#"$ROOT/home/"}"
  run mkdir -p "$(dirname "$HOME/$rel")"
  run cp "$src" "$HOME/$rel"
  echo "installed ~/$rel"
done < <(find "$ROOT/home" -type f -print0 | sort -z)

# Hide Desktop from Thunar's sidebar by pointing the Desktop directory at $HOME.
user_dirs="$HOME/.config/user-dirs.dirs"
if [ -f "$user_dirs" ] && grep -q '^XDG_DESKTOP_DIR=' "$user_dirs"; then
  # shellcheck disable=SC2016  # $HOME must stay literal in user-dirs.dirs
  run sed -i 's|^XDG_DESKTOP_DIR=.*|XDG_DESKTOP_DIR="$HOME"|' "$user_dirs"
  echo "updated ~/.config/user-dirs.dirs"
fi

# Refresh the font cache and confirm the font is visible.
if [ "$DRY" = 0 ]; then
  fc-cache -f
  if fc-list | grep -i "SF Pro Display" > /dev/null; then
    echo "font OK"
  else
    echo "warning: SF Pro Display not found. Put the .otf/.ttf files in ~/.local/share/fonts and run fc-cache -f" >&2
  fi
fi

echo "Done. Log out and back in to apply the Wayland-only settings."
