#!/bin/bash
# Copy nvim config from configured location to this repo

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SCRIPT_DIR/config_profiles.sh"

SRC_DIR=$(get_config_path "nvim")
DEST_DIR="$SCRIPT_DIR/nvim"

if [ ! -d "$SRC_DIR" ]; then
    echo "Error: Source directory $SRC_DIR does not exist."
    exit 1
fi

trap 'echo "Error copying nvim config."' ERR
rm -rf "$DEST_DIR"

cp -r "$SRC_DIR" "$DEST_DIR"

echo "Neovim configuration has been updated from $SRC_DIR to $DEST_DIR"

