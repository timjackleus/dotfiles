 #zmodload zsh/zprof # top of your .zshrc file to monitor what's being loaded on startup - and how long it takes to load

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# history
SAVEHIST=100000

# Run compinit only once
# for checking cached .zcompdump
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Theme
ZSH_THEME=""

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# include Z
source ~/z.sh

# Plugins
plugins=(
  brew
  docker
  git
  node
  npm
  z
  zsh-completions
  zsh-nvm
  zsh-syntax-highlighting
)

#
# --- Alias ---
#

# most git related aliases comes from the git plugin
#
# list branches and pick which one to checkout with fzf
alias glb='git checkout $(git branch | fzf)'
alias gs='git status'

# Always use neovim
alias vim='nvim'

alias ls="ls -lah"

# Common paths
alias dl="cd ~/Downloads"
alias h='cd ~/.'



# mv, rm, cp
alias mv='mv -v'
alias cp='cp -v'

# Get week number
alias week='date +%V'

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Get week number
alias week='date +%V'

# List all globally installed npm packages
alias npmlist='npm list -g --depth=0'

alias cdicloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"

alias tmuxt='tmux attach\; choose-tree -Zs'

# convert .mov file to .gif for presentations etc
function movtogif () {
  ffmpeg -i $1 -pix_fmt rgb8 -r 10 output.gif && gifsicle -O3 output.gif -o output.gif
}

#
# --- Functions ---
#

# Search history for keyword
function fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')
}

# Create a new directory and enter it
function md() {
	mkdir -p "$@" && cd "$@"
}



# Enable syntax highlightning
source ~/.zsh/zsh-syntax-highlightning/zsh-syntax-highlighting.zsh

# Enable autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

source $ZSH/oh-my-zsh.sh

# Set Custom promp
autoload -U promptinit; promptinit
prompt pure

 #zprof # bottom of .zshrc
