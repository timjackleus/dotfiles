# NVM Setup Documentation

## What Changed

Your custom minimal nvm wrapper has been replaced with **jorgebucaran/nvm.fish**, a well-maintained, full-featured Node version manager for Fish, plus automatic directory-based version switching.

## Installation

The following components are now installed:

1. **jorgebucaran/nvm.fish** (via Fisher)
   - Location: `~/.config/fish/functions/nvm.fish`
   - Provides: `nvm install`, `nvm use`, `nvm list`, `nvm uninstall`, etc.

2. **Auto-switching function**
   - Location: `~/.config/fish/functions/_auto_switch_node.fish`
   - Automatically detects `.nvmrc` files and switches Node versions

3. **Configuration**
   - Location: `~/Code/dotfiles/fish/nvm.fish`
   - Sets `nvm_data` directory and default version

## Features

### Automatic Version Switching

When you `cd` into a directory with a `.nvmrc` or `.node-version` file:
- ✅ Automatically switches to that Node version
- ✅ Auto-installs the version if it's not already installed
- ✅ Silent operation (no unnecessary output)

When you `cd` out of a project (no `.nvmrc`):
- ✅ Switches back to your default version (`v24.5.0`)

### Manual Commands

```fish
# Install a specific version
nvm install v24.11.1
nvm install 20      # Installs latest v20.x
nvm install lts     # Installs latest LTS
nvm install latest  # Installs latest stable

# Switch versions manually
nvm use v20.12.2
nvm use 24          # Uses latest installed v24.x

# List installed versions
nvm list

# List available remote versions
nvm list-remote

# Uninstall a version
nvm uninstall v23.10.0

# Show current version
nvm current

# Update nvm.fish itself
nvm_upgrade
```

## Configuration

### Default Version

Set in `~/Code/dotfiles/fish/nvm.fish`:
```fish
set -U nvm_default_version v24.5.0
```

To change it:
```fish
set -U nvm_default_version v22.13.0
```

### Data Directory

Node versions are stored in:
```
~/.local/share/nvm/
```

This matches your existing setup, so all your previously installed versions are still available.

### Default Packages

If you want certain npm packages installed automatically with every new Node version:
```fish
set -U nvm_default_packages yarn pnpm typescript
```

## Usage in Tmux

Perfect for your use case! When tmux restores your session:

1. Each pane opens in its project directory
2. The `_auto_switch_node` function triggers automatically
3. It detects the `.nvmrc` file
4. Switches to (or installs) the correct Node version
5. Your project starts with the right Node version

No manual intervention needed!

## Example Workflow

```fish
# Create a new project with Node v20
mkdir my-project
cd my-project
echo "20.12.2" > .nvmrc
# Auto-switches to v20.12.2 (or installs it if missing)

# Later, in tmux
# Session restored -> cd my-project -> automatically on v20.12.2

# Switch to another project
cd ~/other-project  # has .nvmrc with "24.5.0"
# Auto-switches to v24.5.0

# Work on a project without .nvmrc
cd ~/no-nvmrc-project
# Uses your default version (v24.5.0)
```

## Troubleshooting

### Check if auto-switching is working

```fish
# Manually trigger the function
_auto_switch_node

# Check current version
node --version

# Check if function is loaded
functions _auto_switch_node
```

### Reset to default version

```fish
nvm use $nvm_default_version
```

### List what's installed

```fish
nvm list
```

### Update nvm.fish

```fish
nvm_upgrade
# or
fisher update jorgebucaran/nvm.fish
```

## Files Modified

1. `~/Code/dotfiles/fish/nvm.fish` - Simplified configuration
2. `~/Code/dotfiles/fish/functions/_auto_switch_node.fish` - Auto-switch function
3. Installed plugin: `jorgebucaran/nvm.fish` via Fisher

## Migration Notes

### What was removed:
- Custom `init_nvm` function
- Custom `nvm` function with limited commands
- Custom `auto_node_version` and `manage_node_version` functions

### What was added:
- Full-featured `nvm` from jorgebucaran/nvm.fish
- Automatic directory-based switching
- Support for `.node-version` files (in addition to `.nvmrc`)
- LTS version support
- Remote version listing
- Better version matching

### What stayed the same:
- Node versions location (`~/.local/share/nvm/`)
- All your installed Node versions
- Fish shell integration
- Fast, native Fish implementation
