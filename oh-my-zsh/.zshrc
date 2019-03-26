# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# history
SAVEHIST=100000

# Nvm
export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

# Theme
ZSH_THEME="agnoster"

# Remove username@computer
DEFAULT_USER=$USER

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

# Enable syntax highlightning
source ~/.zsh/zsh-syntax-highlightning/zsh-syntax-highlighting.zsh

# Enable autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

source $ZSH/oh-my-zsh.sh
