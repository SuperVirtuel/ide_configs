#!/bin/bash
# Install nvim config from repo to ~/.config/nvim

SRC_DIR="$(pwd)/nvim"
DEST_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim_backup_$(date +%Y%m%d_%H%M%S)"

if [ ! -d "$SRC_DIR" ]; then
  echo "Error: Source directory $SRC_DIR does not exist."
  echo "Please run update_nvim_repo.sh first to copy your nvim config to the repo."
  exit 1
fi

if [ -d "$DEST_DIR" ]; then
  echo "Existing nvim config found. Backing up to $BACKUP_DIR"
  mv "$DEST_DIR" "$BACKUP_DIR"
fi

echo "Copying $SRC_DIR to $DEST_DIR"
cp -r "$SRC_DIR" "$DEST_DIR"

echo "Done."
