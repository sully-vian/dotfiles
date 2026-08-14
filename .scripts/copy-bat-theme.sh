#!/usr/bin/env bash

# This script copies the generated pywal theme for bat to the right destination and loads it

SOURCE="$HOME/.cache/wal/colors-bat.tmTheme"
DESTINATION="$XDG_CONFIG_HOME/bat/themes/colors-bat.tmTheme"

cp "$SOURCE" "$DESTINATION"
bat cache --build
