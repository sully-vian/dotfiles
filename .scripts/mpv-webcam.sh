#!/usr/bin/env bash

TITLE="mpv webcam" # for floating and sticky window with i3

args=(
    av://v4l2:/dev/video2
    --profile=low-latency
    --untimed # disable clock
    --vf=hflip # mirror video
    --osc=no # hide controller
    --no-border
    --geometry=320x240-0-0
    --quiet
    --title="$TITLE"
)

mpv  "${args[@]}"
