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

## Hyprland

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
