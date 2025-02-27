#!/bin/bash

WP_DIR="$HOME/.wallpapers"

# Build a list of filenames only
FILE_LIST=$(for file in "$WP_DIR"/*; do basename "$file"; done)

# Use rofi to select a wallpaper (showing only filenames)
SELECTED_FILENAME=$(echo "$FILE_LIST" | rofi -dmenu -i -p "Wallpaper")

if [ -n "$SELECTED_FILENAME" ]; then
    # Prepend the wallpaper directory to the selected filename
    SELECTED_WALLPAPER="$WP_DIR/$SELECTED_FILENAME"

    # Apply the selected wallpaper and theme using pywal
    wal -i "$SELECTED_WALLPAPER"
fi
