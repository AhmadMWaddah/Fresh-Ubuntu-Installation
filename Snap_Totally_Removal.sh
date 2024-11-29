#!/bin/bash

function remove_snap_packages() {
    for snap in $(snap list); do
        sudo snap remove "$snap" || { echo "Failed to remove $snap"; return 1; }
    done
    return 0
}

function remove_snapd() {
    sudo apt purge snapd || { echo "Failed to remove Snapd"; return 1; }
    sudo apt autoremove || { echo "Failed to autoremove packages"; return 1; }
    return 0
}

function prevent_snapd_reinstallation() {
    sudo apt-mark hold snapd || { echo "Failed to mark Snapd as held"; return 1; }
    return 0
}

function clean_up() {
    sudo rm -rf /var/snap /etc/snapd /var/lib/snapd || { echo "Failed to clean up configuration files"; return 1; }
    return 0
}

function main() {
    echo "Removing Snap and preventing its reinstallation..."
    if ! remove_snap_packages; then
        return 1
    fi
    if ! remove_snapd; then
        return 1
    fi
    if ! prevent_snapd_reinstallation; then
        return 1
    fi
    if ! clean_up; then
        return 1
    fi
    echo "Snap has been successfully removed and its reinstallation prevented."
    return 0
}

# Check if the script is being called as a function
if [[ "$0" != "$BASH_SOURCE" ]]; then
    main
    return $?
fi
