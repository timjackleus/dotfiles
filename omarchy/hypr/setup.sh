#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Code/dotfiles}"
HYPR_CONFIG_DIR="$HOME/.config/hypr"
HYPRSUNSET_SOURCE="$DOTFILES_DIR/omarchy/hypr/hyprsunset.conf"
HYPRSUNSET_TARGET="$HYPR_CONFIG_DIR/hyprsunset.conf"
AUTOSTART_SOURCE="$DOTFILES_DIR/omarchy/hypr/autostart.lua"
AUTOSTART_TARGET="$HYPR_CONFIG_DIR/autostart.lua"
BINDINGS_SOURCE="$DOTFILES_DIR/omarchy/hypr/bindings.lua"
BINDINGS_TARGET="$HYPR_CONFIG_DIR/bindings.lua"
MONITORS_SOURCE="$DOTFILES_DIR/omarchy/hypr/monitors.lua"
MONITORS_TARGET="$HYPR_CONFIG_DIR/monitors.lua"
HYPRLAND_TARGET="$HYPR_CONFIG_DIR/hyprland.lua"

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

if ! command -v hyprsunset >/dev/null 2>&1; then
  if command -v omarchy >/dev/null 2>&1; then
    omarchy pkg add hyprsunset
  else
    sudo pacman -S --needed hyprsunset
  fi
fi

mkdir -p "$HYPR_CONFIG_DIR"
link_file "$HYPRSUNSET_SOURCE" "$HYPRSUNSET_TARGET"
link_file "$AUTOSTART_SOURCE" "$AUTOSTART_TARGET"
link_file "$BINDINGS_SOURCE" "$BINDINGS_TARGET"
# Migrate the old late-loaded override. Monitor rules must precede Omarchy's
# toggles so closing the lid while docked can still disable the internal panel.
if grep -Fxq 'require("hypr.monitors-local")' "$HYPRLAND_TARGET"; then
  cp -p "$HYPRLAND_TARGET" "$HYPRLAND_TARGET.pre-dotfiles.bak.$(date +%s)"
  sed -i '/^-- Dotfiles hardware-specific display settings\.$/d; /^require("hypr\.monitors-local")$/d' "$HYPRLAND_TARGET"
fi

# Link the hardware-specific config only on the matching laptop. Keep the
# literal connector rule in monitors.lua for Omarchy's lid/wake handler.
if [[ -r /sys/class/dmi/id/sys_vendor && -r /sys/class/dmi/id/product_name ]] &&
  [[ $(</sys/class/dmi/id/sys_vendor) == 'Dell Inc.' && $(</sys/class/dmi/id/product_name) == 'XPS 13 9380' ]]; then
  link_file "$MONITORS_SOURCE" "$MONITORS_TARGET"
  # Remove only the obsolete symlink installed by earlier setup versions.
  if [[ -L $HYPR_CONFIG_DIR/monitors-local.lua ]] &&
    [[ $(readlink "$HYPR_CONFIG_DIR/monitors-local.lua") == "$DOTFILES_DIR/omarchy/hypr/monitors-local.lua" ]]; then
    unlink "$HYPR_CONFIG_DIR/monitors-local.lua"
  fi
  printf 'Installed monitor config: %s -> %s\n' "$MONITORS_TARGET" "$MONITORS_SOURCE"
fi

if command -v omarchy >/dev/null 2>&1; then
  omarchy restart hyprsunset
else
  pkill -x hyprsunset 2>/dev/null || true
  setsid uwsm-app -- hyprsunset >/dev/null 2>&1 &
fi

printf 'Installed hyprsunset config: %s -> %s\n' "$HYPRSUNSET_TARGET" "$HYPRSUNSET_SOURCE"
printf 'Installed Hyprland autostart config: %s -> %s\n' "$AUTOSTART_TARGET" "$AUTOSTART_SOURCE"
printf 'Installed Hyprland bindings config: %s -> %s\n' "$BINDINGS_TARGET" "$BINDINGS_SOURCE"
