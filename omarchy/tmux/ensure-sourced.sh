#!/usr/bin/env bash
set -euo pipefail

TMUX_CONF="${HOME}/.config/tmux/tmux.conf"
OMARCHY_TMUX_CONF="${HOME}/.local/share/omarchy/config/tmux/tmux.conf"
SOURCE_LINE='source-file -q ~/.config/tmux/tim.conf'
MARKER='# Tim dotfiles tmux overlay'

mkdir -p "$(dirname "$TMUX_CONF")"

if [[ ! -f "$TMUX_CONF" ]]; then
  if [[ -f "$OMARCHY_TMUX_CONF" ]]; then
    cp "$OMARCHY_TMUX_CONF" "$TMUX_CONF"
  else
    touch "$TMUX_CONF"
  fi
fi

tmp_file=$(mktemp)
grep -vxF "$SOURCE_LINE" "$TMUX_CONF" | grep -vxF "$MARKER" >"$tmp_file" || true
mv "$tmp_file" "$TMUX_CONF"

printf '\n%s\n%s\n' "$MARKER" "$SOURCE_LINE" >>"$TMUX_CONF"

if pgrep -x tmux >/dev/null 2>&1; then
  tmux source-file "$TMUX_CONF"
fi

printf 'Ensured tmux overlay is sourced from %s\n' "$TMUX_CONF"
