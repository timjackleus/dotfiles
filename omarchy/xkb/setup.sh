#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Code/dotfiles}"
XKB_SOURCE="$DOTFILES_DIR/omarchy/xkb/symbols/tim"
XKB_TARGET="$HOME/.config/xkb/symbols/tim"
HYPR_INPUT="$HOME/.config/hypr/input.conf"

mkdir -p "$(dirname "$XKB_TARGET")" "$(dirname "$HYPR_INPUT")"
ln -sfn "$XKB_SOURCE" "$XKB_TARGET"

if [[ ! -f "$HYPR_INPUT" ]]; then
  cat >"$HYPR_INPUT" <<'EOF'
input {
  kb_layout = tim
}
EOF
elif grep -qE '^\s*kb_layout\s*=' "$HYPR_INPUT"; then
  perl -0pi -e 's/^\s*kb_layout\s*=.*$/  kb_layout = tim/m' "$HYPR_INPUT"
else
  perl -0pi -e 's/input \{\n/input {\n  kb_layout = tim\n/' "$HYPR_INPUT"
fi

printf 'Installed XKB layout: %s -> %s\n' "$XKB_TARGET" "$XKB_SOURCE"
printf 'Configured Hyprland keyboard layout: kb_layout = tim\n'
