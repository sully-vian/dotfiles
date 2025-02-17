#!/bin/bash

# Check if the button was clicked
if [[ -z "${BLOCK_BUTTON}" ]]; then
    # Display "click me!" when not clicked
    echo "click me!"
else
    # Display "clicked!" when clicked
    echo "clicked!"
fi