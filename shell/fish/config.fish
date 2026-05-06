if status is-interactive

    fish_add_path ~/.local/bin/ ~/.local/share/pnpm ~/.opencode/bin

    set -gx EDITOR nvim
    set -gx VISUAL nvim

    set -gx FZF_DEFAULT_OPTS "
	--layout=reverse
	--border
	--preview-window='right:60%:hidden'
	--bind='ctrl-/:toggle-preview'
	--bind='ctrl-d:preview-page-down'
	--bind='ctrl-u:preview-page-up'
	--color='header:italic:underline,label:dim,info:italic:243'
	"

    # 2. Search Engine
    set -gx FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git --exclude .Private"

    # 3. Tool Specifics
    # Note: We keep these clean; they inherit the layout and border from above.
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -gx FZF_CTRL_T_OPTS "--preview 'bat -n --color=always {}'"

    set -gx FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window='bottom:3:wrap'"

    set -g fish_greeting ''

    set -gx MANPAGER "bat -p -lman"

    set -g fish_key_bindings vim_mode

    if command -sq zoxide
        zoxide init fish | source
    else
        echo 'zoxide: command not found, please install it from https://github.com/ajeetdsouza/zoxide'
    end

end
