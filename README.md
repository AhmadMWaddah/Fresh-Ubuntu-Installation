
# System Automation Scripts Documentation

This set of bash scripts is designed to automate system maintenance, configuration, and application installation tasks for Ubuntu-based systems. Each script serves a specific purpose and can be run independently, but they are intended to be orchestrated by a main script for a smoother experience. Below is an overview of the four key scripts.

---

## 1. `main_script.sh`

### Purpose:
The `main_script.sh` file is the central control script that orchestrates the execution of the other scripts in a sequential order. It ensures that each script runs successfully, logs progress, and exits gracefully if any errors occur.

### Key Features:
- Automatically sources and runs the other scripts in the same directory.
- Validates the presence of dependent scripts before executing.
- Logs status messages to the terminal for easy tracking.
- Executes the system maintenance, configurations, and installations in sequence.

### How to Use:
Simply run the script to execute all tasks:
```bash
bash main_script.sh
```

---

## 2. `system_maintenance.sh`

### Purpose:
This script is responsible for system maintenance tasks like updating packages, upgrading them to the latest versions, and cleaning up unnecessary files. It is a typical system maintenance operation that helps keep the system running smoothly.

### Tasks Performed:
1. **Update and Upgrade System Packages**:
    - Runs `apt update` to fetch updates for all installed packages.
    - Runs `apt upgrade -y` to install available updates for all packages.

2. **Clean Up System**:
    - `apt autoremove -y`: Removes packages that were installed as dependencies but are no longer required.
    - `apt clean -y`: Clears the local package cache, freeing up disk space.
    - `apt autoclean -y`: Removes obsolete package files that are no longer available for download.

### How to Use:
If you need to perform system maintenance independently, run the script:
```bash
bash system_maintenance.sh
```

---

## 3. `configurations.sh`

### Purpose:
This script applies various essential system configurations to improve the user experience and system performance. It focuses on configuring the GNOME desktop environment and optimizing system settings.

### Tasks Performed:
1. **Enable Minimize on Click**:
    - Configures GNOME's `dash-to-dock` extension to minimize windows when you click on their respective dock icons, improving workflow efficiency.

2. **Adjust Swappiness**:
    - The script modifies the value of `vm.swappiness` in the `/etc/sysctl.conf` file to improve system performance, particularly in systems with sufficient RAM. It reduces the system's tendency to swap data to disk.

### How to Use:
Run the script independently if you need to apply the configurations:
```bash
bash configurations.sh
```

---

## 4. `install_packages.sh`

### Purpose:
This script installs a list of essential packages, utilities, and applications for an Ubuntu-based system. It also configures Sublime Text with required settings, such as installing `Package Control` for managing plugins.

### Packages Installed:
1. **Command-Line Tools**:
    - `git`: A version control system widely used in software development.
    - `wget`: A tool to download files from the web using the command line.
    - `curl`: A tool for transferring data with URL syntax, commonly used in scripts.
    - `tldr`: Simplified and community-contributed man pages for easy reference.
    - `vim`: A powerful text editor (used as a prerequisite for Neovim).
    - `neovim`: A modernized version of vim with added features and plugins.

2. **Media and Productivity Tools**:
    - `ubuntu-restricted-extras`: A collection of commonly used codecs and fonts for multimedia applications.
    - `gimp`: A powerful image editing tool, similar to Photoshop.
    - `libreoffice`: A free office suite for word processing, spreadsheets, and presentations.
    - `smplayer`: A media player for playing video and audio files.

3. **System Utilities**:
    - `gnome-tweak-tool`: A tool for configuring various GNOME desktop environment settings.
    - `dconf-editor`: A low-level configuration editor for GNOME settings.
    - `tlp`: A tool that improves battery life and power management for laptops.
    - `libfuse2`: A library for filesystems in user space, required for some applications.
    - `gnome-shell-extension-manager`: A tool for managing GNOME extensions.

4. **Browsers**:
    - **Brave Browser**: A privacy-focused browser that blocks ads and trackers by default.
    - **Vivaldi Browser**: A highly customizable browser with a range of features, from tab management to privacy settings.

5. **Development Tools**:
    - **Sublime Text Editor**: A lightweight, fast text editor for coding, offering an elegant user interface and powerful features.

6. **Other Utilities**:
    - **Ventoy**: A tool for creating bootable USB drives.
    - **Oh My Bash**: A framework for managing bash configurations and improving the command-line experience.

### Sublime Text Configuration:
- Installs `Package Control`, which allows users to install and manage plugins easily.
- Configures Sublime Text with default settings, including theme, color scheme, and font settings. For example:
    ```json
    {
        "theme": "Adaptive.sublime-theme",
        "color_scheme": "Mariana.sublime-color-scheme",
        "font_size": 12,
        "ignored_packages": [],
        "show_tabs": true
    }
    ```

### How to Use:
Run this script to install the packages and set up Sublime Text:
```bash
bash install_packages.sh
```

---

## Post-Installation Steps

After running all the scripts, you should manually install additional themes, icons, and extensions to complete your system setup. These can include:
- **Install GNOME Themes and Icons**: You can find and install additional themes and icons via the GNOME Extensions website or from other sources.
- **Install GNOME Extensions**: Use the `gnome-shell-extension-manager` to easily install extensions that enhance your desktop experience.

---

## Requirements
- Ubuntu-based system (20.04 or newer is recommended).
- `sudo` privileges for package installation and system configurations.

---

## Contributing

If you'd like to contribute improvements or new features to these scripts, please fork this repository and follow the typical GitHub pull request process:

1. Fork the repository.
2. Create a new branch:
    ```bash
    git checkout -b feature/your-feature-name
    ```
3. Commit your changes and push to your fork.
4. Open a pull request with a description of your changes.

---

## License

This project is licensed under the MIT License. You can view the full text of the MIT License [here](https://opensource.org/licenses/MIT).

---

## Acknowledgments
- Special thanks to the open-source community for providing essential tools and resources.
- Thanks to Sublime Text for providing a powerful and customizable text editor.

---

This documentation provides a full explanation of the system automation scripts, how to use them, and their key features and packages. The scripts are designed to simplify system setup and maintenance, while ensuring that important configurations and applications are installed correctly.


---


# Snap Totally Removal Documentation

This script is designed to completely remove Snap from an Ubuntu-based system. It ensures a clean removal of all Snap-related files and directories, preventing potential conflicts with traditional package managers or alternative application formats.

---

## Purpose:
The `Snap Totally Removal` script automates the process of removing Snap and its associated components. This is especially useful for users who prefer to avoid Snap packages or experience issues with Snap-based applications.

---

## Key Features:
1. **Uninstall Snapd**:
   - Removes the `snapd` package and its dependencies.
   - Ensures no traces of the Snap service remain active on the system.

2. **Purge Snap Directories**:
   - Deletes all files and directories created by Snap, including:
     - `/snap`
     - `/var/snap`
     - `/var/lib/snapd`
     - `~/snap`

3. **System Cleanup**:
   - Ensures all residual files, configurations, and system references to Snap are removed.

---

## How to Use:

### Prerequisites:
- An Ubuntu-based system (20.04 or newer is recommended).
- `sudo` privileges to execute system-level commands.

### Execution:
To run the script, execute the following command:
```bash
bash Snap_Totally_Removal.sh
```

This will:
1. Prompt for confirmation before executing critical actions.
2. Display progress messages for each step of the removal process.
3. Provide a summary of actions performed upon completion.

---

## Key Steps Performed by the Script:

### 1. Remove `snapd`:
The script uninstalls Snap and its associated service using:
```bash
sudo apt remove --purge snapd -y
```

### 2. Delete Snap Directories:
The following directories are recursively deleted to remove all traces of Snap:
```bash
sudo rm -rf /snap /var/snap /var/lib/snapd ~/snap
```

### 3. Update System Packages:
To ensure a clean environment post-removal, the script updates the system:
```bash
sudo apt update && sudo apt upgrade -y
```

---

## Post-Removal Recommendations:

After running this script, consider installing alternative application formats like `.deb` packages, Flatpak, or AppImages for application management.

For Flatpak, you can install and set it up using:
```bash
sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

---

## Requirements:
- Ubuntu-based system (20.04 or newer).
- `sudo` privileges.

---

## Contributing:

If you'd like to improve or add features to this script, please fork the repository and follow the standard GitHub contribution workflow:

1. Fork the repository.
2. Create a feature branch:
    ```bash
    git checkout -b feature/your-feature-name
    ```
3. Commit your changes and push them to your fork.
4. Open a pull request with a clear description of your changes.

---

## License:

This project is licensed under the MIT License. You can view the full text of the MIT License [here](https://opensource.org/licenses/MIT).

---

## Acknowledgments:

- Thanks to the open-source community for providing resources and tools that inspired the development of this script.
- Special thanks to Ubuntu users who share best practices for system customization.

---

This documentation ensures clarity on the purpose, usage, and functionality of the Snap Totally Removal script, designed to simplify and automate the complete removal of Snap from Ubuntu systems.
