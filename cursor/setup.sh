# Create vsc-nvim config directory and symlink neovim config specific for vsc/cursor
mkdir -p ~/.config/vsc-nvim
ln -s -f $PWD/cursor/nvim/init.lua ~/.config/vsc-nvim/init.lua
ln -s -f $PWD/cursor/nvim/lazy-lock.json ~/.config/vsc-nvim/lazy-lock.json

# TODO: figure out a good way to symlink these
# ln -s -f ~/Library/Application\ Support/Cursor/User/keybindings.json $PWD/cursor/keybindings.json
# ln -s -f ~/Library/Application\ Support/Cursor/User/settings.json $PWD/cursor/settings.json
