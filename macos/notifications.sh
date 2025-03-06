#!/bin/bash

echo "Disabling notifications for Apple applications..."

# Create the com.apple.ncprefs.plist file with all applications disabled
cat <<EOF > ~/Library/Preferences/com.apple.ncprefs.plist
{
  "apps" = (
    { "bundle-id" = "com.apple.AppStore"; "flags" = 0; },
    { "bundle-id" = "com.apple.iCal"; "flags" = 0; },
    { "bundle-id" = "com.apple.AddressBook"; "flags" = 0; },
    { "bundle-id" = "com.apple.FaceTime"; "flags" = 0; },
    { "bundle-id" = "com.apple.findmy"; "flags" = 0; },
    { "bundle-id" = "com.apple.GameCenter"; "flags" = 0; },
    { "bundle-id" = "com.apple.Home"; "flags" = 0; },
    { "bundle-id" = "com.apple.mail"; "flags" = 0; },
    { "bundle-id" = "com.apple.MobileSMS"; "flags" = 0; },
    { "bundle-id" = "com.apple.Music"; "flags" = 0; },
    { "bundle-id" = "com.apple.news"; "flags" = 0; },
    { "bundle-id" = "com.apple.Notes"; "flags" = 0; },
    { "bundle-id" = "com.apple.Photos"; "flags" = 0; },
    { "bundle-id" = "com.apple.podcasts"; "flags" = 0; },
    { "bundle-id" = "com.apple.reminders"; "flags" = 0; },
    { "bundle-id" = "com.apple.Safari"; "flags" = 0; },
    { "bundle-id" = "com.apple.shortcuts"; "flags" = 0; },
    { "bundle-id" = "com.apple.stocks"; "flags" = 0; },
    { "bundle-id" = "com.apple.tv"; "flags" = 0; },
    { "bundle-id" = "com.apple.voicememos"; "flags" = 0; }
  );
}
EOF

# Kill NotificationCenter to apply changes
killall NotificationCenter

echo "Notifications disabled for Apple applications!"
