#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Code/dotfiles}"
XKB_SOURCE="$DOTFILES_DIR/omarchy/xkb/symbols/tim"
XKB_TARGET="$HOME/.config/xkb/symbols/tim"
HYPR_INPUT_SOURCE="$DOTFILES_DIR/omarchy/hypr/input.lua"
HYPR_INPUT_TARGET="$HOME/.config/hypr/input.lua"

link_file() {
  local source=$1
  local target=$2

  if [[ -L $target && $(readlink "$target") == "$source" ]]; then
    return
  fi

  if [[ -e $target || -L $target ]]; then
    local backup="$target.pre-dotfiles.bak.$(date +%s)"
    mv "$target" "$backup"
    printf 'Backed up existing config: %s\n' "$backup"
  fi

  ln -s "$source" "$target"
}

mkdir -p "$(dirname "$XKB_TARGET")" "$(dirname "$HYPR_INPUT_TARGET")"
link_file "$XKB_SOURCE" "$XKB_TARGET"
link_file "$HYPR_INPUT_SOURCE" "$HYPR_INPUT_TARGET"

printf 'Installed XKB layout: %s -> %s\n' "$XKB_TARGET" "$XKB_SOURCE"
printf 'Installed Hyprland input config: %s -> %s\n' "$HYPR_INPUT_TARGET" "$HYPR_INPUT_SOURCE"
