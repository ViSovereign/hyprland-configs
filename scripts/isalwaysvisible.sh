#!/bin/bash

# --- File to store toggle ---
TARGET_FILE="/home/b/.config/hypr/scripts/tooglegaps.log"

if [ ! -f "$TARGET_FILE" ]; then
    exit 0
fi

# Read the first line of the file
FILE_CONTENT=$(head -n 1 "$TARGET_FILE")

if [ "$FILE_CONTENT" = "always_visible" ]; then
    echo "true"
else
    echo "false"
fi

exit 0
