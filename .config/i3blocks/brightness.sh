#!/usr/bin/env bash

# This script generates the pango text needed to display the current brightness
# with xbacklight

brightness=$(xbacklight -get | cut -d '.' -f 1)
brightness=$(brightnessctl | grep "%" | cut -d'(' -f 2 | cut -d'%' -f 1)

# determine icon based on brightness with 3 levels
if [ "$brightness" -ge 75 ]; then
    icon="󰃠"
elif [ "$brightness" -ge 50 ]; then
    icon="󰃟"
else
    icon="󰃞"
fi

light_blue="#8be9fd"

# Output the brightness percentage with pango
echo "<span color='$light_blue'>$icon  $brightness%</span>"

