# Tim's dotfiles

### Install xcode from App Store

### Run all macos settings then reboot when complete
```
$ ./.macos
```

### Install Homebrew then run all installations
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ ./.brew.sh
$ ./.brew-cask.sh
```

### Setup zsh
```
$ ./zsh/.init
```

### Install Oh my zsh
```
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
```

### Iterm2
Import settings from the iterm2 folder

### Setup vscode
- In vscode open command palette (cmd+shift+p)
- search for `Shell Command: Install 'code' command in PATH command`
- `$ ./vsc/.init`

### Setup Git
```
$ ./.extra (not included in repo)
```
Follow [this guide](https://sourabhbajaj.com/mac-setup/Git/) to setup SSH
