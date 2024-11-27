#!/bin/bash

# Get the directory of the current script (ensures portability)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to source and execute a script's main function
run_script() {
    local script_name=$1
    local script_path="$SCRIPT_DIR/$script_name"

    echo "Preparing to run: $script_name"

    # Check if the script exists
    if [ -f "$script_path" ]; then
        echo "Sourcing and executing $script_name..."
        source "$script_path"
        main
    else
        echo "Error: $script_name not found at $script_path"
        exit 1
    fi
}

# Call system_maintenance.sh
run_script "system_maintenance.sh"

# Call configurations.sh
run_script "configurations.sh"

# Call install_packages.sh
run_script "install_packages.sh"

echo "All scripts executed successfully!"
