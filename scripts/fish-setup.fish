# Fisher Plugin Manager
curl -sL 'https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish' | source && fisher install jorgebucaran/fisher

# completions
mkdir -p '~/.config/fish/completions'

curl -L 'https://raw.githubusercontent.com/eza-community/eza/main/completions/fish/eza.fish' -o '~/.config/fish/completions/eza.fish'

curl -L https://raw.githubusercontent.com/sharkdp/bat/master/assets/completions/bat.fish.in | sed 's/set bat {{PROJECT_EXECUTABLE}}/set bat bat/g' >'~/.config/fish/completions/bat.fish'

fd --gen-completions fish >'~/.config/fish/completions/fd.fish'
rg --generate complete-fish >'~/.config/fish/completions/rg.fish'
delta --generate-completion fish >'~/.config/fish/completions/delta.fish'

if type -q uv
    uv generate-shell-completion fish >'~/.config/fish/completions/uv.fish'
end

if type -q typst
    typst completions fish >'~/.config/fish/completions/typst.fish'
end

if test "$TERM" = xterm-kitty
    kitty +complete setup fish >'~/.config/fish/completions/kitty.fish'
end

fish_config theme choose catppuccin-mocha
