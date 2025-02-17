#!/bin/bash

# Get total and used swap memory
total=$(free -m | awk '/^Swap:/ {print $2}')
used=$(free -m | awk '/^Swap:/ {print $3}')

# Calculate percentage of used swap
percent=$((used * 100 / total))

# Determine color based on swap usage
if [ $percent -lt 50 ]; then
    color="#00FF00" # Green
elif [ $percent -lt 75 ]; then
    color="#FFFF00" # Yellow
else
    color="#FF0000" # Red
fi

# Check if the button was clicked
if [[ -z "${BLOCK_BUTTON}" ]]; then
    # Display swap usage when not clicked
    echo "<span color='$color'>SWAP: $percent%</span>"
else
    # Display detailed swap usage when clicked
    echo "<span color='$color'>$used/${total}MB</span>"
fi
