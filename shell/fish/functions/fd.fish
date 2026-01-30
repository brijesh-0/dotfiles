function fd --wraps fd --description 'fd with default excludes'

    set -l ignore_list .git node_modules dist build venv .venv __pycache__ .cache .next .DS_Store

    # Prefix every item in the list with '--exclude'
    set -l ignore_args (string format -- '--exclude=%s' $ignore_list)

    command fd $ignore_args --hidden --smart-case $argv

end
