#!/bin/bash

# This script generates the pango text needed to display the current bluetooth
# status and connected device using bluetoothctl device list

# Get the bluetooth connection status
bluetooth_status=$(bluetoothctl show | grep Powered | awk '{print $2}')

# set icon
if [ "$bluetooth_status" = "yes" ]; then
    icon="󰂯"
else
    icon="󰂲"
fi

# Get the bluetooth device name
device=$(bluetoothctl info | grep Name | cut -d ' ' -f 2-)

# Get the battery percentage
battery=$(bluetoothctl info | grep "Battery Percentage" | awk -F '[()]' '{print $2}')
# format battery to put parenthesis and percentage if defined
if [ -n "$battery" ]; then
    battery=" ($battery%)"
fi

if [ -z "$device" ]; then
    icon="󰂲"
    device="Disconnected"
    battery=""
fi

light_blue="#8be9fd"

echo "<span foreground='$light_blue'>$icon <b>$device</b>$battery</span>"

# Check if left mouse button was clicked
if [[ "${BLOCK_BUTTON}" == "1" ]]; then
    alacritty --class floating -e bluetui
fi
