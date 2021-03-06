# Use startfish theme
starship init fish | source

# Set default editor
set -U EDITOR nvim

# Runs a tmux-friendly version of fzf
set -U FZF_TMUX 1

export TERM=xterm-256color
export BAT_THEME="TwoDark"

# set locale (used in tmux bar etc)
export LC_ALL=en_SE.UTF-8

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

# Fish syntax highlighting
# inspired by onedark
set -g fish_color_normal 'white'
set -g fish_color_command 'brmagenta'
set -g fish_color_quote 'brgreen'
set -g fish_color_redirection 'brcyan'
set -g fish_color_end 'white'
set -g fish_color_error 'brred'
set -g fish_color_param 'brred'
set -g fish_color_comment 'brblack'
set -g fish_color_match 'brcyan'
set -g fish_color_search_match 'blue'
set -g fish_color_operator 'brmagenta'
set -g fish_color_escape 'brcyan'
set -g fish_color_cwd 'brred'
set -g fish_color_autosuggestion 'white'
set -g fish_color_valid_path 'brred'
set -g fish_color_history_current 'brcyan'
set -g fish_color_selection 'brblack'
set -g fish_color_user 'brblue'
set -g fish_color_host 'brgreen'
set -g fish_color_cancel 'brblack'
set -g fish_pager_color_completion 'white'
set -g fish_pager_color_prefix 'brgreen'
set -g fish_pager_color_description 'white'
set -g fish_pager_color_progress 'white'
