#!/usr/bin/env bash

# ANSI color codes
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${YELLOW}Updating Apt packages...${NC}"
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y

echo -e "${YELLOW}Updating Snap packages...${NC}"
sudo snap refresh

# echo -e "${YELLOW}Updating uv...${NC}"
# uv self update

echo -e "${YELLOW}Updating eget binaries...${NC}"

# Use the --upgrade-only flag to check for newer releases on GitHub
eget ajeetdsouza/zoxide --to "$HOME/.local/bin" --upgrade-only
eget burntsushi/ripgrep --to "$HOME/.local/bin" --upgrade-only
eget junegunn/fzf --to "$HOME/.local/bin" --upgrade-only
eget neovim/neovim --asset appimage --asset x86_64 --to "$HOME/.local/bin/nvim" --upgrade-only
eget sharkdp/bat --asset gnu --to "$HOME/.local/bin" --upgrade-only
eget sharkdp/fd --asset gnu --to "$HOME/.local/bin" --upgrade-only

echo -e "\n${GREEN}All packages and binaries are up to date.${NC}"
