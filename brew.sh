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
brew install gh
brew install git
brew install git-lfs
brew install gnu-sed
brew install go
brew install hammerspoon
brew install luarocks
brew install neovim
brew install npm
brew install nvm
brew install p7zip
brew install reattach-to-user-namespace
brew install starship
brew install stylua
brew install tig
brew install tmux
brew install tree
brew install yarn

# yazi and dependencies
brew install clipboard
brew install fd
brew install ffmpegthumbnailer
brew install font-symbols-only-nerd-font
brew install fzf
brew install imagemagick
brew install jq
brew install poppler
brew install ripgrep
brew install sevenzip
brew install yazi
brew install zoxide

# Remove outdated versions from the cellar
brew cleanup
