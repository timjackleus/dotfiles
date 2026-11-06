#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Code/dotfiles}"
GHOSTTY_SOURCE="$DOTFILES_DIR/omarchy/ghostty/tim.conf"
GHOSTTY_TARGET="$HOME/.config/ghostty/tim.conf"
HOOK_SOURCE="$DOTFILES_DIR/omarchy/hooks/post-update.d/ensure-ghostty-sourced"
HOOK_TARGET="$HOME/.config/omarchy/hooks/post-update.d/ensure-ghostty-sourced"

mkdir -p "$HOME/.config/ghostty" "$HOME/.config/omarchy/hooks/post-update.d"
ln -sfn "$GHOSTTY_SOURCE" "$GHOSTTY_TARGET"
ln -sfn "$HOOK_SOURCE" "$HOOK_TARGET"

bash "$DOTFILES_DIR/omarchy/ghostty/ensure-sourced.sh"

printf 'Installed Omarchy Ghostty overlay: %s -> %s\n' "$GHOSTTY_TARGET" "$GHOSTTY_SOURCE"
printf 'Installed Omarchy post-update hook: %s -> %s\n' "$HOOK_TARGET" "$HOOK_SOURCE"
