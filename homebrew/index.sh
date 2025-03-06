#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# upgrade any already-installed formulae
brew upgrade

# Run all installations
"$SCRIPT_DIR/brew.sh"
"$SCRIPT_DIR/brew-cask.sh"

# remove outdated versions from the cellar
brew cleanup
