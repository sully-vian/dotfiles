#!/usr/bin/env bash

shutdown=" Shutdown"
reboot=" Reboot"
lock=" Lock"
suspend=" Suspend"
logout="󰗽 Logout"


options=("shutdown" "$reboot" "$lock" "$suspend" "$logout")

selected=$(printf '%s\n' "${options[@]}" | dmenu -fn "monospace:size=20" -c -i -l "${#options[@]}")

case $selected in
"$shutdown")
    systemctl poweroff
    ;;
"$reboot")
    systemctl reboot
    ;;
"$lock")
    sleep 0.4;
    "$HOME/.config/i3/i3lock-color.sh"
    ;;
"$suspend")
    "$HOME/.config/i3/i3lock-color.sh" &
    systemctl suspend
    ;;
"$logout")
    i3-msg exit
    ;;
esac

