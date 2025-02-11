#!/bin/bash

# Get keyboard states
caps=$(xset -q | grep "Caps Lock" | awk '{print $4}')
num=$(xset -q | grep "Num Lock" | awk '{print $8}')

# Define colors
green="#00FF00"
gray="#888888"

# Format output with colors
caps_text=$([ "$caps" = "on" ] && echo "<span color='$green'>CAPS</span>" || echo "<span color='$gray'>CAPS</span>")
num_text=$([ "$num" = "on" ] && echo "<span color='$green'>NUM</span>" || echo "<span color='$gray'>NUM</span>")

echo "$caps_text $num_text"
echo "$caps_text $num_text"