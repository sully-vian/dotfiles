# Dotfiles Repository

This repository contains configuration files (dotfiles) for various tools and applications. These dotfiles help to set up a consistent development environment across different machines.

## TODO

- [x] change script's shebangs to custom exec wrapper that sends notif if error // done with `set -euo pipefail`
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
        - [x] webcam: not hide cursor when on window
- [ ] Use [dipc](https://github.com/doprz/dipc) for wallpaper conversion
- [ ] Neovim
    - [x] Language injection with tree-sitter
    - [x] include hidden files in mini.pick
    - [ ] display `&filetype` at bottom
    - [ ] use CFR decompiler (move to `~/.local/bin`) to view Java `.class` files
    - [x] EJS highlighting (see tree-sitter)
- [ ] tmux
    - [ ] hide/show panel (collapse)
- [ ] fzf
    - [ ] cht/man lookup

