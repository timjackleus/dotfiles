# Set fish path
fish_add_path /opt/homebrew/bin

# Use Starship theme
starship init fish | source

# Set default editor
set -U EDITOR nvim

# Runs a tmux-friendly version of fzf
set -U FZF_TMUX 1

export TERM=xterm-256color
export BAT_THEME="TwoDark"
# export PATH=/opt/homebrew/bin:$PATH

# set node version with nvm if .nvmrc exist
if test -e ./.nvmrc
    nvm use
end

# set locale (used in tmux bar etc)
export LC_ALL=en_US.UTF-8

alias gs='git status'

alias vim='nvim'

alias npm='pnpm'

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

# The next line updates PATH for Netlify's Git Credential Helper.
# test -f '/Users/timjackleus/Library/Preferences/netlify/helper/path.fish.inc' && source '/Users/timjackleus/Library/Preferences/netlify/helper/path.fish.inc'
