#!/bin/bash
set -e

SOURCE_FILE=${1:-"src/main.cpp"}
OUTPUT_EXEC="first_systemc"

# No need to hardcode SYSTEMC_HOME anymore!
if [ -z "$SYSTEMC_HOME" ]; then
    echo "Error: SYSTEMC_HOME is not set. Run 'nix-shell' first."
    exit 1
fi

echo "Compiling $SOURCE_FILE..."

# Nix puts the library in /lib, so we use that directly
g++ -o "$OUTPUT_EXEC" "$SOURCE_FILE" \
    -lsystemc -lm

echo "Compilation successful. Running $OUTPUT_EXEC..."
echo "------------------------------------------------"

./"$OUTPUT_EXEC"
