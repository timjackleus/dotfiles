#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Code/dotfiles}"
SHELL_SOURCE="$DOTFILES_DIR/omarchy/shell/shell.toml"
SHELL_TARGET="$HOME/.config/omarchy/shell.toml"

mkdir -p "$HOME/.config/omarchy"

if [[ -e "$SHELL_TARGET" && ! -L "$SHELL_TARGET" ]]; then
  mv "$SHELL_TARGET" "$SHELL_TARGET.bak.$(date +%s)"
fi

ln -sfn "$SHELL_SOURCE" "$SHELL_TARGET"

printf 'Installed Omarchy shell settings: %s -> %s\n' "$SHELL_TARGET" "$SHELL_SOURCE"
