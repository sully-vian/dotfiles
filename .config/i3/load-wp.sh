#!/bin/bash

# This script loads the wallpaper saved in the wal cache
# if no wallpaper is saved, it loads a default wallpaper

# get the wallpaper filename from wal
WP_PATH=$(cat "$HOME"/.cache/wal/wal)

# Apply the selected wallpaper and theme using pywal
wal -i "$WP_PATH"

