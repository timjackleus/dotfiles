function fish_greeting
    echo ''(set_color D7ADED)(whoami)'@'(hostname)'
'(set_color C2C4FC)'Uptime: '(set_color white)(uptime | sed 's/.*up \([^,]*\), .*/\1/')(set_color red)'
'(set_color EFC6C7)'IP Address: '(set_color white)(ipconfig getifaddr en0)(set_color red)'
'(set_color ADE4DC)'Fish version: '(set_color white)(echo $FISH_VERSION)(set_color red)''
end

# Use Starship theme
starship init fish | source

# Use Rose pine theme
fish_config theme choose "Rosé Pine Dawn"

# Set default editor
set -U EDITOR nvim

alias vscnvim "NVIM_APPNAME=vsc-nvim nvim"
# Runs a tmux-friendly version of fzf
set -U FZF_TMUX 1

export TERM=xterm-256color
export BAT_THEME="TwoDark"
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

function reloadkitty
    kill -SIGUSR1 (pgrep kitty)
end

# 1. Check if `.nvmrc` file exists.
# 2. If it exists, try to use the specified version.
# 3. If the specified version is not installed, install it.
# 4. If `.nvmrc` file does not exist, use the latest version of Node.js.
if test -e ./.nvmrc
    set nvm_version (cat .nvmrc)
    if not nvm use $nvm_version
        nvm install $nvm_version
        nvm use $nvm_version
    end
else
    nvm use latest
end

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

# The next line updates PATH for Netlify's Git Credential Helper.
# test -f '/Users/timjackleus/Library/Preferences/netlify/helper/path.fish.inc' && source '/Users/timjackleus/Library/Preferences/netlify/helper/path.fish.inc'
