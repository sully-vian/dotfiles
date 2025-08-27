#!/bin/bash
# ~/.xinitrc
#
# executed by startx

# set natural scrolling (touchpad)
TOUCHPAD_ID=$(xinput list | grep -i touchpad | grep -o 'id=[0-9]*' | grep -o '[0-9]*')
xinput set-prop "$TOUCHPAD_ID" 'libinput Natural Scrolling Enabled' 1

# set keymapping
setxkbmap fr

# set terminal variable
export TERMINAL=alacritty

# start i3
exec i3
