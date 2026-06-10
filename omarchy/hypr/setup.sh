#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Code/dotfiles}"
HYPR_CONFIG_DIR="$HOME/.config/hypr"
HYPRSUNSET_SOURCE="$DOTFILES_DIR/omarchy/hypr/hyprsunset.conf"
HYPRSUNSET_TARGET="$HYPR_CONFIG_DIR/hyprsunset.conf"
AUTOSTART_TARGET="$HYPR_CONFIG_DIR/autostart.conf"
HYPRSUNSET_AUTOSTART='exec-once = uwsm-app -- hyprsunset'

if ! command -v hyprsunset >/dev/null 2>&1; then
  if command -v omarchy >/dev/null 2>&1; then
    omarchy pkg add hyprsunset
  elif command -v omarchy-pkg-add >/dev/null 2>&1; then
    omarchy-pkg-add hyprsunset
  else
    sudo pacman -S --needed hyprsunset
  fi
fi

mkdir -p "$HYPR_CONFIG_DIR"
ln -sfn "$HYPRSUNSET_SOURCE" "$HYPRSUNSET_TARGET"
touch "$AUTOSTART_TARGET"

if ! grep -qxF "$HYPRSUNSET_AUTOSTART" "$AUTOSTART_TARGET"; then
  printf '\n# Nightlight schedule\n%s\n' "$HYPRSUNSET_AUTOSTART" >>"$AUTOSTART_TARGET"
fi

if pgrep -x hyprsunset >/dev/null 2>&1; then
  pkill -x hyprsunset
fi

setsid uwsm-app -- hyprsunset >/dev/null 2>&1 &

printf 'Installed hyprsunset config: %s -> %s\n' "$HYPRSUNSET_TARGET" "$HYPRSUNSET_SOURCE"
printf 'Ensured Hyprland autostart contains: %s\n' "$HYPRSUNSET_AUTOSTART"
