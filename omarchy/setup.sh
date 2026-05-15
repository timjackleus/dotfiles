#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Code/dotfiles}"
KEYD_SOURCE="$DOTFILES_DIR/omarchy/keyd/dell-internal.conf"
KEYD_TARGET="/etc/keyd/dell-internal.conf"

if ! command -v keyd >/dev/null 2>&1; then
  if command -v omarchy-pkg-add >/dev/null 2>&1; then
    omarchy-pkg-add keyd
  else
    sudo pacman -S --needed keyd
  fi
fi

if grep -q "REPLACE_WITH_KEYD_MONITOR_ID" "$KEYD_SOURCE"; then
  printf 'Replace REPLACE_WITH_KEYD_MONITOR_ID in %s first.\n' "$KEYD_SOURCE" >&2
  printf 'Find the internal keyboard ID with: sudo keyd monitor\n' >&2
  exit 1
fi

sudo mkdir -p /etc/keyd
sudo ln -sf "$KEYD_SOURCE" "$KEYD_TARGET"
sudo keyd check "$KEYD_TARGET"
sudo systemctl enable --now keyd
sudo keyd reload

printf 'Installed keyd config: %s -> %s\n' "$KEYD_TARGET" "$KEYD_SOURCE"
printf 'Ensure ~/.config/hypr/input.conf contains: kb_options =\n'
