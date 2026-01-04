# Documentation: https://fishshell.com/docs/current/cmds/abbr.html

function last_history_item # bash like !! replace
    echo $history[1]
end

abbr -a !! --position anywhere --function last_history_item

abbr -a ftree 'fd -H | tree --fromfile -C -a --dirsfirst'

