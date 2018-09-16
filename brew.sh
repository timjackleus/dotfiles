# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install moreutils

# Install more recent versions of some macOS tools.
brew install grep
brew install homebrew/php/php56 --with-gmp
brew install openssh
brew install screen
brew install vim --with-override-system-vi

# Install other useful binaries.
brew install git
brew install node # This installs 'npm' too using the recommended installation method
brew install npm
brew install nvm
brew install p7zip
brew install tig
brew install tree
brew install yarn
brew install zsh
brew install zsh-syntax-highlighting

# Remove outdated versions from the cellar
brew cleanup
