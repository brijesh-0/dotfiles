# --- Fisher Plugin Manager ---

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# --- completions ---

curl -L https://raw.githubusercontent.com/eza-community/eza/main/completions/fish/eza.fish -o ~/.config/fish/completions/eza.fish
curl -L https://raw.githubusercontent.com/sharkdp/bat/master/assets/completions/bat.fish.in \
    | sed 's/set bat {{PROJECT_EXECUTABLE}}/set bat bat/g' >~/.config/fish/completions/bat.fish

uv generate-shell-completion fish >~/.config/fish/completions/uv.fish
typst completions fish >~/.config/fish/completions/typst.fish
zoxide init fish >~/.config/fish/completions/zoxide.fish

# Set Theme
fish_config theme choose catppuccin-mocha
