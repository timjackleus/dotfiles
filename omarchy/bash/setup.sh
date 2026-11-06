#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Code/dotfiles}"
BASH_SOURCE_FILE="$DOTFILES_DIR/omarchy/bash/aliases.bash"
BASH_TARGET="$HOME/.config/bash/aliases.bash"
BASHRC="$HOME/.bashrc"
SOURCE_LINE='[[ -r "$HOME/.config/bash/aliases.bash" ]] && source "$HOME/.config/bash/aliases.bash"'

mkdir -p "$HOME/.config/bash"

if [[ -e "$BASH_TARGET" && ! -L "$BASH_TARGET" ]]; then
  mv "$BASH_TARGET" "$BASH_TARGET.bak.$(date +%s)"
fi
ln -sfn "$BASH_SOURCE_FILE" "$BASH_TARGET"

if ! grep -qxF "$SOURCE_LINE" "$BASHRC"; then
  cp -p "$BASHRC" "$BASHRC.bak.$(date +%s)"
  printf '\n# Personal Bash shortcuts from dotfiles.\n%s\n' "$SOURCE_LINE" >> "$BASHRC"
fi

printf 'Installed Bash shortcuts: %s -> %s\n' "$BASH_TARGET" "$BASH_SOURCE_FILE"
