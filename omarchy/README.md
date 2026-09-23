# Omarchy Quattro

Linux-specific user overrides for Omarchy Quattro. Omarchy owns its packaged
defaults in `/usr/share/omarchy`; this directory owns the personal files linked
into `~/.config`.

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

The setup script installs the keyd config, Hyprland nightlight schedule, custom keyboard layout, Omarchy Neovim overlay, Omarchy Herdr config, and Omarchy Ghostty overlay.

## Ghostty

The Omarchy setup keeps Omarchy's base Ghostty config at `~/.config/ghostty/config`, then loads a repo-owned personal overlay:

```text
omarchy/ghostty/tim.conf -> ~/.config/ghostty/tim.conf
```

The overlay is loaded after Omarchy's defaults, so it can change the font size without freezing Omarchy's dynamic theme integration or other defaults. When migrating an older config, setup backs it up and restores the Quattro base first. A post-update hook restores the include if an Omarchy update replaces the base config.

## Herdr

The Omarchy setup uses a Linux-specific Herdr config:

```text
omarchy/herdr/config.toml -> ~/.config/herdr/config.toml
```

It keeps the shared keybindings from `herdr/config.toml`, which remains the macOS config, while disabling automatic appearance switching. The `terminal` theme follows Ghostty's active Omarchy palette instead of choosing a separate light or dark Herdr theme. Herdr replaces the previous custom Tmux setup on this machine.

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
~/.local/state/omarchy/current/theme/neovim.lua
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

### Laptop display scaling

`omarchy/hypr/setup.sh` detects the Dell XPS 13 9380 using its DMI vendor/model
and installs `monitors-local.lua` as a managed block in `~/.config/hypr/monitors.lua`.
It applies **2.5×** scaling to the internal `eDP-1` 4K panel at
**3840×2160, 60 Hz**, providing an effective **1536×864** workspace.
The block is only installed on this laptop model; external displays retain
their own settings or the general scale selected in Omarchy's menu.

The literal, single-line connector rule is intentional: Omarchy's lid/wake
handler parses `monitors.lua` directly without following Lua module imports.
Loading the rule here also lets Omarchy's later clamshell toggles disable the
internal panel while docked with the lid closed.

The override takes precedence over the Omarchy scale menu on config reload.
To change the laptop's persistent scale, edit `omarchy/hypr/monitors-local.lua`
and rerun `bash omarchy/hypr/setup.sh`, then `hyprctl reload`. Rerun setup after
a refresh replaces `monitors.lua` to restore the managed block.

### Keyboard and nightlight

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

`omarchy/xkb/setup.sh` also links the repo-owned Hyprland input overrides:

```text
omarchy/hypr/input.lua -> ~/.config/hypr/input.lua
```

The Caps layer lives in `omarchy/keyd/dell-internal.conf`.

Keyd also maps `/` as a tap/hold key:

```text
Tap /  -> /
Hold / -> Right Ctrl
```

The physical Right Ctrl key is mapped to Super.

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

`omarchy/hypr/setup.sh` also links the Lua autostart override that starts `hyprsunset` on login:

```text
omarchy/hypr/autostart.lua -> ~/.config/hypr/autostart.lua
```

```lua
o.launch_on_start("hyprsunset")
```

Manual toggle remains available with `Super + Ctrl + N` or:

```bash
omarchy toggle nightlight
```

The Lua input override disables Omarchy's default Compose-on-Caps option so it does not conflict with keyd:

```lua
kb_options = ""
```

It also preserves natural touchpad scrolling and the custom terminal scroll speeds.

Password manager binding in `~/.config/hypr/bindings.lua`:

```lua
hl.unbind("SUPER + SHIFT + SLASH")
o.bind("SUPER + SHIFT + SLASH", "Passwords", { launch = "enpass" })
```

This replaces Omarchy's default 1Password binding on the same key.

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

- Do not edit `/usr/share/omarchy`; it is package-owned and replaced by updates.
- Before running `omarchy refresh`, `omarchy reinstall`, or
  `omarchy-nvim-refresh`, check whether the affected `~/.config` files are
  symlinks. A refresh may follow a symlink and overwrite its repository source.
- Keyboard IDs can vary between computers.
- If Caps Lock behaves normally, rerun `sudo keyd monitor` and update `[ids]`.
