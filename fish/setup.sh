# save fish path to /etc/shells list
sudo sh -c "echo $(which fish) >> /etc/shells"

# change default shell to fish
chsh -s $(which fish)

# create folders first
mkdir -p ~/.config/fish/bin

# install fisher plugin manager
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# link starship theme config
ln -s -f $PWD/fish/starship.toml ~/.config/starship.toml

# create symlinks
ln -s $PWD/fish/config.fish ~/.config/fish/config.fish
ln -s $PWD/fish/nvm.fish ~/.config/fish/nvm.fish
ln -s $PWD/fish/bin/energy-price.fish ~/.config/fish/bin/energy-price.fish
ln -s $PWD/fish/fish_plugins ~/.config/fish/fish_plugins
ln -s $PWD/fish/extra.fish ~/.config/fish/extra.fish

# run fisher and install all plugins
fisher update
