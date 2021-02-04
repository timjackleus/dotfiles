# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install moreutils

# Install more recent versions of some macOS tools.
brew install homebrew/php/php56 --with-gmp
brew install openssh

# Install other useful binaries.
brew install archey
brew install bat
brew install cmake
brew install fish
brew install fzf
brew install git
brew install neovim --HEAD
brew install node # This installs 'npm' too using the recommended installation method
brew install npm
brew install nvm
brew install p7zip
brew install reattach-to-user-namespace
brew install ripgrep
brew install starship
brew install tig
brew install tmux
brew install tree
brew install yarn
brew install zsh-syntax-highlighting

# for movie editing e.g making gifs
brew install ffmpeg
brew install gifsicle

# Remove outdated versions from the cellar
brew cleanup
