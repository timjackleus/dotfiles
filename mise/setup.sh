# Symlink config (will force if file already exist)
mkdir -p ~/.config/mise
ln -s -f $PWD/mise/config.toml ~/.config/mise/config.toml
