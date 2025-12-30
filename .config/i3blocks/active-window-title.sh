#!/usr/bin/env bash

# get active window title
window_title=$(xdotool getactivewindow getwindowname)

if [ -z "$window_title" ]; then
  window_title="Desktop"
fi

app_name=$(echo "$window_title" | awk -F ' - ' '{print $NF}')

light_blue="#8be9fd"

echo "<span color='$light_blue'><b>$app_name</b></span>"

# TODO: replace this with a watcher as for volume
