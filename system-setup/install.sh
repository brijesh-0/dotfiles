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
sudo apt install -y curl gnome-tweaks build-essential git tree

# Configure Git
echo "Configuring Git..."
git config --global user.name "brijesh"
git config --global user.email "145837789+brijesh-0@users.noreply.github.com"

# Installing Fonts
echo "Installing Fonts..."
sudo apt install fonts-firacode ttf-mscorefonts-installer

# install fishshell keyring
sudo add-apt-repository ppa:fish-shell/release-4

# install Chromium Browser
echo "Installing Brave Browser..."
curl -fsS https://dl.brave.com/install.sh | sh

sudo apt update
sudo apt install vlc fish

echo "Installing Snaps..."
sudo snap install bitwarden keepassxc localsend pdfarranger onlyoffice-desktopeditors
sudo snap install nvim --classic
sudo snap install obsidian --classic
sudo snap install codium --classic

# installs nvm (Node Version Manager)
# echo "Installing NodeJS and NPM..."
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# nvm install 20

# install FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install Zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Install fd and bat
sudo apt install fd-find bat
ln -s $(which fdfind) ~/.local/bin/fd  # add to local path as fd
ln -s $(which batcat) ~/.local/bin/bat # add to local path as bat

# install ripgrep
sudo apt-get install ripgrep

# Cleanup and Final Install
echo "Cleaning up..."
sudo apt autoremove -y
sudo apt update && sudo apt upgrade -y

echo -e "\n\n${GREEN}Installation and configuration complete!${NC}"
