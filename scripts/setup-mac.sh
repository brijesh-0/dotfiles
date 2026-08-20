#!/usr/bin/env bash

set -e

# Xcode Command Line Tools (git, make, clang, etc.)
if ! xcode-select -p &>/dev/null; then
	echo "Installing Xcode Command Line Tools"
	xcode-select --install
fi

# Homebrew
if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Installing CLI tools"
brew install fish git tree ffmpeg curl \
	zoxide ripgrep git-delta eza imagemagick lazygit fzf \
	neovim bat fd yazi typst uv kitty

echo "Installing GUI apps"
brew install --cask \
	bitwarden localsend obsidian

# Add fish to /etc/shells and make it the default shell
FISH_PATH="$(command -v fish)"
if ! grep -qx "$FISH_PATH" /etc/shells; then
	echo "Registering fish in /etc/shells"
	echo "$FISH_PATH" | sudo tee -a /etc/shells
fi
if [ "$SHELL" != "$FISH_PATH" ]; then
	echo "Setting fish as default shell"
	chsh -s "$FISH_PATH"
fi

# Final cleanup
brew cleanup

echo "Installation complete. Please restart the terminal or source the configuration files."
