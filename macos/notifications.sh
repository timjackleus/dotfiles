#!/bin/bash

echo "Configuring notification settings for macOS..."

# Modern approach for Focus mode (replaced Do Not Disturb in newer macOS versions)
# Note: Full Focus mode configuration requires additional steps through System Settings UI
# This sets some basic preferences via defaults

# Reduce banner display time to minimum
defaults write com.apple.notificationcenterui bannerTime 2

# Note: Starting with macOS Ventura, notification settings are stored differently
# and many of the old defaults commands no longer work as expected.
# The following attempts to modify notification settings for common Apple apps,
# but full control requires using System Settings UI.

# List of common Apple apps to configure
APPLE_APPS=(
  "com.apple.AppStore"
  "com.apple.Calendar"
  "com.apple.AddressBook"
  "com.apple.FaceTime"
  "com.apple.findmy"
  "com.apple.Home"
  "com.apple.mail"
  "com.apple.MobileSMS"
  "com.apple.Music"
  "com.apple.news"
  "com.apple.Notes"
  "com.apple.Photos"
  "com.apple.podcasts"
  "com.apple.reminders"
  "com.apple.Safari"
  "com.apple.shortcuts"
  "com.apple.stocks"
  "com.apple.tv"
  "com.apple.voicememos"
)

# Attempt to modify notification settings
# Note: This approach may not work on all macOS versions
for app in "${APPLE_APPS[@]}"; do
  # Try to reduce notification prominence where possible
  defaults write "$app" NSUserNotificationAlertStyle -int 1 2>/dev/null || true
done

# Configure notification center preferences where possible
defaults write com.apple.ncprefs.plist showInLockScreen -bool false

# Restart Notification Center to apply changes
# Note: Some changes may require a logout/login or restart to fully apply
killall NotificationCenter 2>/dev/null || true
killall usernoted 2>/dev/null || true

echo "Notification settings configured! Some settings may require manual adjustment in System Settings > Notifications."
echo "For complete control over notifications, use System Settings > Notifications & Focus."
