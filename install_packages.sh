#!/bin/bash

# Function to log messages
log_message() {
    local message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $message"
}

# Function to install packages
install_package() {
    local package=$1
    if ! dpkg -l | grep -qw "$package"; then
        log_message "Installing $package..."
        sudo apt install -y "$package"
        if [ $? -eq 0 ]; then
            log_message "$package installed successfully."
        else
            log_message "Error: Failed to install $package."
            exit 1
        fi
    else
        log_message "$package is already installed."
    fi
}

# Function to install Sublime Text
install_sublime_text() {
    log_message "Installing Sublime Text Editor..."
    if ! dpkg -l | grep -qw sublime-text; then
        wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo gpg --dearmor -o /usr/share/keyrings/sublime-text-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/sublime-text-keyring.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
        sudo apt update
        sudo apt install -y sublime-text

        # Configure Sublime Text after installation
        configure_sublime_text
    else
        log_message "Sublime Text Editor is already installed."
        configure_sublime_text
    fi
}

# Function to configure Sublime Text
configure_sublime_text() {
    log_message "Configuring Sublime Text..."

    # Define Sublime configuration directories
    local sublime_config_dir="$HOME/.config/sublime-text/Packages/User"
    local sublime_package_control_url="https://packagecontrol.io/Package%20Control.sublime-package"
    local sublime_installed_packages_dir="$HOME/.config/sublime-text/Installed Packages"

    # Create necessary directories
    mkdir -p "$sublime_config_dir"
    mkdir -p "$sublime_installed_packages_dir"

    # Download and install Package Control
    log_message "Installing Package Control for Sublime Text..."
    if [ ! -f "$sublime_installed_packages_dir/Package Control.sublime-package" ]; then
        wget -q -O "$sublime_installed_packages_dir/Package Control.sublime-package" "$sublime_package_control_url"
        log_message "Package Control installed successfully."
    else
        log_message "Package Control is already installed."
    fi

    # Create a basic `Preferences.sublime-settings` file
    log_message "Setting up default preferences for Sublime Text..."
    cat >"$sublime_config_dir/Preferences.sublime-settings" <<EOL
{
    "theme": "Adaptive.sublime-theme",
    "color_scheme": "Mariana.sublime-color-scheme",
    "font_size": 12,
    "ignored_packages": [],
    "show_tabs": true
}
EOL

    # Add a reminder for manual theme and plugin installation
    log_message "Sublime Text configuration completed. Don't forget to install additional themes and plugins!"
}

# Function to install Brave Browser
install_brave() {
    log_message "Installing Brave Browser..."
    if ! dpkg -l | grep -qw brave-browser; then
        sudo curl -fsSL https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/brave-browser-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
        sudo apt update
        sudo apt install -y brave-browser
    else
        log_message "Brave Browser is already installed."
    fi
}

# Function to install Vivaldi Browser
install_vivaldi() {
    log_message "Installing Vivaldi Browser..."
    if ! dpkg -l | grep -qw vivaldi-stable; then
        wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/vivaldi-browser-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser-keyring.gpg] https://repo.vivaldi.com/archive/deb/ stable main" | sudo tee /etc/apt/sources.list.d/vivaldi.list
        sudo apt update
        sudo apt install -y vivaldi-stable
    else
        log_message "Vivaldi Browser is already installed."
    fi
}

# Main function to install all packages
main() {
    log_message "Starting package installations..."
    sudo apt update
    sudo apt upgrade -y

    # Core packages
    install_package git
    install_package wget
    install_package curl
    install_package vim  # Needed before nvim
    install_package neovim
    install_package tldr
    install_package ubuntu-restricted-extras
    install_package libfuse2
    install_package gimp
    install_package gnome-tweak-tool
    install_package dconf-editor
    install_package tlp
    install_package libreoffice
    install_package smplayer
    install_package gnome-shell-extension-manager

    # Custom installations
    install_brave
    install_vivaldi
    install_sublime_text

    # Additional reminders
    log_message "Installation complete. Don't forget to manually install themes, icons, and extensions!"
}

# Export functions if needed for the caller script
export -f log_message install_package install_brave install_vivaldi install_sublime_text configure_sublime_text main
