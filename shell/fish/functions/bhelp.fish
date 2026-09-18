function bhelp --description 'Show command help through bat'
    command $argv --help | bat -l help
end
