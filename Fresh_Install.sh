#!/bin/bash

# Get the directory of the current script (ensures portability)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to log messages with a timestamp
log() {
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$timestamp: $1"
}

# Function to source and execute a script's main function
run_script() {
    local script_name="$1"
    local script_path="$SCRIPT_DIR/$script_name"

    log "Preparing to run: $script_name"

    if [[ -f "$script_path" ]]; then
        log "Sourcing and executing $script_name..."
        source "$script_path"
        main
        log "$script_name executed successfully."
    else
        log "Error: $script_name not found at $script_path"
        exit 1
    fi
}

# Define an array of scripts to run
scripts=("system_maintenance.sh" "configurations.sh" "install_packages.sh" "remove_snap.sh")

# Iterate over the scripts and execute them
for script in "${scripts[@]}"; do
    log "Starting $script tasks..."
    run_script "$script"
    log "$script tasks completed."
done

log "All tasks completed successfully!"
