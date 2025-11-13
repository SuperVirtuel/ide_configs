# IDE Configuration Repository

Personal configuration files for Fish, Neovim, WezTerm, and VSCode.

## Structure

```
ide_configs/
├── fish/                      # Fish shell configuration
├── nvim/                      # Neovim configuration
├── wezterm/                   # WezTerm configuration
├── vscode/                    # VSCode configuration
├── scripts/                   # Individual install/update scripts
│   ├── install_fish_config.sh
│   ├── install_nvim_config.sh
│   ├── install_wezterm_config.sh
│   ├── update_fish_repo.sh
│   ├── update_nvim_repo.sh
│   └── update_wezterm_repo.sh
├── manage_configs.sh          # Master script for managing configs
├── config_profiles.sh         # Configuration profiles for different machines
└── README.md                  # This file
```

## Quick Start

### First Time Setup

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/DEV/ide_configs
   cd ~/DEV/ide_configs
   ```

2. Run the master script:
   ```bash
   ./manage_configs.sh
   ```

3. Follow the interactive prompts to:
   - Select your profile (default, work, home, mac)
   - Choose to install or update configs
   - Select which programs to manage

## Configuration Profiles

Different computers may have configs installed in different locations. The system supports multiple profiles:

- **default**: Standard Linux paths (`~/.config/...`)
- **work**: Work computer settings
- **home**: Home computer settings
- **mac**: macOS paths

### Managing Profiles

Your current profile is stored in `~/.config/ide_configs_profile`.

To view or change profiles, you can:
```bash
# View current profile
source config_profiles.sh && get_current_profile

# Set profile manually
source config_profiles.sh && set_current_profile "work"
```

Or use the master script which will prompt you interactively.

### Customizing Profiles

Edit `config_profiles.sh` to customize paths for each profile:

```bash
# Example: Home computer with custom wezterm location
PROFILES["home_wezterm"]="$HOME/.wezterm"
```

## Usage

### Interactive Mode (Recommended)

Simply run:
```bash
./manage_configs.sh
```

The script will guide you through:
1. Selecting/confirming your profile
2. Choosing operation (install or update)
3. Selecting programs to process
4. Confirming before execution

### Manual Script Usage

You can also run individual scripts directly:

```bash
# Install fish config
./scripts/install_fish_config.sh

# Update nvim config in repo
./scripts/update_nvim_repo.sh
```

## Operations

### Install
Copies configs FROM this repository TO your system (uses profile paths).

### Update
Copies configs FROM your system TO this repository (for committing changes).

## Adding New Configs

The master script automatically detects new scripts you add to the `scripts/` directory:

1. Create install script: `scripts/install_<name>_config.sh`
2. Create update script: `scripts/update_<name>_repo.sh`
3. Add paths to `config_profiles.sh`:
   ```bash
   PROFILES["default_<name>"]="$HOME/.config/<name>"
   PROFILES["work_<name>"]="$HOME/.config/<name>"
   # etc...
   ```

The master script will automatically pick up the new program.

## Notes

- All scripts automatically create backups before overwriting existing configs
- The system uses `get_config_path()` to determine paths based on your profile
- Individual scripts source `config_profiles.sh` automatically
- Some plugins or extensions may need to be installed separately
