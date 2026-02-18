# NVM Configuration for Fish Shell
# Uses jorgebucaran/nvm.fish with automatic directory-based version switching
#
# The jorgebucaran/nvm.fish plugin is installed via Fisher and provides:
# - nvm install <version>  : Install a Node version
# - nvm use <version>      : Switch to a Node version  
# - nvm list              : List installed versions
# - nvm uninstall <version>: Remove a Node version
#
# This configuration adds automatic version switching when changing directories.

# Point nvm.fish to use your existing nvm installation directory
set -gx nvm_data "$HOME/.local/share/nvm"

# Set default Node version for new shells
# When you open a new terminal, it will use this version
set -U nvm_default_version v24.5.0

# Optional: Set default packages to install with every new Node version
# Uncomment and customize if needed:
# set -U nvm_default_packages yarn pnpm

# Helper function to upgrade nvm.fish itself
function nvm_upgrade --description "Update nvm.fish to the latest version"
    echo "🔄 Updating nvm.fish..."
    fisher update jorgebucaran/nvm.fish
    
    if test $status -eq 0
        echo "✅ nvm.fish updated successfully"
    else
        echo "❌ Failed to update nvm.fish"
        return 1
    end
end
