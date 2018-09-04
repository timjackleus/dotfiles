# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install moreutils

brew install node # This installs 'npm' too using the recommended installation method

brew install git
brew install nvm
brew install zsh
brew install npm
brew install yarn
brew install tig

brew install p7zip

# Remove outdated versions from the cellar
brew cleanup
