# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Update and upgrade system
echo "Updating and upgrading system..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl gnome-tweaks build-essential git

# Configure Git [Change to your details]
echo "Configuring Git..."
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Installing Fonts: 
echo "Installing Fonts..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)" # JetBrains Mono
sudo apt install fonts-inter-variable
sudo apt install fonts-firacode
sudo apt install ttf-mscorefonts-installer

# Install Bitwarden
echo "Installing Bitwarden & KeepassXC..."
sudo snap install bitwarden
sudo snap install keepassxc

#install Brave Browser (If a Chromium Browser is required)
echo "Installing Brave Browser..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

# Install Other Utilitiy Apps
echo "Installing Other Utilitiy Apps..."
sudo snap install obsidian --classic
sudo snap install localsend
sudo snap install pdfarranger
sudo snap install onlyoffice-desktopeditors
sudo snap install code --classic
sudo apt install vlc


echo "Installing NodeJS and NPM..."
# installs nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# download and install Node.js (you may need to restart the terminal)
nvm install 20
# verifies the right Node.js version is in the environment
#node -v # should print `v20.15.1`
# verifies the right npm version is in the environment
#npm -v # should print `10.7.0`

# Install Flatpak support via FlatHub
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Cleanup
echo "Cleaning up..."
sudo apt autoremove -y
sudo apt update

# Create update.sh script in /home directory
echo "Creating update.sh script in /home directory..."
cat << 'EOF' > ~/update.sh
#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Update package lists
echo -e "${YELLOW}Updating package lists...${NC}\n"
sudo apt update

# Perform upgrade for Ubuntu packages
echo -e "${YELLOW}Upgrading Ubuntu packages...${NC}\n"
sudo apt upgrade -y

# Clean up unnecessary packages and cached files
# [Uncomment to clear apt cache and dependencies that are not required]
# echo -e "${YELLOW}Cleaning up Ubuntu packages...${NC}\n"
# sudo apt autoremove -y
# sudo apt autoclean

# Update Snap packages
echo -e "${YELLOW}Updating Snap packages...${NC}\n"
sudo snap refresh

# update Flatpak
flatpak update

echo -e "\n\n${GREEN}Update script completed.${NC}\n"
EOF

# Make the update.sh script executable
chmod +x ~/update.sh


echo -e "\n\n${GREEN}Installation and configuration complete!${NC}"
