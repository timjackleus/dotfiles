#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Code/dotfiles}"
HERDR_SOURCE="$DOTFILES_DIR/omarchy/herdr/config.toml"
HERDR_TARGET="$HOME/.config/herdr/config.toml"

if [[ ! -L $HERDR_TARGET || $(readlink "$HERDR_TARGET") != "$HERDR_SOURCE" ]]; then
  if [[ -e $HERDR_TARGET || -L $HERDR_TARGET ]]; then
    backup="$HERDR_TARGET.pre-dotfiles.bak.$(date +%s)"
    mv "$HERDR_TARGET" "$backup"
    printf 'Backed up existing config: %s\n' "$backup"
  fi

  mkdir -p "$HOME/.config/herdr"
  ln -s "$HERDR_SOURCE" "$HERDR_TARGET"
fi

if command -v herdr >/dev/null 2>&1 && pgrep -x herdr >/dev/null 2>&1; then
  herdr server reload-config
fi

printf 'Installed Omarchy Herdr config: %s -> %s\n' "$HERDR_TARGET" "$HERDR_SOURCE"
