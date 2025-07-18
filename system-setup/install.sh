#!/usr/bin/env bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

export XDG_CONFIG_HOME="$HOME/.config"

# Update and upgrade system
echo "Updating and upgrading system..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl gnome-tweaks build-essential git

# Configure Git
echo "Configuring Git..."
git config --global user.name "brijesh"
git config --global user.email "145837789+brijesh-0@users.noreply.github.com"

# Installing Fonts
echo "Installing Fonts..."
sudo apt install fonts-inter-variable fonts-firacode ttf-mscorefonts-installer

# install Chromium Browser
echo "Installing Brave Browser..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update
sudo apt install brave-browser vlc

echo "Installing Snaps..."
sudo snap install bitwarden keepassxc localsend pdfarranger libreoffice
sudo snap install nvim obsidian code --classic

# installs nvm (Node Version Manager)
echo "Installing NodeJS and NPM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install 20

# Cleanup and Final Install
echo "Cleaning up..."
sudo apt autoremove -y
sudo apt update && sudo apt upgrade -y

echo -e "\n\n${GREEN}Installation and configuration complete!${NC}"
