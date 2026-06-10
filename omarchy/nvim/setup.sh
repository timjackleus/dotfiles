#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Code/dotfiles}"
SOURCE_DIR="$DOTFILES_DIR/omarchy/nvim"
TARGET_DIR="$HOME/.config/nvim"
HOOK_SOURCE="$DOTFILES_DIR/omarchy/hooks/post-update.d/ensure-nvim-symlinks"
HOOK_TARGET="$HOME/.config/omarchy/hooks/post-update.d/ensure-nvim-symlinks"

if [[ ! -d "$TARGET_DIR" ]]; then
  printf 'Neovim config not found at %s. Run omarchy-nvim-setup first.\n' "$TARGET_DIR" >&2
  exit 1
fi

link_file() {
  local source=$1
  local target=$2

  mkdir -p "$(dirname "$target")"
  ln -sfn "$source" "$target"
}

link_file "$SOURCE_DIR/lazyvim.json" "$TARGET_DIR/lazyvim.json"
link_file "$SOURCE_DIR/stylua.toml" "$TARGET_DIR/stylua.toml"
link_file "$SOURCE_DIR/.neoconf.json" "$TARGET_DIR/.neoconf.json"

for file in "$SOURCE_DIR"/lua/config/*.lua; do
  link_file "$file" "$TARGET_DIR/lua/config/$(basename "$file")"
done

for file in "$SOURCE_DIR"/lua/plugins/*.lua; do
  link_file "$file" "$TARGET_DIR/lua/plugins/$(basename "$file")"
done

link_file "$SOURCE_DIR/snippets" "$TARGET_DIR/snippets"

mkdir -p "$HOME/.config/omarchy/hooks/post-update.d"
link_file "$HOOK_SOURCE" "$HOOK_TARGET"

printf 'Installed Omarchy Neovim overlay from %s\n' "$SOURCE_DIR"
printf 'Preserved Omarchy theme integration at %s/lua/plugins/theme.lua\n' "$TARGET_DIR"
printf 'Installed Omarchy post-update hook: %s -> %s\n' "$HOOK_TARGET" "$HOOK_SOURCE"
