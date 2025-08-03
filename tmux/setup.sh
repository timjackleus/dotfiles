# Symlink config (will force if file already exist)
ln -s -f $PWD/tmux/.tmux.conf ~/.tmux.conf

# Create tmux plugins directory and clone Tmux Plugin Manager
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
