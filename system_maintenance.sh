#!/bin/bash

# Function to log messages
log_message() {
    local message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $message"
}

# Function to update package lists
update_system() {
    log_message "Starting system update..."
    sudo apt update
    if [ $? -eq 0 ]; then
        log_message "System update completed successfully."
    else
        log_message "System update failed."
        exit 1
    fi
}

# Function to upgrade packages
upgrade_system() {
    log_message "Starting system upgrade..."
    sudo apt upgrade -y
    if [ $? -eq 0 ]; then
        log_message "System upgrade completed successfully."
    else
        log_message "System upgrade failed."
        exit 1
    fi
}

# Function to clean up package cache
clean_system() {
    log_message "Cleaning up package cache..."
    sudo apt autoremove -y
    sudo apt clean -y
    sudo apt autoclean -y
    log_message "System cleanup completed."
}

# Main function to orchestrate tasks
main() {
    log_message "Script execution started."
    update_system
    upgrade_system
    clean_system
    log_message "Script execution finished successfully."
}

# Run the main function
main
