#!/bin/bash

echo "Disabling notifications for Apple applications..."

# Modern approach to disable notifications using defaults command
# Turn on Do Not Disturb
defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb -boolean true

# Set Do Not Disturb end date far in the future
defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturbDate -date "`date -u +\"%Y-%m-%d %H:%M:%S +0000\" -d \"+9999 years\"`"

# Disable notification center completely
defaults write com.apple.notificationcenterui bannerTime 0

# Disable notification alerts for common Apple apps
APPLE_APPS=(
  "com.apple.AppStore"
  "com.apple.iCal"
  "com.apple.Calendar"
  "com.apple.AddressBook"
  "com.apple.FaceTime"
  "com.apple.findmy"
  "com.apple.GameCenter"
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

for app in "${APPLE_APPS[@]}"; do
  # Disable all notification types (badges, sounds, banners)
  defaults write com.apple.ncprefs apps -array-add "{\"bundle-id\" = \"$app\"; \"enabled\" = 0;}"
done

# Restart Notification Center to apply changes
killall NotificationCenter 2>/dev/null || true
killall usernoted 2>/dev/null || true

echo "Notifications disabled for Apple applications!"
