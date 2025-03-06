# Tim's dotfiles

### Setup Xcode

- Download latest Xcode from App Store
- `$ ./xcode/.init`

#### Or just install the Xcode CLI

- `$ sudo xcode-select --install`
  This is usually not working due to failing connection to server... In that case manually download the latest Command Line Tools here
- <https://developer.apple.com/download/more/>

### Run all macos settings then reboot when complete

```
./macos/index.sh
```

### Install Homebrew then run all installations

```
./homebrew/index.sh
```

### Setup fish

```
./fish/.init
```

### Ghostty term

```
./ghostty/.init
```

### Setup tmux and vim

Currently based on [LazyVim](https://www.lazyvim.org/).

```
./tmux/.init
./vim/.init
```

### Setup keyboard

```
./keyboard/.init
./karabiner/.init
```

### Setup hammerspoon

```
./hammerspoon/.init
```

### Setup Git

```
./.extra (not included in repo)
```

Follow [this guide](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent) to setup SSH
