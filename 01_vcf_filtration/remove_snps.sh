#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <phrases_file> <target_file>"
    exit 1
fi

PHRASES_FILE=$1
TARGET_FILE=$2

# Read each line (phrase) from the phrases file and remove lines from the target file
while IFS= read -r PHRASE; do
    sed -i "/^${PHRASE}/d" "$TARGET_FILE"
done < "$PHRASES_FILE"
