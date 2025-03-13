#!/bin/bash

# This script copies the generated pywal theme for bat to the right destination and loads it

SOURCE="$HOME/.cache/wal/colors-bat.tmTheme"
DESTINATION="$HOME/.config/bat/themes/colors-bat.tmTheme"

cp "$SOURCE" "$DESTINATION"
bat cache --build
