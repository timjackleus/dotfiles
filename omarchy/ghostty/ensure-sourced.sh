#!/usr/bin/env bash
set -euo pipefail

GHOSTTY_CONF="$HOME/.config/ghostty/config"
OMARCHY_PATH="${OMARCHY_PATH:-/usr/share/omarchy}"
OMARCHY_GHOSTTY_CONF="$OMARCHY_PATH/config/ghostty/config"
SOURCE_LINE='config-file = ?tim.conf'
MARKER='# Tim dotfiles Ghostty overlay'
QUATTRO_THEME_LINE='config-file = ?"~/.local/state/omarchy/current/theme/ghostty.conf"'

mkdir -p "$(dirname "$GHOSTTY_CONF")"

if [[ ! -f "$OMARCHY_GHOSTTY_CONF" ]]; then
  printf 'Omarchy Ghostty config not found at %s.\n' "$OMARCHY_GHOSTTY_CONF" >&2
  exit 1
fi

if [[ ! -f "$GHOSTTY_CONF" ]]; then
  cp "$OMARCHY_GHOSTTY_CONF" "$GHOSTTY_CONF"
elif ! grep -qxF "$QUATTRO_THEME_LINE" "$GHOSTTY_CONF"; then
  backup="$GHOSTTY_CONF.pre-quattro.bak.$(date +%s)"
  cp -L "$GHOSTTY_CONF" "$backup"
  rm -f "$GHOSTTY_CONF"
  cp "$OMARCHY_GHOSTTY_CONF" "$GHOSTTY_CONF"
  printf 'Replaced legacy Ghostty base config; backup saved at %s\n' "$backup"
fi

tmp_file=$(mktemp)
grep -vxF "$SOURCE_LINE" "$GHOSTTY_CONF" | grep -vxF "$MARKER" >"$tmp_file" || true
mv "$tmp_file" "$GHOSTTY_CONF"

printf '\n%s\n%s\n' "$MARKER" "$SOURCE_LINE" >>"$GHOSTTY_CONF"

pkill -SIGUSR2 ghostty 2>/dev/null || true

printf 'Ensured Ghostty overlay is loaded from %s\n' "$GHOSTTY_CONF"
