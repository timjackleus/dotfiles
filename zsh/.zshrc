
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

# Enable syntax highlightning
source ~/.zsh/zsh-syntax-highlightning/zsh-syntax-highlighting.zsh

# Enable autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
