#!/bin/bash

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if dvdbackup and genisoimage are installed
if ! command -v dvdbackup &>/dev/null; then
    echo "dvdbackup is not installed."
    exit 1
fi
if ! command -v genisoimage &>/dev/null; then
    echo "genisoimage is not installed."
    exit 1
fi

# Check for input arguments
if [ $# -ne 3 ]; then
    echo -e "${YELLOW}Usage: $0 <input_device> <movie_name> <output_iso_path>${NC}"
    echo -e "${YELLOW}Example: $0 /dev/sr0 'The Matrix' ~/the-matrix.iso${NC}"
    echo -e "${YELLOW}To find the input device, run 'lsblk' or 'blkid'${NC}"
    exit 1
fi

# Asign variables for, input and output
INPUT_DEVICE="$1"
MOVIE_NAME="$2"
OUTPUT_ISO_PATH="$3"
TEMP_DIR=$(mktemp -d) # temporary directory for dvdbackup

# Step 1: Backup DVD contents
echo -e "${BLUE}Backing up DVD from $INPUT_DEVICE to $TEMP_DIR...\n${NC}"
if ! dvdbackup --mirror --progress --input="$INPUT_DEVICE" --output="$TEMP_DIR" --name="$MOVIE_NAME"; then
    echo -e "${RED}dvdbackup failed.\nExiting...\n${NC}"
    exit 1
fi

# Step 2: Create ISO from the backup files
echo -e "${BLUE}Creating ISO for $MOVIE_NAME at $OUTPUT_ISO_PATH...\n${NC}"
if ! genisoimage -dvd-video -V "$MOVIE_NAME" -o "$OUTPUT_ISO_PATH" "$TEMP_DIR"; then
    echo -e "${RED}genisoimage failed.\nExiting...\n${NC}"
    exit 1
fi

# Clean up the temporary directory
echo -e "${YELLOW}Cleaning up temporary files...\n${NC}"
rm -rf "$TEMP_DIR"

echo -e "${GREEN}ISO created successfully at $OUTPUT_ISO_PATH!${NC}"
