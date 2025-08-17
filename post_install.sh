#!/bin/bash

TEMP=stmp
# FORKED FROM https://github.com/Angxddeep/Fedora-Freedom

color_echo() {
    local color="$1"
    local text="$2"
    case "$color" in
        "red")     echo -e "\033[0;31m$text\033[0m" ;;
        "green")   echo -e "\033[0;32m$text\033[0m" ;;
        "yellow")  echo -e "\033[1;33m$text\033[0m" ;;
        "blue")    echo -e "\033[0;34m$text\033[0m" ;;
        *)         echo "$text" ;;
    esac
}

installflathub() {
    color_echo "yellow" "Enabling Flathub..."
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    color_echo "green" "Flathub Enabled"
}
installflathub

removefedoraflatpak() {
    color_echo "yellow" "Checking for Fedora Flatpak..."
    if flatpak remotes | grep -q fedora; then
        color_echo "yellow" "Removing Fedora Flatpak..."
        if flatpak remote-delete fedora; then
            color_echo "green" "Fedora Flatpak removed"
        else
            color_echo "red" "Failed to remove Fedora Flatpak"
            exit 1
        fi
    else
        color_echo "green" "Fedora Flatpak is not installed"
    fi
}
removefedoraflatpak

installRPMFusion() {
    if [ ! -e /etc/yum.repos.d/rpmfusion-free.repo ] || [ ! -e /etc/yum.repos.d/rpmfusion-nonfree.repo ]; then
        color_echo "yellow" "Installing RPM Fusion..."
        sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
        sudo dnf config-manager setopt rpmfusion-nonfree-updates.enabled=1
        sudo dnf config-manager setopt rpmfusion-free-updates.enabled=1
        color_echo "green" "RPM Fusion installed and enabled"
    else
        color_echo "green" "RPM Fusion already installed"
    fi
}
installRPMFusion

installFFmpeg() {
    color_echo "yellow" "Installing FFmpeg..."
    sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
    if [ $? -ne 0 ]; then
        color_echo "red" "Failed to install FFmpeg"
        exit 1
    fi
    color_echo "green" "FFmpeg installed"
}
installFFmpeg



# SWAY SETUP
sudo dnf install light sway swaybg swayidle swayimg swaylock waybar wofi fontawesome-fonts-all
sudo dnf install mc geany
sudo dnf install fish
sudo dnf install jetbrains-mono-fonts-all

mkdir -p $TEMP && cd $TEMP

mkdir -p $TEMP && cd $TEMP


## DOWNLOADING DOTFILES
color_echo "yellow" "Starting download"


#rofi
mkdir -p rofi

cd rofi

curl -o config.rasi https://raw.githubusercontent.com/Dewliak/dotfiles/refs/heads/main/rofi/config.rasi

cd ..
color_echo "green" "Rofi finished"

#sway
mkdir -p sway

cd sway

curl -o audio.sh https://raw.githubusercontent.com/Dewliak/dotfiles/refs/heads/main/sway/audio.sh
curl -o config https://raw.githubusercontent.com/Dewliak/dotfiles/refs/heads/main/sway/config
curl -o exit.sh https://raw.githubusercontent.com/Dewliak/dotfiles/refs/heads/main/sway/exit.sh
curl -o lock_screen.sh https://raw.githubusercontent.com/Dewliak/dotfiles/refs/heads/main/sway/lock_screen.sh
curl -L -o wallpaper.jpg https://raw.githubusercontent.com/Dewliak/dotfiles/refs/heads/main/sway/wallpaper.jpg

cd ..
color_echo "green" "Sway finished"

#swaylock
mkdir -p swaylock
mkdir -p swaylock/img

cd swaylock

curl -o lock_screen.sh https://raw.githubusercontent.com/Dewliak/dotfiles/refs/heads/main/swaylock/lock.sh

cd img

curl -L -o lock.jpg https://raw.githubusercontent.com/Dewliak/dotfiles/refs/heads/main/swaylock/img/lock.jpg

cd ../..
color_echo "green" "Swaylock finished"

#waybar
mkdir -p waybar

cd waybar

curl -o config https://raw.githubusercontent.com/Dewliak/dotfiles/refs/heads/main/waybar/config
curl -o style.css https:///raw.githubusercontent.com/Dewliak/dotfiles/blob/main/waybar/style.css

cd ..
color_echo "green" "Waybar finished"

#wofi
mkdir -p wofi

cd wofi

curl -o config https://raw.githubusercontent.com/Dewliak/dotfiles/refs/heads/main/wofi/config
curl -o style.css https://raw.githubusercontent.com/Dewliak/dotfiles/refs/heads/main/wofi/style.css

cd ..
color_echo "green" "Wofi finished"

## COPYING DOTFILES

color_echo "yellow" "Starting COPY"

target_dir="$HOME/.config/"

sudo cp -r "rofi" "$target_dir"
sudo cp -r "sway" "$target_dir"
sudo cp -r "swaylock" "$target_dir"
sudo cp -r "waybar" "$target_dir"
sudo cp -r "wofi" "$target_dir"


mkdir -p foot
cd foot
touch foot.ini
cd ..
