#!/bin/bash

# Function to log messages
log_message() {
    local message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $message"
}

# Function to set GNOME "Minimize by Clicking" option
set_gnome_minimize_click() {
    log_message "Configuring GNOME to minimize windows by clicking on dock icons..."
    gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
    if [ $? -eq 0 ]; then
        log_message "GNOME configuration updated successfully."
    else
        log_message "Error: Failed to update GNOME configuration."
        exit 1
    fi
}

# Function to update swappiness value in /etc/sysctl.conf
update_swappiness() {
    local original_line="vm.swappiness=60"
    local new_line="vm.swappiness=10"
    local config_file="/etc/sysctl.conf"

    log_message "Checking if $config_file exists."
    if [ ! -f "$config_file" ]; then
        log_message "Error: $config_file not found."
        exit 1
    fi

    log_message "Updating swappiness value in $config_file..."
    sudo sed -i "s/^$original_line\$/$new_line/" "$config_file"

    if grep -q "^$new_line\$" "$config_file"; then
        log_message "Swappiness value updated successfully."
    else
        log_message "Error: Failed to update swappiness value in $config_file."
        exit 1
    fi

    log_message "Reloading sysctl settings..."
    sudo sysctl -p >/dev/null 2>&1
    log_message "Swappiness settings reloaded."
}

# Main function to apply all configurations
main() {
    log_message "Script execution started."
    set_gnome_minimize_click
    update_swappiness
    log_message "All configurations applied successfully."
}

# Export functions if needed for the caller script
export -f log_message set_gnome_minimize_click update_swappiness main
