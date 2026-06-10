#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Code/dotfiles}"
TMUX_SOURCE="$DOTFILES_DIR/omarchy/tmux/tim.conf"
TMUX_TARGET="$HOME/.config/tmux/tim.conf"
HOOK_SOURCE="$DOTFILES_DIR/omarchy/hooks/post-update.d/ensure-tmux-sourced"
HOOK_TARGET="$HOME/.config/omarchy/hooks/post-update.d/ensure-tmux-sourced"

install_packages() {
  local packages=(tmux git bc wl-clipboard)

  if command -v omarchy >/dev/null 2>&1; then
    omarchy pkg add "${packages[@]}"
  elif command -v omarchy-pkg-add >/dev/null 2>&1; then
    omarchy-pkg-add "${packages[@]}"
  else
    sudo pacman -S --needed "${packages[@]}"
  fi
}

install_packages

mkdir -p "$HOME/.config/tmux" "$HOME/.config/omarchy/hooks/post-update.d" "$HOME/.tmux/plugins"
ln -sfn "$TMUX_SOURCE" "$TMUX_TARGET"
ln -sfn "$HOOK_SOURCE" "$HOOK_TARGET"

if [[ ! -d "$HOME/.tmux/plugins/tpm/.git" ]]; then
  rm -rf "$HOME/.tmux/plugins/tpm"
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

bash "$DOTFILES_DIR/omarchy/tmux/ensure-sourced.sh"

printf 'Installed Omarchy tmux config: %s -> %s\n' "$TMUX_TARGET" "$TMUX_SOURCE"
printf 'Installed Omarchy post-update hook: %s -> %s\n' "$HOOK_TARGET" "$HOOK_SOURCE"
