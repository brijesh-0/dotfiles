if status is-interactive

	set -gx FZF_DEFAULT_COMMAND "fd --type file --max-depth 7 --exclude .git  --exclude .Private"

	set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
	set -gx FZF_CTRL_T_OPTS "--walker-skip .git,node_modules,target --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"

	set -g fish_greeting ''

	set -gx MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

	if command -sq zoxide
	    zoxide init fish | source
	else
	    echo 'zoxide: command not found, please install it from https://github.com/ajeetdsouza/zoxide'
	end
end
