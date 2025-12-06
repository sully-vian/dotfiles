#!/bin/bash

# This script is uses rofi to select a wallpaper and apply the theme using pywal.
# The script also copies the bat theme to the bat config directory.

WP_DIR="$HOME/.wallpapers"
THUMB_DIR="$HOME/.cache/wp-thumbnails"

# create the thumbnail directory if it doesn't exist
mkdir -p "$THUMB_DIR"

# generate square thumbnails if they don't exist
for file in "$WP_DIR"/*; do
    FILENAME=$(basename "$file")
    THUMB_PATH="$THUMB_DIR/$FILENAME"
    if [ ! -f "$THUMB_PATH" ]; then
        convert "$file" -resize 256x256^ -gravity center -extent 256x256 "$THUMB_PATH"
    fi
done

# Build a list of filenames only with preview icon

FILE_LIST=""
for file in "$WP_DIR"/*; do
    FILENAME=$(basename "$file")
    THUMB_PATH="$THUMB_DIR/$FILENAME"
    FILE_LIST+="$FILENAME\0icon\x1fthumbnail://$THUMB_PATH\n"
done

# Use rofi to select a wallpaper (showing only filenames)
SELECTED_FILENAME=$(echo -en "$FILE_LIST" | rofi -dmenu -i -p "Wallpaper")

if [ -n "$SELECTED_FILENAME" ]; then
    # Prepend the wallpaper directory to the selected filename
    SELECTED_WALLPAPER="$WP_DIR/$SELECTED_FILENAME"

    # Apply the selected wallpaper and theme using pywal
    wal -i "$SELECTED_WALLPAPER"

    # copy the bat theme
    ~/.scripts/copy-bat-theme.sh

    # restart dunst to apply colors
    ~/.scripts/dunst-restart.sh

fi
