# Tim's dotfiles

### Setup Xcode

- Download latest Xcode from App Store
- `$ ./xcode/.init`

#### Or just install the Xcode CLI
- `$ sudo xcode-select --install`
This is usually not working due to failing connection to server... In that case manually download the latest Command Line Tools here
- https://developer.apple.com/download/more/

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

### Setup fish

```
$ ./fish/.init
```

### Alacritty

```
$ ./alacritty/.init
```

### Setup tmux and vim

```
$ ./tmux/.init
$ ./vim/.init
```
Since treesitter requires nvim 0.5, the following process might be needed:
```
$ brew install neovim --HEAD
$ brew install luarocks
$ brew detach luajit
$ brew install luajit --HEAD
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
