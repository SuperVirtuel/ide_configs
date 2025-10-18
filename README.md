# IDE Configuration Repository

Personal configuration files for Neovim and VSCode.

## Structure

```
ide_configs/
├── neovim/          # Neovim configuration (~/.config/nvim)
├── vscode/          # VSCode configuration (~/.vscode)
├── install.sh       # Installation script
└── README.md        # This file
```

## Installation

To install these configurations on a new machine:

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/Dev/ide_configs
   cd ~/Dev/ide_configs
   ```

2. Run the install script:
   ```bash
   ./install.sh
   ```

The script will:
- Automatically backup any existing configurations to `~/.config_backup_<timestamp>`
- Copy Neovim config to `~/.config/nvim`
- Copy VSCode config to `~/.vscode`

3. Restart your editors for changes to take effect

## Updating Configurations

To update this repository with your latest configs:

### Neovim
```bash
cp -r ~/.config/nvim/* ~/Dev/ide_configs/neovim/
```

### VSCode
```bash
cp -r ~/.vscode/* ~/Dev/ide_configs/vscode/
```

Then commit and push your changes:
```bash
cd ~/Dev/ide_configs
git add .
git commit -m "Update configs"
git push
```

## Manual Installation

If you prefer to install manually:

### Neovim
```bash
cp -r neovim ~/.config/nvim
```

### VSCode
```bash
cp -r vscode ~/.vscode
```

## Notes

- The install script creates automatic backups before overwriting existing configs
- Make sure to review the configs before installing on a new machine
- Some plugins or extensions may need to be installed separately
