#!/usr/bin/env bash

# kill it first !
pkill --exact dunst # exact name or else it kills this script

dunst -config "$HOME/.cache/wal/colors-dunstrc" &
