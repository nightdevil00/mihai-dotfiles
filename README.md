# Mihai's Hyprland Dotfiles

This repository contains my personal dotfiles for a fully functional and customized Hyprland desktop environment on Arch Linux. It aims to provide a complete setup, from core window manager configurations to application settings and helper scripts.

## Features

*   **Hyprland Configuration:** Comprehensive setup for Hyprland, including modular configurations for monitors, input, keybindings, environment variables, look and feel, and autostart applications.
*   **Custom Helper Scripts:** A collection of utility scripts for common tasks like launching applications, managing windows, taking screenshots, screen recording, and more, integrated directly into Hyprland keybindings.
*   **Extensive Application Configuration:** Pre-configured settings for a wide range of applications, ensuring a consistent experience (e.g., Alacritty, Neovim, Waybar, Btop, Fastfetch, Spotify, Obsidian, etc.).
*   **Theme Management:** Includes various themes for a personalized visual experience.
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
    *   Install all necessary packages from official repositories and the AUR.
    *   Copy configuration files to their respective locations (`~/.config/`, `~/.local/bin/`).
    *   Apply system-level configurations (Docker, UFW, SDDM, etc.).
    *   You will be prompted for your `sudo` password and some Git configuration details.

4.  **Reboot your system** when prompted by the installer.

## Directory Structure

*   `.config/`: Contains all application-specific configurations, which will be copied to `~/.config/`.
    *   `hypr/`: Hyprland configurations.
    *   `dotfiles/`: Contains theme-related configurations.
        *   `themes/`: Various themes.
        *   `current/`: Symlinks to the currently active theme.
*   `scripts/`: Custom helper scripts, copied to `~/.local/bin/`.
*   `install.sh`: The main installation script.

## Customization

*   **Themes:** You can switch themes by updating the symlink in `~/.config/dotfiles/current/theme` to point to a different theme in `~/.config/dotfiles/themes/`.
*   **Keybindings:** Modify `~/.config/hypr/bindings.conf` to change or add new keybindings.
*   **Autostart:** Add applications to `~/.config/hypr/autostart.conf` to have them launch with Hyprland.
*   **Application Settings:** Adjust individual application configurations within their respective directories under `~/.config/`.

## Important Notes / Troubleshooting

*   **Theme Symlinks:** During the initial setup of these dotfiles, some theme directories were originally symlinks to absolute paths. This has been corrected in the repository by embedding the actual theme files. If you encounter issues with themes, ensure they are actual directories and not broken symlinks.
*   **SSH Key Setup:** If you encounter "Permission denied (publickey)" errors when pushing to GitHub, ensure your SSH key is correctly generated, added to your SSH agent, and registered with your GitHub account.
