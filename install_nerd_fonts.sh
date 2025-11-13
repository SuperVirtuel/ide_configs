#!/bin/bash

# Nerd Fonts Installer Script
# Downloads and installs popular Nerd Fonts

set -e

FONTS_DIR="$HOME/.local/share/fonts"
TEMP_DIR="/tmp/nerd-fonts"
NERD_FONTS_VERSION="v3.1.1"

# Popular Nerd Fonts to install (you can modify this list)
FONTS=(
    "FiraCode"
    "JetBrainsMono"
    "Hack"
    "Meslo"
    "RobotoMono"
    "UbuntuMono"
    "DejaVuSansMono"
)

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Nerd Fonts Installer ===${NC}"
echo ""

# Create fonts directory if it doesn't exist
mkdir -p "$FONTS_DIR"
mkdir -p "$TEMP_DIR"

# Function to download and install a font
install_font() {
    local font_name=$1
    local url="https://github.com/ryanoasis/nerd-fonts/releases/download/${NERD_FONTS_VERSION}/${font_name}.zip"
    
    echo -e "${YELLOW}Installing ${font_name}...${NC}"
    
    # Download font
    if curl -fLo "$TEMP_DIR/${font_name}.zip" "$url"; then
        # Extract to fonts directory
        unzip -oq "$TEMP_DIR/${font_name}.zip" -d "$FONTS_DIR/${font_name}" -x "*.txt" -x "*.md"
        echo -e "${GREEN}✓ ${font_name} installed${NC}"
    else
        echo -e "${YELLOW}✗ Failed to download ${font_name}${NC}"
    fi
}

# Check if specific fonts were requested
if [ $# -gt 0 ]; then
    # Install only requested fonts
    for font in "$@"; do
        install_font "$font"
    done
else
    # Install all default fonts
    for font in "${FONTS[@]}"; do
        install_font "$font"
    done
fi

# Clean up
rm -rf "$TEMP_DIR"

# Refresh font cache
echo ""
echo -e "${YELLOW}Refreshing font cache...${NC}"
fc-cache -f "$FONTS_DIR"

echo ""
echo -e "${GREEN}=== Installation Complete! ===${NC}"
echo -e "Fonts installed to: ${FONTS_DIR}"
echo ""
echo "Available fonts:"
for font in "${FONTS[@]}"; do
    echo "  - ${font} Nerd Font"
done
echo ""
echo "Usage: $0 [FontName1 FontName2 ...]"
echo "Example: $0 FiraCode JetBrainsMono"
