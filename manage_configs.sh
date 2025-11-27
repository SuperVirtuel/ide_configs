#!/bin/bash
# Master script for managing IDE configurations
# Handles installation and updating of configs for different programs

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_SUBDIR="$SCRIPT_DIR/scripts"

# Source the config profiles
source "$SCRIPT_DIR/config_profiles.sh"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  IDE Config Manager${NC}"
    echo -e "${BLUE}================================${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}→ $1${NC}"
}

# Show current profile
show_profile() {
    local profile=$(get_current_profile)
    echo -e "${BLUE}Current profile:${NC} $profile"
    echo ""
}

# Select profile
select_profile() {
    echo "Available profiles:"
    echo "1) desktop - Desktop computer (~/Dev/ide_configs)"
    echo "2) laptop - Laptop computer (/run/media/emile/2DBAE63108460002/DEV/ide_configs)"
    echo "3) ellipse - Ellipse computer (~/DEV/ide_configs)"
    echo ""
    read -p "Select profile [1-3]: " choice

    case $choice in
        1) set_current_profile "desktop" ;;
        2) set_current_profile "laptop" ;;
        3) set_current_profile "ellipse" ;;
        *)
            print_error "Invalid choice. Using laptop."
            set_current_profile "laptop"
            ;;
    esac

    print_success "Profile set to: $(get_current_profile)"
    echo ""
}

# Ask for operation type
select_operation() {
    echo "What do you want to do?" >&2
    echo "1) Install - Copy configs from this repo to your system" >&2
    echo "2) Update - Copy configs from your system to this repo" >&2
    echo "" >&2
    read -p "Select operation [1-2]: " choice

    case $choice in
        1) echo "install" ;;
        2) echo "update" ;;
        *)
            print_error "Invalid choice."
            exit 1
            ;;
    esac
}

# Get available programs by scanning the scripts directory
get_available_programs() {
    local operation=$1
    local programs=()

    if [ "$operation" == "install" ]; then
        # Look for install_*_config.sh scripts
        for script in "$SCRIPTS_SUBDIR"/install_*_config.sh; do
            if [ -f "$script" ]; then
                local basename=$(basename "$script")
                local program=$(echo "$basename" | sed 's/install_\(.*\)_config\.sh/\1/')
                programs+=("$program")
            fi
        done
    else
        # Look for update_*_repo.sh scripts
        for script in "$SCRIPTS_SUBDIR"/update_*_repo.sh; do
            if [ -f "$script" ]; then
                local basename=$(basename "$script")
                local program=$(echo "$basename" | sed 's/update_\(.*\)_repo\.sh/\1/')
                programs+=("$program")
            fi
        done
    fi

    echo "${programs[@]}"
}

# Select programs to process
select_programs() {
    local operation=$1
    local programs=($(get_available_programs "$operation"))

    if [ ${#programs[@]} -eq 0 ]; then
        print_error "No scripts found for operation: $operation"
        exit 1
    fi

    echo "Available programs:" >&2
    for i in "${!programs[@]}"; do
        echo "$((i+1))) ${programs[$i]}" >&2
    done
    echo "$((${#programs[@]}+1))) all" >&2
    echo "" >&2

    read -p "Select programs (comma-separated numbers or 'all'): " choice

    local selected_programs=()

    if [[ "$choice" == "$((${#programs[@]}+1))" ]] || [[ "$choice" == "all" ]]; then
        selected_programs=("${programs[@]}")
    else
        IFS=',' read -ra selections <<< "$choice"
        for sel in "${selections[@]}"; do
            sel=$(echo "$sel" | xargs) # trim whitespace
            if [[ "$sel" =~ ^[0-9]+$ ]] && [ "$sel" -ge 1 ] && [ "$sel" -le "${#programs[@]}" ]; then
                selected_programs+=("${programs[$((sel-1))]}")
            fi
        done
    fi

    if [ ${#selected_programs[@]} -eq 0 ]; then
        print_error "No valid programs selected."
        exit 1
    fi

    echo "${selected_programs[@]}"
}

# Execute operation for a program
execute_operation() {
    local operation=$1
    local program=$2

    print_info "Processing $program..."

    if [ "$operation" == "install" ]; then
        local script="$SCRIPTS_SUBDIR/install_${program}_config.sh"
    else
        local script="$SCRIPTS_SUBDIR/update_${program}_repo.sh"
    fi

    if [ ! -f "$script" ]; then
        print_error "Script not found: $script"
        return 1
    fi

    # Execute the script
    if bash "$script"; then
        print_success "$program completed successfully"
        return 0
    else
        print_error "$program failed"
        return 1
    fi
}

# Main interactive flow
main() {
    print_header

    # Step 1: Show and optionally change profile
    show_profile
    read -p "Change profile? [y/N]: " change_profile
    if [[ "$change_profile" =~ ^[Yy]$ ]]; then
        select_profile
    fi

    # Step 2: Select operation (install or update)
    echo ""
    operation=$(select_operation)
    echo ""

    # Step 3: Select programs
    programs=($(select_programs "$operation"))

    echo ""
    echo -e "${BLUE}Summary:${NC}"
    echo "  Operation: $operation"
    echo "  Profile: $(get_current_profile)"
    echo "  Programs: ${programs[*]}"
    echo ""

    read -p "Proceed? [y/N]: " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi

    echo ""
    echo "Executing..."
    echo ""

    # Execute operations
    local success_count=0
    local fail_count=0

    for program in "${programs[@]}"; do
        if execute_operation "$operation" "$program"; then
            ((success_count++)) || true
        else
            ((fail_count++)) || true
        fi
        echo ""
    done

    # Summary
    echo -e "${BLUE}================================${NC}"
    print_success "Completed: $success_count"
    if [ $fail_count -gt 0 ]; then
        print_error "Failed: $fail_count"
    fi
}

# Run main if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
