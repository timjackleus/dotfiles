# Omarchy

Linux-specific dotfiles for Omarchy.

## Setup

1. Find the internal keyboard ID:

```bash
sudo keyd monitor
```

2. Replace `REPLACE_WITH_KEYD_MONITOR_ID` in `omarchy/keyd/dell-internal.conf`.

Do not add the `k:` prefix unless tested. On the Dell XPS setup, matching only worked without `k:`.

3. Run setup:

```bash
./omarchy/setup.sh
```

Override repo path if needed:

```bash
DOTFILES_DIR=/path/to/dotfiles ./omarchy/setup.sh
```

The setup script installs the keyd config, Hyprland nightlight schedule, custom keyboard layout, Omarchy tmux overlay, and Omarchy Neovim overlay.

## Tmux

The Omarchy tmux setup keeps Omarchy's base config at `~/.config/tmux/tmux.conf`, then sources a repo-owned personal layer from the end of that file:

```tmux
source-file -q ~/.config/tmux/tim.conf
```

`~/.config/tmux/tim.conf` is symlinked to:

```text
omarchy/tmux/tim.conf
```

This overlay intentionally owns the tmux statusbar, prefix, pane/window bindings, Vim-aware pane navigation, and tmux plugins. Because it is sourced after Omarchy's default config, Tim's statusbar overrides Omarchy's tmux statusbar.

If `omarchy refresh tmux` or an Omarchy update replaces `~/.config/tmux/tmux.conf`, rerun:

```bash
./omarchy/tmux/setup.sh
```

The setup also installs a post-update hook at:

```text
~/.config/omarchy/hooks/post-update.d/ensure-tmux-sourced
```

That hook re-adds the source line after normal Omarchy updates.

Tmux plugins are managed by TPM. After the first setup, press `Ctrl-a I` inside tmux to install plugin dependencies.

## Neovim

The Omarchy Neovim setup keeps Omarchy's LazyVim base config and theme integration, then symlinks Tim-specific options, keymaps, plugins, snippets, and LazyVim extras into the existing config.

Personal files live in:

```text
omarchy/nvim/
```

They are symlinked into:

```text
~/.config/nvim/
```

Omarchy still owns theme integration through:

```text
~/.config/nvim/lua/plugins/theme.lua
```

That file should remain a symlink to:

```text
~/.config/omarchy/current/theme/neovim.lua
```

The overlay intentionally does not include the macOS `colors.lua` Rose Pine switcher or theme-specific Neo-tree highlight overrides.

If `omarchy-nvim-setup`, `omarchy reinstall`, or an Omarchy update replaces `~/.config/nvim`, rerun:

```bash
./omarchy/nvim/setup.sh
```

The setup also installs a post-update hook at:

```text
~/.config/omarchy/hooks/post-update.d/ensure-nvim-symlinks
```

That hook re-adds the symlinks after normal Omarchy updates.

## Hyprland

Custom keyboard layout is configured through XKB and keyd:

```text
omarchy/xkb/symbols/tim -> ~/.config/xkb/symbols/tim
```

The XKB layout keeps US keys and adds Swedish characters on the internal Right Alt level:

```text
Right Alt + [       -> å
Right Alt + ;       -> ö
Right Alt + '       -> ä
Shift + Right Alt + [ -> Å
Shift + Right Alt + ; -> Ö
Shift + Right Alt + ' -> Ä
```

Keyd maps the Caps hold layer to those Right Alt combinations, while preserving homerow navigation:

```text
Tap Caps       -> Escape
Hold Caps + h  -> Left
Hold Caps + j  -> Down
Hold Caps + k  -> Up
Hold Caps + l  -> Right
Hold Caps + [  -> å
Hold Caps + ;  -> ö
Hold Caps + '  -> ä
```

`omarchy/xkb/setup.sh` also updates `~/.config/hypr/input.conf`:

```conf
kb_layout = tim
```

The Caps layer lives in `omarchy/keyd/dell-internal.conf`.

Nightlight is configured with `hyprsunset`:

```text
omarchy/hypr/hyprsunset.conf -> ~/.config/hypr/hyprsunset.conf
```

The schedule warms the display from 20:00 until 06:00:

```conf
profile {
    time = 06:00
    identity = true
}

profile {
    time = 20:00
    temperature = 4000
}
```

`omarchy/hypr/setup.sh` also ensures `~/.config/hypr/autostart.conf` starts `hyprsunset` on login:

```conf
exec-once = uwsm-app -- hyprsunset
```

Manual toggle remains available with `Super + Ctrl + N` or:

```bash
omarchy toggle nightlight
```

Edit `~/.config/hypr/input.conf`:

```conf
kb_options =

touchpad {
  natural_scroll = true
}
```

Do not only comment out `kb_options`.

Password manager binding in `~/.config/hypr/bindings.conf`:

```conf
bindd = SUPER SHIFT, SLASH, Passwords, exec, uwsm-app -- enpass
```

Install Enpass with `Install > AUR > enpass-bin`.

## Useful Commands

Validate:

```bash
sudo keyd check /etc/keyd/dell-internal.conf
```

Reload:

```bash
sudo keyd reload
```

Logs:

```bash
sudo journalctl -eu keyd
```

Emergency stop:

```text
Backspace + Escape + Enter
```

## Notes

- Keyboard IDs can vary between computers.
- If Caps Lock behaves normally, rerun `sudo keyd monitor` and update `[ids]`.
