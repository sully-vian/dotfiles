#!/usr/bin/env bash

# this script setups an i3lock-color lockscreen with a blurred background
# and a clock. It uses the pywal colorscheme.

# get the colorscheme
source ~/.cache/wal/colors.sh

# st color variables
black=$color0
red=$color1
green=$color2
yellow=$color3
blue=$color4
magenta=$color5
cyan=$color6
white=$color7

#set the colors
BLANK=$black
CLEAR=$black
DEFAULT=$white
TEXT=$white
WRONG=$red
VERIFYING=$blue

i3lock \
    --insidever-color="$CLEAR" \
    --ringver-color="$VERIFYING" \
    \
    --insidewrong-color="$CLEAR" \
    --ringwrong-color="$WRONG" \
    \
    --inside-color="$BLANK" \
    --ring-color="$DEFAULT" \
    --line-color="$BLANK" \
    --separator-color="$DEFAULT" \
    \
    --verif-color="$TEXT" \
    --wrong-color="$TEXT" \
    --time-color="$TEXT" \
    --date-color="$TEXT" \
    --layout-color="$TEXT" \
    --keyhl-color="$WRONG" \
    --bshl-color="$WRONG" \
    \
    --blur 5 \
    --clock \
    --indicator \
    --time-str="%H:%M:%S" \
    --date-str="%A, %d-%m-%Y" \
    --keylayout 1 \
