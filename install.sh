#!/bin/bash
#
# Standalone Dotfiles Installer
# This script installs a complete desktop environment based on the configuration
# files and package lists derived from your setup.
#

set -e # Exit immediately if a command exits with a non-zero status.

# --- Helper Functions for Logging ---
info() {
    echo -e "\033[34m[INFO]\033[0m $1"
}

success() {
    echo -e "\033[32m[SUCCESS]\033[0m $1"
}

warning() {
    echo -e "\033[33m[WARNING]\033[0m $1"
}

error() {
    echo -e "\033[31m[ERROR]\033[0m $1" >&2
    exit 1
}

# --- Package Definitions ---
# Packages to be installed from official Arch repositories
PACMAN_PACKAGES=(
    "alacritty"
    "avahi" 
    "bash-completion"
    "bat"
    "blueberry"
    "brightnessctl"
    "btop"
    "cargo"
    "clang"
    "cups"
    "cups-browsed"
    "cups-filters"
    "cups-pdf"
    "docker"
    "docker-buildx"
    "docker-compose"
    "dust"
    "evince"
    "expac"
    "eza"
    "fastfetch"
    "fcitx5"
    "fcitx5-gtk"
    "fcitx5-qt"
    "fd"
    "ffmpegthumbnailer"
    "fontconfig"
    "fzf"
    "github-cli"
    "gnome-calculator"
    "gnome-keyring"
    "gnome-themes-extra"
    "grim"
    "gum"
    "gvfs-mtp"
    "gvfs-nfs"
    "gvfs-smb"
    "hypridle"
    "hyprland"
    "hyprlock"
    "hyprpicker"
    "hyprsunset"
    "imagemagick"
    "imv"
    "inetutils"
    "inxi"
    "iwd"
    "jq"
    "kdenlive"
    "kvantum-qt5"
    "lazydocker"
    "lazygit"
    "less"
    "libsecret"
    "libyaml"
    "libqalculate"
    "libreoffice-fresh"
    "llvm"
    "luarocks"
    "mako"
    "man-db"
    "mariadb-libs"
    "mise"
    "mpv"
    "nautilus"
    "gnome-disk-utility"
    "noto-fonts"
    "noto-fonts-cjk"
    "noto-fonts-emoji"
    "noto-fonts-extra"
    "nss-mdns"
    "gedit"
    "nano"
    "obs-studio"
    "chromium"
    "pamixer"
    "playerctl"
    "plocate"
    "plymouth"
    "polkit-gnome"
    "postgresql-libs"
    "power-profiles-daemon"
    "python-gobject"
    "python-poetry-core"
    "qt5-wayland"
    "ripgrep"
    "sddm"
    "slurp"
    "starship"
    "sushi"
    "swaybg"
    "swayosd"
    "system-config-printer"
    "tldr"
    "tree-sitter-cli"
    "ttf-cascadia-mono-nerd"
    "ttf-jetbrains-mono-nerd"
    "ufw"
    "unzip"
    "waybar"
    "whois"
    "wireless-regdb"
    "wireplumber"
    "wl-clipboard"
    "woff2-font-awesome"
    "xdg-desktop-portal-gtk"
    "xdg-desktop-portal-hyprland"
    "xmlstarlet"
    "base-devel"
    "git"
    "limine"
    "snapper"
)

# Packages to be installed from the Arch User Repository (AUR)
AUR_PACKAGES=(
    "asdcontrol-bin"
    "gpu-screen-recorder"
    "aether"
    "elephant"
    "elephant-bluetooth"
    "elephant-calc"
    "elephant-clipboard"
    "elephant-desktopapplications"
    "elephant-files"
    "elephant-menus"
    "elephant-providerlist"
    "elephant-runner"
    "elephant-symbols"
    "elephant-todo"
    "elephant-unicode"
    "elephant-websearch"
    "hyprland-qtutils"
    "impala"
    "localsend-bin"
    "satty"
    "python-terminaltexteffects"
    "tzupdate"
    "uwsm"
    "walker"
    "wayfreeze"
    "wiremix"
    "yay"
    "yaru-icon-theme"
    "pinta"
    "spotify"
)

# --- Installation Functions ---

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to install the AUR helper (yay)
install_aur_helper() {
    if command_exists yay;
        then
        info "'yay' is already installed."
        return
    fi

    info "Installing AUR helper 'yay'..."
    if ! command_exists git;
        then
        error "'git' is not installed. Please install it before running this script."
    fi
    
    # Ensure we're in a safe directory for cloning
    local original_dir=$(pwd)
    cd /tmp

    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    # Return to original directory
    cd "$original_dir"
    rm -rf /tmp/yay # Clean up the cloned directory

    # Re-check if yay is now installed
    if ! command_exists yay; then
        error "Failed to install 'yay'. Please check the output for errors."
    fi
    success "'yay' has been installed."
}

# Function to install all defined packages
install_packages() {
    info "Starting package installation..."
    
    info "Updating pacman database and upgrading system..."
    sudo pacman -Syu --noconfirm
    
    info "Installing official repository packages..."
    sudo pacman -S --needed --noconfirm "${PACMAN_PACKAGES[@]}"
    
    install_aur_helper
    
    info "Installing AUR packages..."
    yay -S --needed --noconfirm "${AUR_PACKAGES[@]}"
    
    success "All packages have been installed."
}

# Function to copy configuration files
copy_configs() {
    info "Copying configuration files..."
    local source_dir
    source_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/.config"

    if [ ! -d "$source_dir" ]; then
        error "The .config directory was not found in the installer's location."
        return
    fi

    info "Backing up existing ~/.config to ~/.config.bak..."
    if [ -d "$HOME/.config" ]; then
        rsync -a --delete "$HOME/.config/" "$HOME/.config.bak/"
    fi

    info "Copying new .config files..."
    rsync -a "$source_dir/" "$HOME/.config/"
    
    success "Configuration files have been copied."
}

# Function to install helper scripts
install_helper_scripts() {
    info "Installing helper scripts..."
    local scripts_dir
    scripts_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/scripts"

    if [ ! -d "$scripts_dir" ]; then
        warning "Helper scripts directory not found at $scripts_dir. Skipping."
        return
    fi

    mkdir -p "$HOME/.local/bin"
    cp -r "$scripts_dir/"* "$HOME/.local/bin/"
    chmod +x "$HOME/.local/bin/"*
    success "Helper scripts installed to ~/.local/bin/."
    info "Please ensure ~/.local/bin is in your PATH. You may need to add 'export PATH=\"$HOME/.local/bin:\$PATH\"' to your shell config."
}

# Function to apply system-level configurations
apply_system_configs() {
    info "Applying system-level configurations..."

    # Git configuration
    if [[ -z "$(git config --global user.name)" ]]; then
        read -rp "Enter your full name for Git: " git_name
        git config --global user.name "$git_name"
    fi
    if [[ -z "$(git config --global user.email)" ]]; then
        read -rp "Enter your email for Git: " git_email
        git config --global user.email "$git_email"
    fi

    # Docker setup
    info "Setting up Docker..."
    sudo systemctl enable docker.service
    sudo usermod -aG docker "${USER}"
    sudo mkdir -p /etc/docker
    sudo tee /etc/docker/daemon.json >/dev/null <<'EOF'
{
    "log-driver": "json-file",
    "log-opts": { "max-size": "10m", "max-file": "5" }
}
EOF

    # Firewall setup
    info "Setting up firewall (UFW)..."
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow 53317/tcp # LocalSend
    sudo ufw allow 53317/udp # LocalSend
    sudo ufw --force enable
    sudo systemctl enable ufw.service
    
    # SDDM (Login Manager) setup
    info "Setting up SDDM..."
    sudo mkdir -p /etc/sddm.conf.d
    sudo tee /etc/sddm.conf.d/autologin.conf >/dev/null <<EOF
[Autologin]
User=${USER}
Session=hyprland

[Theme]
Current=breeze
EOF
    sudo systemctl enable sddm.service

    # Hardware Fixes
    info "Applying common hardware fixes..."
    # Fix for F-keys on Apple-like keyboards
    echo "options hid_apple fnmode=2" | sudo tee /etc/modprobe.d/hid_apple.conf
    # Disable USB autosuspend
    echo "options usbcore autosuspend=-1" | sudo tee /etc/modprobe.d/disable-usb-autosuspend.conf
    # Ignore power button press for custom bindings
    sudo sed -i 's/.*HandlePowerKey=.*/HandlePowerKey=ignore/' /etc/systemd/logind.conf

    # Bootloader and Snapper setup
    info "Configuring bootloader (Limine) and snapshots (Snapper)..."
    if command_exists limine && command_exists snapper; then
        sudo snapper -c root create-config /
        sudo snapper -c home create-config /home
        sudo sed -i 's/^TIMELINE_CREATE="yes"/TIMELINE_CREATE="no"/' /etc/snapper/configs/{root,home}
        sudo sed -i 's/^NUMBER_LIMIT="50"/NUMBER_LIMIT="10"/' /etc/snapper/configs/{root,home}
        sudo systemctl enable snapper-timeline.timer snapper-cleanup.timer
    fi

    # Update local database for 'locate' command
    info "Updating file database..."
    sudo updatedb

    success "System configurations applied."
}


# --- Main Execution ---
main() {
    info "Starting Standalone Dotfiles Installation."
    
    if [ "$EUID" -eq 0 ]; then
        error "This script must not be run as root. Run it as your regular user."
    fi

    install_packages
    copy_configs
    install_helper_scripts
    apply_system_configs

    success "Installation complete!"
    info "It is highly recommended to reboot your system now."
    read -rp "Reboot now? (y/N) " choice
    if [[ "$choice" =~ ^[Yy]$ ]]; then
        systemctl reboot
    fi
}

# Run the main function
main
