# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# upgrade any already-installed formulae
brew upgrade

# Run all installations
./brew.sh
./brew-cask.sh

# remove outdated versions from the cellar
brew cleanup
