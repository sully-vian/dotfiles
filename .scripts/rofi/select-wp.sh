#!/bin/bash

# This script uses rofi to select a wallpaper from a directory of wallpapers
# and then applies the selected wallpaper theme using pywal.

WP_DIR="$HOME/.wallpapers"

# to add the wanted icon:
# echo -en "EntryName\0icon\x1fthumbnail://path/to/file\n" | rofi -dmenu -show-icons

# Build a list of filenames only with preview icon

FILE_LIST=""
for file in "$WP_DIR"/*; do
    FILEPATH=$(realpath "$file")
    FILENAME=$(basename "$file")
    FILE_LIST+="$FILENAME\0icon\x1fthumbnail://$FILEPATH\n"
done

# Use rofi to select a wallpaper (showing only filenames)
SELECTED_FILENAME=$(echo -en "$FILE_LIST" | rofi -dmenu -i -p "Wallpaper" *)

if [ -n "$SELECTED_FILENAME" ]; then
    # Prepend the wallpaper directory to the selected filename 
    SELECTED_WALLPAPER="$WP_DIR/$SELECTED_FILENAME"

    # Apply the selected wallpaper and theme using pywal
    wal -i "$SELECTED_WALLPAPER"
fi
