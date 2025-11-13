#!/bin/bash
# Copy wezterm config from configured location to this repo

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SCRIPT_DIR/config_profiles.sh"

SRC_DIR=$(get_config_path "wezterm")
DEST_DIR="$SCRIPT_DIR/wezterm"

if [ ! -d "$SRC_DIR" ]; then
    echo "Error: Source directory $SRC_DIR does not exist."
    exit 1
fi

trap 'echo "Error copying wezterm config."' ERR
rm -rf "$DEST_DIR"

cp -r "$SRC_DIR" "$DEST_DIR"

echo "Wezterm configuration has been updated from $SRC_DIR to $DEST_DIR"
