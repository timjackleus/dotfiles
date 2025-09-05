# NVM Configuration for Fish Shell

set -gx NVM_DIR "$HOME/.local/share/nvm"
set -g nvm_initialized false

# Initialize NVM - find and set best Node version in PATH
function init_nvm --description "Initialize NVM paths"
    test -d "$NVM_DIR"; or return 1

    set node_path ""

    # Try default alias first, then latest v24.*, then any version
    if test -f "$NVM_DIR/alias/default"
        set node_version (cat "$NVM_DIR/alias/default" 2>/dev/null)
        test -d "$NVM_DIR/$node_version/bin"; and set node_path "$NVM_DIR/$node_version/bin"
    end

    if test -z "$node_path"
        for version_dir in "$NVM_DIR"/v24.* "$NVM_DIR"/v*
            if test -d "$version_dir/bin" -a -f "$version_dir/bin/node"
                set node_path "$version_dir/bin"
                break
            end
        end
    end

    if test -n "$node_path"
        set -gx PATH (string match -v "*/.local/share/nvm/*" $PATH) "$node_path"
        set -g nvm_initialized true
    end
end

# Minimal nvm command - supports list, use, current
function nvm --description "Node Version Manager"
    switch $argv[1]
        case list
            for version_dir in "$NVM_DIR"/v*
                test -d "$version_dir/bin"; or continue
                set node_version (basename "$version_dir")
                if string match -q "*$node_version*" "$PATH"
                    echo "   -> $node_version (current)"
                else
                    echo "      $node_version"
                end
            end
        case use
            set requested_version (string trim "$argv[2]")

            # Try exact match first
            if test -d "$NVM_DIR/$requested_version/bin"
                set -gx PATH (string match -v "*/.local/share/nvm/*" $PATH) "$NVM_DIR/$requested_version/bin"
                echo "✅ Now using Node $requested_version"
                return 0
            end

            # Try with 'v' prefix if not present
            if not string match -q "v*" "$requested_version"
                set requested_version "v$requested_version"
                if test -d "$NVM_DIR/$requested_version/bin"
                    set -gx PATH (string match -v "*/.local/share/nvm/*" $PATH) "$NVM_DIR/$requested_version/bin"
                    echo "✅ Now using Node $requested_version"
                    return 0
                end
            end

            # Try partial matching (e.g., "24" matches "v24.5.0")
            set original_version (string replace "v" "" "$argv[2]")
            for version_dir in "$NVM_DIR"/v*
                if test -d "$version_dir/bin"
                    set dir_version (string replace "v" "" (basename "$version_dir"))
                    if string match -q "$original_version*" "$dir_version"
                        set found_version (basename "$version_dir")
                        set -gx PATH (string match -v "*/.local/share/nvm/*" $PATH) "$version_dir/bin"
                        echo "✅ Now using Node $found_version (matched $argv[2])"
                        return 0
                    end
                end
            end

            echo "❌ Version $argv[2] not found"
            nvm list
            return 1
        case current
            node --version 2>/dev/null; or echo "No Node.js in PATH"
        case '*'
            echo "Usage: nvm [list|use <version>|current]"
    end
end

# Auto-switch Node version based on .nvmrc
function auto_node_version --description "Auto-switch Node version in project dirs"
    test "$nvm_initialized" = true; or return

    if test -f .nvmrc
        # Clean the version string (remove whitespace, newlines)
        set nvm_version (string trim (cat .nvmrc))
        echo "📁 Found .nvmrc requesting Node.js $nvm_version"
        nvm use $nvm_version
    else if test -f package.json
        echo "🔍 Using Node.js "(node --version 2>/dev/null; or echo "none")
    end
end

# Function to manage Node.js version using nvm
function manage_node_version
    # Skip if NVM initialization failed
    if test "$nvm_initialized" != true
        echo "⚠️  Skipping Node version management (no NVM versions found)"
        return 0
    end

    # Check if .nvmrc file exists
    if test -e ./.nvmrc
        set nvm_version (cat .nvmrc)
        echo "📁 Found .nvmrc requesting Node.js $nvm_version"
        nvm use $nvm_version
    else
        # Just show current version
        if command -v node >/dev/null 2>&1
            echo "🔍 Using Node.js "(node --version)
        end
    end
end

# Initialize NVM and set up auto-switching
init_nvm

# Auto-switch if in project directory
if test "$nvm_initialized" = true -a \( -f package.json -o -f .nvmrc \)
    auto_node_version
end

# Manage Node version if we're in a project directory
if test "$nvm_initialized" = true
    if test -f package.json -o -f .nvmrc
        manage_node_version
    end
end