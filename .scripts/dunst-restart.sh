#!/bin/bash

# kill it first !
pkill --exact dunst # exact name or else it kills this script

dunst -config ~/.cache/wal/colors-dunstrc &
