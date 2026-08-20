#!/usr/bin/env bash

# Pre-accept EULA for fonts to avoid interactive hang
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections

# Initialize directories
export XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

# Add repositories and update
sudo add-apt-repository -y ppa:fish-shell/release-4
sudo apt update

# Install all apt packages in one block
sudo apt install -y curl gnome-tweaks build-essential git tree \
	ffmpegthumbnailer gstreamer1.0-libav ca-certificates \
	vlc fish libfuse2t64 ffmpeg
	

# Snap application deployment
echo "Installing Snaps"
sudo snap install bitwarden localsend pdfarranger onlyoffice-desktopeditors chromium
sudo snap install obsidian --classic
sudo snap install code --classic

echo "Installing Python Tooling (uv)"
curl -LsSf https://astral.sh/uv/install.sh | sh

# Binary management via eget
echo "Installing eget and binaries"
curl https://zyedidia.github.io/eget.sh | sh
mv ~/eget ~/.local/bin/

# Download latest stable binaries
"$HOME/.local/bin/eget" ajeetdsouza/zoxide --to "$HOME/.local/bin/"
"$HOME/.local/bin/eget" burntsushi/ripgrep --to "$HOME/.local/bin/"
"$HOME/.local/bin/eget" dandavison/delta --asset gnu --to "$HOME/.local/bin/"
"$HOME/.local/bin/eget" eza-community/eza --asset gnu --asset tar --to "$HOME/.local/bin/"
"$HOME/.local/bin/eget" imagemagick/imagemagick --asset gcc --to "$HOME/.local/bin/magick"
"$HOME/.local/bin/eget" jesseduffield/lazygit --to "$HOME/.local/bin/"
"$HOME/.local/bin/eget" junegunn/fzf --to "$HOME/.local/bin/"
"$HOME/.local/bin/eget" neovim/neovim --asset appimage --asset x86_64 --to "$HOME/.local/bin/nvim"
"$HOME/.local/bin/eget" sharkdp/bat --asset gnu --to "$HOME/.local/bin/"
"$HOME/.local/bin/eget" sharkdp/fd --asset gnu --to "$HOME/.local/bin/"
"$HOME/.local/bin/eget" sxyazi/yazi --asset gnu --asset zip --to "$HOME/.local/bin/"
"$HOME/.local/bin/eget" typst/typst --to "$HOME/.local/bin/"

chmod +x ~/.local/bin/nvim
chmod +x ~/.local/bin/magick

echo "Installing Kitty Terminal"
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -sf "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/kitty.app/bin/kitten" "$HOME/.local/bin/"
cp "$HOME/.local/kitty.app/share/applications/kitty.desktop" "$HOME/.local/share/applications/"
cp "$HOME/.local/kitty.app/share/applications/kitty-open.desktop" "$HOME/.local/share/applications/"
sed -i "s|Icon=kitty|Icon=$HOME/.config/kitty/whiskers.svg|g" "$HOME/.local/share/applications/kitty*.desktop"
sed -i "s|Exec=kitty|Exec=$HOME/.local/kitty.app/bin/kitty|g" "$HOME/.local/share/applications/kitty*.desktop"
echo 'kitty.desktop' >"$HOME/.config/xdg-terminals.list"

# Final cleanup
sudo apt autoremove -y

echo "Installation complete. Please restart the terminal or source the configuration files."
