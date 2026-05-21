function man --wraps man
    command man $argv | col -bx | bat -l man -p
end
