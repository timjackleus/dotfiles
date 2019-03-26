# Tim's dotfiles

### Setup Xcode
- Download latest Xcode from App Store
- `$ ./xcode/.init`

### Run all macos settings then reboot when complete
```
$ ./.macos
```

### Install Homebrew then run all installations
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ ./brew.sh
$ ./brew-cask.sh
```

### Setup zsh
```
$ ./zsh/.init
```

### Install Oh my zsh
```
$ ./oh-my-zsh/.init
```
Import what's needed from `./.alias`, `./.functions` to `~/.zshrc`.

### Iterm2
Setup a folder to place the configurations in by checking "Load preferences from custom folder or url" option under "Gerneral". Then copy the config file from this repo to that folder.

### Setup tmux and vim
```
$ ./vim+tmux/.init
```

### Setup vscode
- In vscode open command palette (cmd+shift+p)
- search for 'code' and look for `Shell Command: Install 'code' command in PATH command`
- `$ ./vsc/.init`

### Setup Git
```
$ ./.extra (not included in repo)
```
Follow [this guide](https://sourabhbajaj.com/mac-setup/Git/) to setup SSH
