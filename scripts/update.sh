#!/usr/bin/env bash

# System Updates
echo "--- Updating Apt and Snaps ---"
sudo apt update && sudo apt upgrade -y
sudo snap refresh
sudo apt autoremove -y

# echo "--- Updating Python (uv) and Kitty ---"
# curl -LsSf https://astral.sh/uv/install.sh | sh
# uv self update
#
# curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
#
# echo "--- Updating eget binaries ---"
# export PATH="$HOME/.local/bin:$PATH"
#
# eget ajeetdsouza/zoxide --to "$HOME/.local/bin" --upgrade-only
# eget burntsushi/ripgrep --to "$HOME/.local/bin" --upgrade-only
# eget jesseduffield/lazygit --to "$HOME/.local/bin" --upgrade-only
# eget junegunn/fzf --to "$HOME/.local/bin" --upgrade-only
# eget typst/typst --to "$HOME/.local/bin" --upgrade-only
# eget eza-community/eza --asset gnu --asset tar --to "$HOME/.local/bin/" --upgrade-only
# eget dandavison/delta --asset gnu --to "$HOME/.local/bin/" --upgrade-only
# eget sharkdp/bat --asset gnu --to "$HOME/.local/bin/" --upgrade-only
# eget sharkdp/fd --asset gnu --to "$HOME/.local/bin/" --upgrade-only
# eget sxyazi/yazi --asset gnu --asset zip --to "$HOME/.local/bin/" --upgrade-only
# eget neovim/neovim --asset appimage --asset x86_64 --to "$HOME/.local/bin/nvim" --upgrade-only
# eget imagemagick/imagemagick --asset gcc --to "$HOME/.local/bin/magick" --upgrade-only
#
# chmod +x "$HOME/.local/bin/nvim" "$HOME/.local/bin/magick"

echo "Update complete!"
