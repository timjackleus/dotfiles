# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install moreutils

# Install more recent versions of some macOS tools.
brew install openssh
brew install grep

# Install other useful binaries.
brew install archey
brew install awscli
brew install bat
brew install cmake
brew install deno
brew install fish
brew install fzf
brew install gh
brew install git
brew install git-lfs
brew install gnu-sed
brew install go
brew install neovim
brew install node # This installs 'npm' too using the recommended installation method
brew install npm
brew install nvm
brew install p7zip
brew install reattach-to-user-namespace
brew install ripgrep
brew install starship
brew install stylua
brew install tig
brew install tmux
brew install tree
brew install yarn
brew install zsh-syntax-highlighting

# Remove outdated versions from the cellar
brew cleanup
