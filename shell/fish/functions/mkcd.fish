function mkcd --description "Create a directory and cd into it"
    if test (count $argv) -eq 0
        echo "mkcd: missing operand" >&2
        return 1
    end

    if test (count $argv) -gt 1
        echo "mkcd: too many arguments" >&2
        return 1
    end

    mkdir -p -- $argv[1]
    and cd -- $argv[1]
end
