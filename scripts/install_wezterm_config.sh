#!/bin/bash
# Install wezterm config from repo to configured destination

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SCRIPT_DIR/config_profiles.sh"

SRC_DIR="$SCRIPT_DIR/wezterm"
DEST_DIR=$(get_config_path "wezterm")
BACKUP_DIR="${DEST_DIR}_backup_$(date +%Y%m%d_%H%M%S)"

if [ ! -d "$SRC_DIR" ]; then
  echo "Error: Source directory $SRC_DIR does not exist."
  echo "Please run update_wezterm_repo.sh first to copy your wezterm config to the repo."
  exit 1
fi

if [ -d "$DEST_DIR" ]; then
  echo "Existing wezterm config found. Backing up to $BACKUP_DIR"
  mv "$DEST_DIR" "$BACKUP_DIR"
fi

echo "Copying $SRC_DIR to $DEST_DIR"
cp -r "$SRC_DIR" "$DEST_DIR"

echo "Done."
