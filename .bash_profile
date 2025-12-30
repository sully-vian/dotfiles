#!/usr/bin/env bash


# Do not run bashrc if display is not set
if [ -f "$HOME/.bashrc" ] && [ -n "$DISPLAY" ]; then
    . "$HOME/.bashrc"
fi

