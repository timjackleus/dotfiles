# Auto-switch Node version when changing directories
# This function is triggered automatically whenever PWD changes
function _auto_switch_node --on-variable PWD --description "Auto-switch Node version on directory change"
    echo test
    # Only run in interactive shells
    status is-interactive || return

    # Look for .nvmrc or .node-version up the directory tree
    set -l nvmrc_path (
        begin
            set -l dir $PWD
            while test "$dir" != "/"
                if test -f "$dir/.nvmrc"
                    echo "$dir/.nvmrc"
                    break
                else if test -f "$dir/.node-version"
                    echo "$dir/.node-version"
                    break
                end
                set dir (dirname "$dir")
            end
        end
    )

    if test -n "$nvmrc_path"
        # Found an .nvmrc file
        set -l requested_version (string trim <$nvmrc_path)

        # Check if this version is already active to avoid redundant switches
        set -l current_version (node --version 2>/dev/null | string replace 'v' '')

        # Compare versions (handle both "24.5.0" and "v24.5.0" formats)
        set -l normalized_requested (string replace 'v' '' $requested_version)
        if test "$current_version" = "$normalized_requested"
            return 0
        end

        # Check if the requested version is installed
        if not nvm list 2>/dev/null | string match -q "*$requested_version*"
            echo "📦 Installing Node.js $requested_version (from $nvmrc_path)..."
            nvm install $requested_version
            if test $status -eq 0
                echo "✅ Now using Node.js $requested_version"
            else
                echo "❌ Failed to install Node.js $requested_version"
                return 1
            end
        else
            # Version exists, switch to it silently
            nvm use $requested_version --silent 2>/dev/null
        end
    else
        # No .nvmrc found - optionally switch back to default
        # You can comment this out if you want to stay on whatever version you're on
        if set -q nvm_default_version; and set -q nvm_current_version
            # Only switch if we're currently on an nvm-managed version
            # and not already on the default
            if test "$nvm_current_version" != "$nvm_default_version"
                nvm use $nvm_default_version --silent 2>/dev/null
            end
        end
    end
end
