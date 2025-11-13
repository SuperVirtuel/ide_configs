#!/bin/bash
# Configuration profiles for different computers
# This file defines installation paths for different machines

# Profile definitions
# Each profile contains paths for: fish, nvim, wezterm, vscode

declare -A PROFILES

# Default profile (Linux standard paths)
PROFILES["default_fish"]="$HOME/.config/fish"
PROFILES["default_nvim"]="$HOME/.config/nvim"
PROFILES["default_wezterm"]="$HOME/.config/wezterm"
PROFILES["default_vscode"]="$HOME/.config/Code/User"

# Work computer profile
PROFILES["work_fish"]="$HOME/.config/fish"
PROFILES["work_nvim"]="$HOME/.config/nvim"
PROFILES["work_wezterm"]="$HOME/.config/wezterm"
PROFILES["work_vscode"]="$HOME/.config/Code/User"

# Home computer profile
PROFILES["home_fish"]="$HOME/.config/fish"
PROFILES["home_nvim"]="$HOME/.config/nvim"
PROFILES["home_wezterm"]="$HOME/.wezterm"
PROFILES["home_vscode"]="$HOME/.vscode/config"

# Mac profile
PROFILES["mac_fish"]="$HOME/.config/fish"
PROFILES["mac_nvim"]="$HOME/.config/nvim"
PROFILES["mac_wezterm"]="$HOME/.config/wezterm"
PROFILES["mac_vscode"]="$HOME/Library/Application Support/Code/User"

# Get the current profile
get_current_profile() {
    local config_file="$HOME/.config/ide_configs_profile"

    if [ -f "$config_file" ]; then
        cat "$config_file"
    else
        echo "default"
    fi
}

# Set the current profile
set_current_profile() {
    local profile="$1"
    local config_file="$HOME/.config/ide_configs_profile"

    mkdir -p "$(dirname "$config_file")"
    echo "$profile" > "$config_file"
}

# Get a specific path for a config type
get_config_path() {
    local config_type="$1"
    local profile=$(get_current_profile)
    local key="${profile}_${config_type}"

    echo "${PROFILES[$key]}"
}

# List available profiles
list_profiles() {
    echo "default"
    echo "work"
    echo "home"
    echo "mac"
}

# Export functions for use in other scripts
export -f get_current_profile
export -f get_config_path
