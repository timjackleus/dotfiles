# Tim's dotfiles

A collection of configuration files and setup scripts for macOS development environment.

## Quick Start

Run the interactive setup script to configure your environment:

```bash
./setup.sh
```

The script will guide you through setting up:

- Xcode Command Line Tools
- Full Xcode (optional)
- macOS system preferences
- Homebrew and essential packages
- Fish shell
- Ghostty terminal
- Tmux
- Neovim (based on [LazyVim](https://www.lazyvim.org/))
- Custom keyboard layout
- Hammerspoon
- Cursor editor
- Yazi file manager
- Karabiner Elements

## Manual Installation

If you prefer to set up components individually, each directory contains its own setup script:

```bash
./macos/setup.sh      # Configure macOS defaults
./homebrew/index.sh   # Install Homebrew and packages
./fish/setup.sh       # Set up Fish shell
# etc.
```

## Git Setup

For Git configuration:

1. Create a `.extra` file (not included in repo) for personal credentials
2. Set up SSH keys following [GitHub's guide](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

## Troubleshooting

If Xcode CLI tools installation fails, manually download from:
https://developer.apple.com/download/more/
