#!/usr/bin/env bash
# ~/.xinitrc
#
# executed by startx

# set natural scrolling (touchpad)
# TOUCHPAD_ID=$(xinput list | grep -i touchpad | grep -o 'id=[0-9]*' | grep -o '[0-9]*')
# xinput set-prop "$TOUCHPAD_ID" 'libinput Natural Scrolling Enabled' 1

# set autorepeat rate
# xset r rate 200 40

# set terminal variable
export TERMINAL=alacritty

# QT
export QT_QPA_PLATFORMTHEME=qt5ct

# start i3
pgrep i3 || exec i3
