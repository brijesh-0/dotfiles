# Documentation: https://fishshell.com/docs/current/cmds/abbr.html

function last_history_item # bash like !! replace
    echo $history[1]
end

abbr -a !! --position anywhere --function last_history_item

abbr -a --position command ftree 'fd -H | tree --fromfile -C -a --dirsfirst'

abbr -a docker 'sudo docker'

# abbr -a hcat "awk 'FNR==1{if(NR>1)print\"\n======\n\";print FILENAME} {print \$0}'"

abbr -a daten "date '+%F %T'"

abbr -a nrd 'npm run dev'
abbr -a prs 'pnpm run serve'

abbr -a --position command n 'nvim'
abbr -a --position command c 'clear'
