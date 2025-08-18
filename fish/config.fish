function fish_greeting
    echo ''(set_color D7ADED)(whoami)'@'(hostname)'
'(set_color C2C4FC)'Uptime: '(set_color white)(uptime | sed 's/.*up \([^,]*\), .*/\1/')(set_color red)'
'(set_color EFC6C7)'IP Address: '(set_color white)(ipconfig getifaddr en0)(set_color red)'
'(set_color ADE4DC)'Node.js: '(set_color white)(node --version 2>/dev/null || echo "none")(set_color red)''
end

# Source extras
source $__fish_config_dir/extra.fish
echo $__fish_config_dir/extra.fish

# Use Starship theme
starship init fish | source

# Use Rose pine theme
fish_config theme choose "Rosé Pine Dawn"

# Set default editor
set -U EDITOR nvim

alias custom "NVIM_APPNAME=custom-nvim nvim"
alias vscnvim "NVIM_APPNAME=vsc-nvim nvim"
alias aider "aider --dark-mode"
alias energy "fish ~/.config/fish/bin/energy-price.fish"

# List all paths
function lp -d "List PATH entries"
    string split ':' $PATH | nl
end

# use pnpm instead of npm
alias npm="pnpm"
alias npx="pnpm dlx"
# ... but if we still need npm:
alias realnpm="command npm"
alias realnpx="command npx"

# Runs a tmux-friendly version of fzf
set -U FZF_TMUX 1

export TERM=xterm-256color
export BAT_THEME="TwoDark"
export AIDER_EDITOR=vim

# add PATHs
fish_add_path ~/.local/bin
fish_add_path ~/.rbenv/shims
fish_add_path ~/.rbenv/bin

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
            test -d "$NVM_DIR/$argv[2]/bin"; or begin
                echo "❌ Version $argv[2] not found"
                nvm list
                return 1
            end
            set -gx PATH (string match -v "*/.local/share/nvm/*" $PATH) "$NVM_DIR/$argv[2]/bin"
            echo "✅ Now using Node $argv[2]"
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
        set nvm_version (cat .nvmrc)
        nvm use $nvm_version
    else if test -f package.json
        echo "🔍 Using Node.js "(node --version 2>/dev/null; or echo "none")
    end
end

# Initialize and auto-switch if in project
init_nvm
if test "$nvm_initialized" = true -a \( -f package.json -o -f .nvmrc \)
    auto_node_version
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

# Only manage Node version if we're in a project directory
if test "$nvm_initialized" = true
    if test -f package.json -o -f .nvmrc
        manage_node_version
    end
end

# set locale (used in tmux bar etc)
export LC_ALL=en_US.UTF-8

alias gs='git status'

alias vim='nvim'

# Modern tool replacements
alias ls='eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions'
alias ll='eza --color=always --long --git --icons=always'
alias la='eza --color=always --long --git --icons=always --all'
alias tree='eza --tree --color=always --icons=always'
alias top='bottom'
alias cat='bat'

# Common paths
alias dl="cd ~/Downloads"
alias h='cd ~/.'

# Get week number
alias week='date +%V'

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

alias reload="source ~/.config/fish/config.fish"

# Get week number
alias week='date +%V'

# List all globally installed npm packages
alias npmlist='npm list -g --depth=0'

alias cdicloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"

alias tmuxt='tmux attach\; choose-tree -Zs'

alias ssh='TERM=xterm-256color ssh'

function glb -d "Fuzzy-find and checkout a branch"
    git branch --all | grep -v HEAD | string trim | fzf | read -l result; and git checkout "$result"
end

function killport -d "Kill process running on the specified port"
    set port $argv[1]
    set pid (lsof -ti tcp:$port)
    if test -n "$pid"
        kill -9 $pid
        echo "Killed process $pid running on port $port"
    else
        echo "No process running on port $port"
    end
end

# change cwd when exiting yazi
function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Custom key bindings that are more intuitive for vim users
function fish_user_key_bindings
    # Clear line with Ctrl+D (delete)
    bind \cd 'commandline -r ""'

    # Copy line to clipboard with Ctrl+Y (yank in vim)
    bind \cy 'echo -n (commandline) | pbcopy'

    # Paste from clipboard with Ctrl+P (paste)
    bind \cp 'commandline -i (pbpaste)'
end

# Apply our custom key bindings
fish_user_key_bindings

# pnpm
set -gx PNPM_HOME /Users/timjackleus/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
