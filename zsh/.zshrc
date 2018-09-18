
# history
SAVEHIST=100000

# Nvm
export NVM_DIR="$HOME/.nvm"

# Theme
ZSH_THEME="agnoster"

# Remove username@computer
DEFAULT_USER=$USER

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Enable syntax highlightning
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# include Z
. ~/z.sh

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
