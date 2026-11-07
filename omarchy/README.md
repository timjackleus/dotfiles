# Omarchy Quattro

Linux-specific user overrides for Omarchy Quattro. Omarchy owns its packaged
defaults in `/usr/share/omarchy`; this directory owns the personal files linked
into `~/.config`.

## Setup

1. Find the internal keyboard ID:

```bash
sudo keyd monitor
```

1. Replace `REPLACE_WITH_KEYD_MONITOR_ID` in `omarchy/keyd/dell-internal.conf`.

Do not add the `k:` prefix unless tested. On the Dell XPS setup, matching only worked without `k:`.

1. Run setup:

```bash
./omarchy/setup.sh
```

Override repo path if needed:

```bash
DOTFILES_DIR=/path/to/dotfiles ./omarchy/setup.sh
```

The setup script installs Enpass in place of 1Password, the Omarchy shell settings, keyd config, Hyprland nightlight schedule, custom keyboard layout, Omarchy Neovim overlay, Omarchy Herdr config, and Omarchy Ghostty overlay.

## Bash shortcuts

Personal Bash shortcuts are linked from `omarchy/bash/aliases.bash` into
`~/.config/bash/aliases.bash` and loaded after Omarchy's defaults in `~/.bashrc`.
Setup preserves the existing Bash config and backs it up before adding the source line.

To install only these shortcuts:

```bash
bash omarchy/bash/setup.sh
source ~/.bashrc
```

## Password manager

Setup installs `enpass-bin` from the AUR before removing `1password` and
`1password-cli`. It also removes the external Chromium extension registration
created by Omarchy's 1Password installer, if present, and associates Enpass's
link schemes and card files with `enpass.desktop`.

To apply just the password-manager setup on an existing machine:

```bash
bash omarchy/enpass/setup.sh
```

The script is safe to rerun. Normal Omarchy updates upgrade installed packages
and leave the removed 1Password packages uninstalled. Avoid selecting 1Password
from Omarchy's installation menu or running `omarchy launch 1password`, which
offers to install it again. If it is explicitly reinstalled, rerun this script.

The Hyprland setup links the repository's password shortcut override, so
**Super + Shift + /** launches Enpass instead of 1Password.

In each browser, install the Enpass extension and remove any existing 1Password
extension. Enable browser integration in Enpass, and disable the browser's built-in
password saving/autofill if Enpass should handle it exclusively. Browser profiles
and existing password vault data are not modified by setup.

## Bar and menus

The shell uses a **15px** base size instead of the default 12px, making bar icons,
menus, and panels roughly 25% larger without changing display scaling or application
text. The theme-independent override is linked from the repository:

```text
omarchy/shell/shell.toml -> ~/.config/omarchy/shell.toml
```

To install just these settings, run:

```bash
bash omarchy/shell/setup.sh
```

Setup backs up an existing regular file before linking. Edit
`omarchy/shell/shell.toml` to adjust the size; Omarchy applies changes live.

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

`Ctrl+a`, then `a` opens a floating space picker backed by `fzf` and `jq`, ready to fuzzy-search space names immediately. Type to filter, use arrows or `Ctrl+j`/`Ctrl+k` to move, and Enter to select. Esc clears the search and returns to `j`/`k` navigation; `/` reopens search, and Esc again cancels. The current space is marked with `*` and selected initially. `Ctrl+a`, then `w` keeps the built-in sidebar navigator available, and `Ctrl+a`, then `g` searches spaces, tabs, and panes.

Setup registers `omarchy/herdr/` as the local `tim.spaces` plugin so the popup is titled **Spaces**, and also links `space-picker.sh` into `~/.config/herdr/`. The picker shows Name, Status, and Tabs columns; the name column reserves at least 40 characters and grows for longer names. This changes only space selection: Herdr currently has no supported setting to remove the Spaces section while keeping Agents visible.

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

### Display configuration

`omarchy/hypr/setup.sh` detects the Dell XPS 13 9380 using its DMI vendor/model
and symlinks `omarchy/hypr/monitors.lua` to `~/.config/hypr/monitors.lua`, backing
up any existing file first.
It applies **2.5×** scaling to the internal `eDP-1` 4K panel at
**3840×2160, 60 Hz**, providing an effective **1536×864** workspace.
The Dell U2723QE external display uses **1.5×** scaling at **3840×2160, 60 Hz**.
The config is only linked on this laptop model. Existing global GTK scaling
is preserved; it is separate from each monitor's compositor scale.

The literal, single-line connector rule is intentional: Omarchy's lid/wake
handler parses `monitors.lua` directly without following Lua module imports.
Loading the rule here also lets Omarchy's later clamshell toggles disable the
internal panel while docked with the lid closed.

The override takes precedence over the Omarchy scale menu on config reload.
Edit `omarchy/hypr/monitors.lua` to change persistent monitor settings. The Display
panel's managed section can also be rewritten by that panel. Validate changes
with `hyprctl reload config-only` and `hyprctl configerrors`; this validates the
config without cycling displays. Runtime mode/scale changes need to be applied
separately or at the next login.

Before an Omarchy refresh, back up the file and move the symlink out of the way:
refresh may otherwise overwrite the repository source through the link.
Reconcile the refreshed settings, then rerun `bash omarchy/hypr/setup.sh` to
restore the link.

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

Enpass installation and 1Password removal are handled by setup; see
[Password manager](#password-manager).

## Moonlander flashing with Oryx

Oryx needs USB device permissions to flash the Moonlander from a Chromium-based
browser on Omarchy. This is a one-time setup per computer; it does not change
keyboard mappings or enable the laptop-specific keyd configuration on the Moonlander.

Create the udev rules file:

```bash
sudoedit /etc/udev/rules.d/70-zsa.rules
```

Paste these rules:

```udev
# Moonlander: Oryx web flashing and live training
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3297", TAG+="uaccess"

# Moonlander: STM32 bootloader for firmware flashing
SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="df11", TAG+="uaccess"
```

The first rule grants access to ZSA's normal keyboard interface. The second
grants access to the STM32 bootloader used when flashing the Moonlander.
`uaccess` gives the active local desktop user access without creating a
`plugdev` group. Keep the `70-` filename prefix so the rules run before
systemd's `73-seat-late.rules`, which applies those permissions.

Validate the file and reload the rules:

```bash
udevadm verify /etc/udev/rules.d/70-zsa.rules
sudo udevadm control --reload-rules
```

Unplug and reconnect the Moonlander, refresh Oryx in the browser, and select the
keyboard when prompted to flash. Follow Oryx's instructions to enter bootloader
mode if requested. No reboot is required.

These rules were tested with Oryx on Omarchy. ZSA's broader Linux instructions
also cover other keyboard models, legacy firmware, and Snap browsers; those
extra rules and Snap commands are not needed for this setup.

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
