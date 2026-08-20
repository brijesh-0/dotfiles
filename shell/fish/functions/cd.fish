function cd --wraps cd --description 'Change directory and list its contents'
    builtin cd $argv
    and ls
end