#!/bin/bash

# This script generates the pango text needed to display the current wifi network
# name and status using nmcli

# Get the Wi-i connection status
wifi_status=$(nmcli -t -f WIFI g)

# set icon
if [ "$wifi_status" = "enabled" ]; then
    icon="󰤨"
else
    icon="󰤭"
fi

# Get the wifi network name
name=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)

if [ -z "$name" ]; then
    name="Disconnected"
fi

light_blue="#8be9fd"

echo "<span foreground='$light_blue'>$icon <b>$name</b></span>"

# Check if button was clicked
if [[ "${BLOCK_BUTTON}" ]]; then
  alacritty --class floating -e nmtui
fi
