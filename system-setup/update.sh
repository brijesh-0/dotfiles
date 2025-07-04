#!/usr/bin/env bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Update package lists
sudo echo -e "${YELLOW}Updating package lists...${NC}\n"
sudo apt update

# Perform upgrade for Ubuntu packages
echo -e "${YELLOW}Upgrading Ubuntu packages...${NC}\n"
sudo apt upgrade -y

# Clean up unnecessary packages and cached files
# echo -e "${YELLOW}Cleaning up Ubuntu packages...${NC}\n"
# sudo apt autoremove -y
# sudo apt autoclean

# Update Snap packages
echo -e "${YELLOW}Updating Snap packages...${NC}\n"
sudo snap refresh

# update Flatpak
# flatpak update -y

echo -e "\n\n${GREEN}Update script completed.${NC}\n"
