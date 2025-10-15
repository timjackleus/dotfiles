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

# Load NVM configuration
source $__fish_config_dir/nvm.fish

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
