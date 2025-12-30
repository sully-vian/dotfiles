#!/usr/bin/env bash

# Get keyboard states
caps=$(xset -q | grep "Caps Lock" | awk '{print $4}')
num=$(xset -q | grep "Num Lock" | awk '{print $8}')

# Define colors
green="#00FF00"
gray="#888888"

if [ "$caps" = "on" ]; then
    caps_color=$green
else
    caps_color=$gray
fi

if [ "$num" = "on" ]; then
    num_color=$green
else
    num_color=$gray
fi

# Format output with colors
caps_text="<span color=\"$caps_color\"><b>CAPS</b></span>"
num_text="<span color=\"$num_color\"><b>NUM</b></span>"

echo "$caps_text $num_text"
