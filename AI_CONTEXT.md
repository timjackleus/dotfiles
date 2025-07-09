# Dotfiles Project Overview

This is Tim's comprehensive macOS development environment dotfiles repository.

## Key Components
- **Fish Shell**: Primary shell with Rose Pine theme, custom functions (`glb`, `killport`, `yy`), Starship prompt, nvm integration
- **Neovim**: LazyVim-based setup with extensive language support (TypeScript, Go, PHP, Python), Mason-managed LSPs
- **Ghostty Terminal**: Modern terminal with VictorMono Nerd Font, Rose Pine theme, auto dark/light switching
- **Tmux**: Advanced multiplexer with vim-style navigation, Rose Pine theme, system info status bar
- **Homebrew**: Package management for CLI tools (`brew.sh`) and applications (`brew-cask.sh`)
- **macOS Tweaks**: System optimizations, privacy settings, Finder enhancements, Dock customization

## Setup
- Main setup: `./setup.sh` (interactive guided installation)
- Individual components have their own setup scripts in respective directories
- Requires Xcode Command Line Tools, optionally full Xcode

## Architecture
- **Modular Design**: Each component (fish, vim, homebrew, etc.) has its own directory and setup script
- **Interactive Installation**: Color-coded prompts guide users through setup process
- **Theme Consistency**: Rose Pine color scheme unified across all applications
- **Vim-Centric Workflow**: Vim keybindings and philosophy throughout the system

## Key Files
- `fish/config.fish`: Main shell configuration with aliases and functions
- `fish/starship.toml`: Prompt configuration
- `vim/`: Neovim configuration (Lua-based, LazyVim)
- `homebrew/brew.sh`: CLI tools and utilities
- `homebrew/brew-cask.sh`: GUI applications and fonts
- `macos/main.sh`: System tweaks and optimizations

## Development Workflow
- Performance-focused: Minimal animations, optimized settings
- Developer productivity tools for web development, Go, and other languages
- Terminal-based workflow with file manager (Yazi), multiplexer (Tmux), and editor (Neovim)