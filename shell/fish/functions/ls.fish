function ls --wraps='eza -TaL 1 --icons --group-directories-first' --description 'alias ls=eza -TaL 1 --icons --group-directories-first'
    eza -aL 1 --icons --group-directories-first $argv
end
