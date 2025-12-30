#!/usr/bin/env bash

# Get the directory to check from the instance variable, default to $HOME
directory="${BLOCK_INSTANCE:-$HOME}"

# Get the disk usage percentage for the specified directory
usage=$(df -h "$directory" | awk 'NR==2 {print $5}' | sed 's/%//')

# Determine color based on disk usage
if [ "$usage" -lt 50 ]; then
    color="#00FF00"  # Green
elif [ "$usage" -lt 75 ]; then
    color="#FFFF00"  # Yellow
else
    color="#FF0000"  # Red
fi

# Output the disk usage with pango
echo "<span color='$color'>DISK: $usage%</span>"
