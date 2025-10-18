#!/bin/bash

# Install script for IDE configs
# This script copies Neovim and VSCode configurations to their proper locations

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"

echo "==================================="
echo "IDE Config Installer"
echo "==================================="
echo ""

# Function to backup existing config
backup_if_exists() {
    local source=$1
    local name=$2

    if [ -e "$source" ]; then
        echo "Backing up existing $name config to $BACKUP_DIR..."
        mkdir -p "$BACKUP_DIR"
        cp -r "$source" "$BACKUP_DIR/"
        echo "  ✓ Backup created"
    fi
}

# Function to install config
install_config() {
    local source=$1
    local dest=$2
    local name=$3

    echo ""
    echo "Installing $name configuration..."

    # Remove old config if it exists
    if [ -e "$dest" ]; then
        rm -rf "$dest"
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$dest")"

    # Copy new config
    cp -r "$source" "$dest"
    echo "  ✓ $name config installed to $dest"
}

# Backup existing configs
echo "Checking for existing configurations..."
backup_if_exists "$HOME/.config/nvim" "Neovim"
backup_if_exists "$HOME/.vscode" "VSCode"

# Install Neovim config
if [ -d "$SCRIPT_DIR/neovim" ]; then
    install_config "$SCRIPT_DIR/neovim" "$HOME/.config/nvim" "Neovim"
else
    echo "Warning: Neovim config directory not found, skipping..."
fi

# Install VSCode config
if [ -d "$SCRIPT_DIR/vscode" ]; then
    install_config "$SCRIPT_DIR/vscode" "$HOME/.vscode" "VSCode"
else
    echo "Warning: VSCode config directory not found, skipping..."
fi

echo ""
echo "==================================="
echo "Installation complete!"
echo "==================================="

if [ -d "$BACKUP_DIR" ]; then
    echo ""
    echo "Your old configs were backed up to:"
    echo "  $BACKUP_DIR"
fi

echo ""
echo "You may need to restart your editors for changes to take effect."
