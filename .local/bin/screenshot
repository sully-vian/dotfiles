#!/usr/bin/env bash

# capture selection: -s
# capture full screen: -f

SCREENSHOT_DIR="$HOME/Pictures"

mkdir -p "$SCREENSHOT_DIR"

FILENAME="screenshot-$(date +%Y-%m-%d-%H-%M-%S).png"
FULL_PATH="$SCREENSHOT_DIR/$FILENAME"

if [ "$1" = "-s" ]; then # selection mode
    import "$FULL_PATH"

    if [ $? -eq 0 ]; then
        notify-send --urgency=low "Selection captured" "Saved to $FULL_PATH"
    else
        notify-send --urgency=low "Screenshot canceled" "No image was saved"
    fi

elif [ "$1" = "-f" ]; then # full window mode
    import -window root "$FULL_PATH"

    if [ $? -eq 0 ]; then
        notify-send --urgency=low "Full screen captured" "Saved to $FULL_PATH"
    fi
fi

