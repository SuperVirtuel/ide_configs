#!/bin/bash
# Configuration profiles for different computers
# This file defines installation paths and repo paths for different machines

# Profile definitions
# Each profile contains:
# - destination paths (where configs are installed on the system)
# - repo paths (where configs are stored in this repository)

declare -A PROFILES

# Desktop profile
PROFILES["desktop_base_repo"]="$HOME/Dev/ide_configs"
PROFILES["desktop_fish_dest"]="$HOME/.config/fish"
PROFILES["desktop_nvim_dest"]="$HOME/.config/nvim"
PROFILES["desktop_wezterm_dest"]="$HOME/.config/wezterm"
PROFILES["desktop_vscode_dest"]="$HOME/.config/Code/User"
PROFILES["desktop_fish_repo"]="${PROFILES["desktop_base_repo"]}/fish"
PROFILES["desktop_nvim_repo"]="${PROFILES["desktop_base_repo"]}/nvim"
PROFILES["desktop_wezterm_repo"]="${PROFILES["desktop_base_repo"]}/wezterm"
PROFILES["desktop_vscode_repo"]="${PROFILES["desktop_base_repo"]}/vscode"

# Laptop profile
PROFILES["laptop_base_repo"]="/run/media/emile/2DBAE63108460002/DEV/ide_configs"
PROFILES["laptop_fish_dest"]="$HOME/.config/fish"
PROFILES["laptop_nvim_dest"]="$HOME/.config/nvim"
PROFILES["laptop_wezterm_dest"]="$HOME/.config/wezterm"
PROFILES["laptop_vscode_dest"]="$HOME/.config/Code/User"
PROFILES["laptop_fish_repo"]="${PROFILES["laptop_base_repo"]}/fish"
PROFILES["laptop_nvim_repo"]="${PROFILES["laptop_base_repo"]}/nvim"
PROFILES["laptop_wezterm_repo"]="${PROFILES["laptop_base_repo"]}/wezterm"
PROFILES["laptop_vscode_repo"]="${PROFILES["laptop_base_repo"]}/vscode"

# Ellipse profile
PROFILES["ellipse_base_repo"]="$HOME/DEV/ide_configs"
PROFILES["ellipse_fish_dest"]="$HOME/.config/fish"
PROFILES["ellipse_nvim_dest"]="$HOME/.config/nvim"
PROFILES["ellipse_wezterm_dest"]="$HOME/.config/wezterm"
PROFILES["ellipse_vscode_dest"]="$HOME/.config/Code/User"
PROFILES["ellipse_fish_repo"]="${PROFILES["ellipse_base_repo"]}/fish"
PROFILES["ellipse_nvim_repo"]="${PROFILES["ellipse_base_repo"]}/nvim"
PROFILES["ellipse_wezterm_repo"]="${PROFILES["ellipse_base_repo"]}/wezterm"
PROFILES["ellipse_vscode_repo"]="${PROFILES["ellipse_base_repo"]}/vscode"

# Get the current profile
get_current_profile() {
    local config_file="$HOME/.config/ide_configs_profile"

    if [ -f "$config_file" ]; then
        cat "$config_file"
    else
        echo "laptop"
    fi
}

# Set the current profile
set_current_profile() {
    local profile="$1"
    local config_file="$HOME/.config/ide_configs_profile"

    mkdir -p "$(dirname "$config_file")"
    echo "$profile" > "$config_file"
}

# Get a specific destination path for a config type
get_config_path() {
    local config_type="$1"
    local profile=$(get_current_profile)
    local key="${profile}_${config_type}_dest"

    echo "${PROFILES[$key]}"
}

# Get a specific repo path for a config type
get_repo_path() {
    local config_type="$1"
    local profile=$(get_current_profile)
    local key="${profile}_${config_type}_repo"

    echo "${PROFILES[$key]}"
}

# Get the base repo path for current profile
get_base_repo_path() {
    local profile=$(get_current_profile)
    local key="${profile}_base_repo"

    echo "${PROFILES[$key]}"
}

# List available profiles
list_profiles() {
    echo "desktop"
    echo "laptop"
    echo "ellipse"
}

# Export functions for use in other scripts
export -f get_current_profile
export -f get_config_path
export -f get_repo_path
export -f get_base_repo_path
