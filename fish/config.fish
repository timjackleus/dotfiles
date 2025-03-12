function fish_greeting
    echo ''(set_color D7ADED)(whoami)'@'(hostname)'
'(set_color C2C4FC)'Uptime: '(set_color white)(uptime | sed 's/.*up \([^,]*\), .*/\1/')(set_color red)'
'(set_color EFC6C7)'IP Address: '(set_color white)(ipconfig getifaddr en0)(set_color red)'
'(set_color ADE4DC)'Fish version: '(set_color white)(echo $FISH_VERSION)(set_color red)''
end

# Source extras
source $__fish_config_dir/extra.fish

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

# Runs a tmux-friendly version of fzf
set -U FZF_TMUX 1

export TERM=xterm-256color
export BAT_THEME="TwoDark"
export AIDER_EDITOR=vim
export PATH="$HOME/.local/bin:$PATH"

function reloadkitty
    kill -SIGUSR1 (pgrep kitty)
end

# Function to manage Node.js version using nvm
function manage_node_version
    # 1. Check if `.nvmrc` file exists.
    # 2. If it exists, try to use the specified version.
    # 3. If the specified version is not installed, install it.
    # 4. If `.nvmrc` file does not exist but a `package.json` file does, use the latest version of Node.js.
    if test -e ./.nvmrc
        set nvm_version (cat .nvmrc)
        if not nvm use $nvm_version
            nvm install $nvm_version
            nvm use $nvm_version
        end
    else if test -e ./package.json
        nvm use latest
    end
end

manage_node_version

# set locale (used in tmux bar etc)
export LC_ALL=en_US.UTF-8

alias gs='git status'

alias vim='nvim'

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

# Use default key bindings as base, but with our custom ones
fish_default_key_bindings
