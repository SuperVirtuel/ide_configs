#!/bin/bash

set -e

# Install Oh My Posh
echo "Installing Oh My Posh..."
curl -s https://ohmyposh.dev/install.sh | bash

# Install Nerd Fonts (FiraCode as example)
echo "Installing Nerd Fonts (FiraCode)..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
cd "$FONT_DIR"
wget -O FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip -o FiraCode.zip
rm FiraCode.zip
fc-cache -fv

echo "Installation complete!"
echo "Restart your terminal and configure Oh My Posh with a Nerd Font for best results."
```

You can customize the font by changing the download URL.  
Make the script executable:  
```bash
chmod +x install_omp_nerdfonts.sh
```
Then run it:  
```bash
./install_omp_nerdfonts.sh

