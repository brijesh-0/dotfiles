function fish_prompt
    set -l __last_command_exit_status $status

    set -l red (set_color -o red)
    set -l green (set_color -o green)
    set -l cyan (set_color -o cyan)
    set -l normal (set_color normal)

    set -l arrow_color "$green"
    if test $__last_command_exit_status != 0
        set arrow_color "$red"
    end

    set -l arrow "$arrow_color>"
    set -l cwd $cyan(prompt_pwd -D 1000)

    echo -n -s $cwd ' ' $arrow ' ' $normal
end
