#!/usr/bin/env bash

# music menu script using rofi

cover=$(playerctl metadata mpris:artUrl 2>/dev/null)

status=$(playerctl status 2>/dev/null)

# options
if [ "$status" = "Playing" ]; then
    playpause=" Pause"
else
    playpause=" Play"
fi
next=" Next"
prev=" Prev"

# options combined
options="$playpause\n$next\n$prev"

TMP_DIR=$(mktemp -d)
COVER_PATH="$TMP_DIR/cover.jpg"

# download cover art
curl -s "$cover" -o "$COVER_PATH"

# selected option
selected=$(echo -e "$options" | rofi -dmenu -p "Music Menu" -show-icons -icon-theme "$COVER_PATH")

# action
case $selected in
"$playpause")
    playerctl play-pause
    ;;
"$next")
    playerctl next
    ;;
"$prev")
    playerctl previous
    ;;
esac
