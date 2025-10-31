#!/bin/bash

SRC_DIR="$(pwd)/nvim"
DEST_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim_backup_$(date +%Y%m%d_%H%M%S)"

if [ -d "$DEST_DIR" ]; then
  echo "Existing nvim config found. Backing up to $BACKUP_DIR"
  mv "$DEST_DIR" "$BACKUP_DIR"
fi

echo "Copying $SRC_DIR to $DEST_DIR"
cp -r "$SRC_DIR" "$DEST_DIR"

echo "Done."
