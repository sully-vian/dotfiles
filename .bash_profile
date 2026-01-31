#!/usr/bin/env bash

alias startx="startx -- -configdir $HOME/.config/xorg" 

# Do not run bashrc if display is not set
if [ -f "$HOME/.bashrc" ] && [ -n "$DISPLAY" ]; then
    . "$HOME/.bashrc"
fi

