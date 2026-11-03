#!/usr/bin/env bash
set -euo pipefail

# Install the replacement successfully before removing the stock manager.
omarchy pkg aur add enpass-bin
omarchy pkg drop 1password 1password-cli

# Omarchy's 1Password installer can leave a Chromium extension registration
# outside the packages. Remove it so Chromium stops offering the extension.
ONEPASSWORD_EXTENSION="/usr/share/chromium/extensions/aeblfdkhhhdcdjpifhhbdiojplfjncoa.json"
if [[ -e "$ONEPASSWORD_EXTENSION" ]]; then
  sudo rm -- "$ONEPASSWORD_EXTENSION"
fi

for scheme in enpassauth enpasscard enpassstart enpass cloudkit-7adb8cc6tf.in.sinew.walletx enpassshare; do
  xdg-mime default enpass.desktop "x-scheme-handler/$scheme"
done
xdg-mime default enpass.desktop application/enpasscard

printf 'Installed Enpass and removed the 1Password desktop app and CLI.\n'
printf 'Enable browser integration in Enpass and install the Enpass browser extension.\n'
printf 'Remove any existing 1Password browser extension in each browser profile.\n'
