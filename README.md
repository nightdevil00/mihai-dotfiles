# Mihai's Hyprland Dotfiles

This repository contains my personal dotfiles for a fully functional and customized Hyprland desktop environment on Arch Linux. It aims to provide a complete setup, from core window manager configurations to application settings and helper scripts.

## Features

*   **Hyprland Configuration:** Comprehensive setup for Hyprland, including modular configurations for monitors, input, keybindings, environment variables, look and feel, and autostart applications.
    *   **Dynamic GPU Configuration:** Automatically detects NVIDIA or AMD GPUs and sets appropriate environment variables for optimal Hyprland performance.
    *   **Wayland/X11 Compatibility:** Ensures smooth operation for Qt, GTK, and Electron/Chromium applications on Wayland, with X11 fallbacks.
*   **Custom Helper Scripts:** A collection of utility scripts for common tasks like launching applications, managing windows, taking screenshots, screen recording, and more, integrated directly into Hyprland keybindings.
*   **Extensive Application Configuration:** Pre-configured settings for a wide range of applications, ensuring a consistent experience (e.g., Alacritty, Neovim, Waybar, Btop, Fastfetch, Spotify, Obsidian, etc.).
*   **Centralized Dotfiles Menu (SUPER + SPACE):** A `fuzzel`-based menu providing quick access to:
    *   **Power Menu:** Lock, Logout, Reboot, Shutdown, Suspend, Hibernate.
    *   **Show App Menu:** Launch applications via `fuzzel`.
    *   **Wallpaper Management:** Change wallpaper (select from available), Restart wallpaper (set new random).
    *   **Web App Launcher Creator:** Generate `.desktop` files for web applications.
    *   **Software Installer:** Categorized installation for gaming, editors, terminals, video players, and programming tools, with individual package selection and Flatpak support.
    *   **Font Management:** Install new fonts and apply them to specific applications (Alacritty, Kitty, Waybar) or system-wide (Fontconfig, GTK).
    *   **Default Application Configuration:** Set default terminal, browser, editor, video player, and email client.
    *   **System Update:** Check for and install Pacman and AUR updates.
    *   **Browse & Install Packages:** Interactive search and installation of Pacman or AUR packages.
    *   **Update Dotfiles:** Pull latest changes from the Git repository.
*   **Keybinding Viewer (SUPER + K):** A script to display all active keybindings.
*   **Clipboard History (SUPER + V):** Integrated `cliphist` for Wayland clipboard history.
*   **Fastfetch Configuration:** Customized `fastfetch` display for Arch Linux, including system age.
*   **Automated Installation:** An `install.sh` script to automate the setup process, including package installation and configuration deployment.

## Screenshots

*(Consider adding screenshots here once your setup is complete)*

## Prerequisites

Before proceeding with the installation, ensure you have:

*   **Arch Linux (or an Arch-based distribution):** The `install.sh` script uses `pacman` and `yay` for package management.
*   **Git:** For cloning this repository.
*   **`sudo` privileges:** The installation script performs system-level changes.

## Installation

Follow these steps to set up your system with these dotfiles:

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/nightdevil00/mihai-dotfiles.git ~/.config/mihai-dotfiles
    cd ~/.config/mihai-dotfiles
    ```

2.  **Make the `install.sh` script executable:**
    ```bash
    chmod +x install.sh
    ```

3.  **Run the installation script:**
    ```bash
    ./install.sh
    ```
    The script will:
    *   Install all necessary packages from official repositories and the AUR (including `git`, `yay`, `flatpak`, `rsync`, `cliphist`, `gum`, `jq`, `tte`, `swaybg`, `blueman`, `networkmanager-applet`, `docker`, `docker-compose`).
    *   Copy configuration files to their respective locations (`~/.config/`, `~/.local/bin/`).
    *   Apply system-level configurations (Docker, UFW, SDDM, etc.).
    *   Dynamically configure GPU environment variables based on detected hardware (NVIDIA/AMD).
    *   You will be prompted for your `sudo` password and some Git configuration details.

4.  **Reboot your system** when prompted by the installer.

## Usage

*   **Dotfiles Menu:** Press `SUPER + SPACE` to open the main dotfiles menu.
*   **Show Keybindings:** Press `SUPER + K` to view a list of active keybindings.
*   **Clipboard History:** Press `SUPER + V` to access your clipboard history.

## Directory Structure

*   `.config/`: Contains all application-specific configurations, which will be copied to `~/.config/`.
    *   `hypr/`: Hyprland configurations (bindings, autostart, envs, etc.).
    *   `dotfiles/`: Contains theme-related configurations and custom defaults.
        *   `branding/`: Branding files (e.g., `screensaver.txt`).
        *   `current/`: Symlinks to the currently active theme.
        *   `default_browser.txt`: Stores the user's default browser choice.
    *   `wallpapers/`: Directory for user-provided wallpapers.
*   `scripts/`: Custom helper scripts, copied to `~/.local/bin/`.
*   `install.sh`: The main installation script.

## Customization

*   **Themes:** Use the "Apply Font" option in the Dotfiles Menu to change fonts. For other theming, modify individual application configuration files under `~/.config/`.
*   **Keybindings:** Modify `~/.config/hypr/bindings.conf` or use the "Show Keybindings" script as a reference.
*   **Autostart:** Add applications to `~/.config/hypr/autostart.conf` to have them launch with Hyprland.
*   **Application Settings:** Adjust individual application configurations within their respective directories under `~/.config/`.
*   **Wallpapers:** Place your desired wallpapers in `~/.config/wallpapers`.

## Important Notes / Troubleshooting

*   **VM Environments:** If running in a VM and encountering display issues (e.g., black screen), try commenting out the NVIDIA and AMD specific environment variables in `~/.config/hypr/envs.conf` as they are optimized for physical hardware.
*   **Theme Symlinks:** During the initial setup of these dotfiles, some theme directories were originally symlinks to absolute paths. This has been corrected in the repository by embedding the actual theme files. If you encounter issues with themes, ensure they are actual directories and not broken symlinks.
*   **SSH Key Setup:** If you encounter "Permission denied (publickey)" errors when pushing to GitHub, ensure your SSH key is correctly generated, added to your SSH agent, and registered with your GitHub account.
*   **Updating Dotfiles:** Use the "Update Dotfiles" option in the main menu to pull the latest changes from the Git repository. This will update your local dotfiles repository and then re-apply configurations. Note that local modifications to tracked files will be overwritten.