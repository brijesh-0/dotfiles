if status is-interactive

	set -gx FZF_DEFAULT_COMMAND "fd --type file --max-depth 7 --exclude .git --exclude node_modules --exclude venv --exclude .Private"

	set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
	set -gx FZF_CTRL_T_OPTS "--walker-skip .git,node_modules,target --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"

	set -g fish_greeting ''

	if command -sq zoxide
	    zoxide init fish | source
	else
	    echo 'zoxide: command not found, please install it from https://github.com/ajeetdsouza/zoxide'
	end
end
