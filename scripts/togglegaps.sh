#!/bin/bash

# --- File to store toggle ---
TARGET_FILE="/home/b/.config/hypr/scripts/tooglegaps.log"

if [ ! -f "$TARGET_FILE" ]; then
  touch $TARGET_FILE
  echo "always_visible" > $TARGET_FILE
fi

# Read the first line of the file
FILE_CONTENT=$(head -n 1 "$TARGET_FILE")

if [ "$FILE_CONTENT" = "always_visible" ]; then
    echo "non_exclusive" > $TARGET_FILE
elif [ "$FILE_CONTENT" = "non_exclusive" ]; then
    echo "always_visible" > $TARGET_FILE
else
    echo "always_visible" > $TARGET_FILE
    FILE_CONTENT="always_visible"
fi

# Run it
qs -c noctalia-shell ipc call bar setDisplayMode $FILE_CONTENT all

exit 0
