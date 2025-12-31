# Dotfiles Repository

This repository contains configuration files (dotfiles) for various tools and applications. These dotfiles help to set up a consistent development environment across different machines.

## TODO

- [ ] i3
    - [ ] `notify-send` / `dunst`
        - [ ] replace with dunstify
        - [x] fix `notify-send`
        - [x] add to screenshot
        - [ ] add to video capture
        - [ ] add battery warning 
    - [ ] Move from `rofi` to `dmenu`
        - [ ] dictionnary (api call for instance)
    - [ ] Stream
        - [ ] commands/shortcuts to record screen
        - [ ] webcam: not hide cursor when on window
- [ ] Use [dipc](https://github.com/doprz/dipc) for wallpaper conversion
- [x] Completion for cht
- [ ] neovim
    - [x] include hidden files in mini.pick
    - [ ] display `&filetype` at bottom
- [ ] tmux
    - [ ] hide/show panel (collapse)
- [ ] fzf
    - [ ] cht/man lookup

## Table of Contents

- [Dotfiles Repository](#dotfiles-repository)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Dependencies](#dependencies)
  - [Configuration Files](#configuration-files)
    - [LightDM Configuration](#lightdm-configuration)
    - [i3wm Configuration](#i3wm-configuration)
    - [rofi Configuration](#rofi-configuration)
  - [Aliases and Functions](#aliases-and-functions)
  - [VPN Configuration](#vpn-configuration)
  - [Prompt Customization](#prompt-customization)
  - [Tmux Configuration](#tmux-configuration)
  - [Vim Configuration](#vim-configuration)

## Installation

To install these dotfiles, install the dependencies, then run

```sh
git clone https://github.com/sully-vian/dotfiles.git ~/dotfiles
~/dotfiles/.scripts/install.sh
```

The installation uses `stow` to symlink the dotfiles to thre repo's files

The lightdm config files shall by copied to the `/etc/lightdm` directory. A copying script is provided in the `.config/lightdm` directory.

## Dependencies

The following tools are required for the configurations to work properly:

- **Bash**: The GNU Bourne Again shell.
- **VPNC**: A VPN client for Cisco VPNs.
- **Tmux**: A terminal multiplexer.
- **Vim**: A highly configurable text editor.
- **lsd**: A modern replacement for ls.
- **bat**: A cat clone with syntax highlighting and Git integration.
- **onefetch**: A command-line Git information tool.
- **Java**: Java Development Kit (JDK) and Java Runtime Environment (JRE).
- **opam**: OCaml package manager.
- **perl**: A highly capable, feature-rich programming language.
- **notify-send**: A program to send desktop notifications.
- **cheat.sh**: A command-line cheat sheet tool.
- **stow**: A symlink farm manager. (Optional, you can create the symlinks manually)
- **BlackBox**: A terminal emulator.(Optional, you can remove the configuration file)

## Configuration Files

`.bashrc`
The main configuration file for Bash. It sources other configuration files and sets environment variables.

`.bash_aliases`
Contains custom aliases and functions for the Bash shell.

`.bashprompt`
Customizes the Bash prompt with colors and Git information.

`.inputrc`
Configures key bindings for the Readline library, used by Bash.

`.tmux.conf`
Configuration file for Tmux, setting up key bindings, status bar, and plugins.

`.vimrc`
Configuration file for Vim, setting up indentation, tab stops, and other editor settings.

`.config/bat/config`
Configuration file for `bat`, setting up themes and other options.

`.var/app/com.raggesilver.BlackBox/config/glib-2.0/settings/keyfile`
Configuration file for the BlackBox terminal emulator.

### LightDM Configuration

`.config/lightdm`
Configuration files for the LightDM display manager and the GTK greeter.

### i3wm Configuration

`.config/i3`
Configuration files for the i3 window manager, including key bindings, status bar, and other settings.

`.config/i3blocks`
Configuration files for i3blocks, a status bar for i3.

### rofi Configuration

`.config/rofi`
Configuration files for Rofi, a window switcher, application launcher, and dmenu replacement.

## Aliases and Functions

`.bash_aliases`

- **ls**: Uses `lsd` if installed.
- **bat**: Uses `batcat` if installed.
- **onefetch**: Uses `onefetch` with Nerd Fonts if installed.
- **adc**: Compiles Ada programs.
- **javaclean**: Removes all `.class` files.
- **javacall**: Compiles all `.java` files.
- **javac-e**: Compiles and executes a Java program.
- **javatest-c**: Compiles and runs JUnit tests.
- **eclipse-idm**: Alias for Eclipse IDE.
- **nv**: Alias for NeoVim.
- **c**: Clears the terminal.
- **shut**: Shuts down the system.
- **chut**: Alias for `shut`.
- **cheat**: Fetches cheat sheets from cheat.sh.
- **cht**: Alias for `cheat`.
- **print_bash_list**: Prints a colon-separated list as a newline-separated list.

## VPN Configuration

`.n7-vpn.conf`
Configuration file for `vpnc` to connect to a specific VPN

`.bashvpn`
Script to connect and disconnect from the VPN using `vpnc`.

## Prompt Customization

`.bashprompt`
Customizes the Bash prompt with colors, Git information, and special symbols for different directories.

## Tmux Configuration

`.tmux`.conf
Configures Tmux with custom key bindings, status bar, and plugins.

## Vim Configuration

`.vimrc`
Configures Vim with custom settings for indentation, tab stops, and other editor options.
