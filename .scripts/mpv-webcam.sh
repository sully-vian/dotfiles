#!/usr/bin/env bash

TITLE="mpv webcam" # for floating window with i3

mpv av://v4l2:/dev/video2 \
    --profile=low-latency \
    --untimed \
    --vf=hflip \
    --osc=no \
    --no-border \
    --cursor-autohide=always \
    --title="$TITLE"
