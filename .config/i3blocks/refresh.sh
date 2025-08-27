#!/bin/bash

# Check if the button was clicked
if [[ "${BLOCK_BUTTON}" == "1" ]]; then
    # Display "click me!" when not clicked
    echo "click me!"
else
    # Display "clicked!" when clicked
    echo "clicked!"
fi