# Documentation: https://fishshell.com/docs/current/cmds/abbr.html

function last_history_item # bash like !! replace
    echo $history[1]
end

abbr -a !! --position anywhere --function last_history_item

abbr -a --position command ftree 'fd -H | tree --fromfile -C -a --dirsfirst'

abbr -a cb 'kitten clipboard'

abbr -a daten "date '+%F %T'"

abbr -a nrd 'npm run dev'
abbr -a prs 'pnpm run serve'

abbr -a --position command n 'nvim'
abbr -a --position command c 'clear'

# --- git ---
abbr -a gitls 'git ls-files | tree --fromfile -C --dirsfirst'

# --- Docker ---
abbr -a dcu 'docker compose up -d'
abbr -a dcd 'docker compose down'
abbr -a dps 'docker ps -a'

# --- Hledger ---
abbr -a hl 'hledger'
abbr -a hla 'hledger add'
abbr -a hlb 'hledger bal not:equity --no-total'
abbr -a hld 'hledger bal --no-total tag:person --pivot person'
abbr -a hls 'hledger bal subscriptions tag:company --pivot company'
