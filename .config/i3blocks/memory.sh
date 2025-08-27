#!/bin/bash

# Get total and used memory
total=$(free -m | awk '/^Mem:/ {print $2}')
used=$(free -m | awk '/^Mem:/ {print $3}')

# Calculate percentage of used memory
percent=$((used * 100 / total))

# Determine color based on memory usage
if [ $percent -lt 50 ]; then
    color="#00FF00" # Green
elif [ $percent -lt 75 ]; then
    color="#FFFF00" # Yellow
else
    color="#FF0000" # Red
fi

echo "<span color='$color'>MEM: $percent%</span>"
