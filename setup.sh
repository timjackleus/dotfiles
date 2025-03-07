#!/usr/bin/env bash

# Colors for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}       Interactive Setup Script       ${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""

# Function to prompt user for yes/no
confirm() {
    read -p "$1 (y/n): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

# Function to run a setup script with proper output
run_setup() {
    local script=$1
    local name=$2
    
    echo -e "${YELLOW}Setting up $name...${NC}"
    if [ -f "$script" ]; then
        bash "$script"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ $name setup completed successfully${NC}"
        else
            echo -e "${RED}✗ $name setup failed${NC}"
        fi
    else
        echo -e "${RED}✗ Setup script not found: $script${NC}"
    fi
    echo ""
}

# Xcode CLI tools
if confirm "Install Xcode Command Line Tools?"; then
    echo -e "${YELLOW}Installing Xcode Command Line Tools...${NC}"
    xcode-select --install
    echo -e "${GREEN}✓ Xcode CLI tools installation initiated${NC}"
    echo "Note: You may need to follow the prompts in the dialog that appears"
    echo ""
fi

# Full Xcode
if confirm "Install full Xcode from the App Store?"; then
    echo -e "${YELLOW}Opening App Store to install Xcode...${NC}"
    open "macappstores://itunes.apple.com/app/id497799835"
    echo -e "${GREEN}✓ App Store opened for Xcode installation${NC}"
    echo "Please complete the installation in the App Store"
    echo ""
fi

# macOS defaults
if confirm "Configure macOS defaults?"; then
    run_setup "macos/setup.sh" "macOS defaults"
fi

# Homebrew
if confirm "Install Homebrew and packages?"; then
    if [ -f "homebrew/index.sh" ]; then
        run_setup "homebrew/index.sh" "Homebrew"
    else
        echo -e "${RED}✗ Homebrew setup script not found${NC}"
        echo ""
    fi
fi

# Fish shell
if confirm "Set up Fish shell?"; then
    run_setup "fish/setup.sh" "Fish shell"
fi

# Ghostty terminal
if confirm "Set up Ghostty terminal?"; then
    run_setup "ghostty/setup.sh" "Ghostty terminal"
fi

# Tmux
if confirm "Set up Tmux?"; then
    run_setup "tmux/setup.sh" "Tmux"
fi

# Neovim
if confirm "Set up Neovim?"; then
    run_setup "vim/setup.sh" "Neovim"
fi

# Keyboard layout
if confirm "Set up custom keyboard layout?"; then
    run_setup "keyboard/setup.sh" "Keyboard layout"
fi

# Hammerspoon
if confirm "Set up Hammerspoon?"; then
    run_setup "hammerspoon/setup.sh" "Hammerspoon"
fi

# Cursor editor
if confirm "Set up Cursor editor?"; then
    run_setup "cursor/setup.sh" "Cursor editor"
fi

# Yazi file manager
if confirm "Set up Yazi file manager?"; then
    run_setup "yazi/setup.sh" "Yazi file manager"
fi

# Karabiner
if confirm "Set up Karabiner?"; then
    run_setup "karabiner/setup.sh" "Karabiner"
fi

echo -e "${GREEN}Setup completed!${NC}"
echo "You may need to restart your computer for some changes to take effect."
