function rmrf --description "less stupid rm -rf"
    set -l paths $argv

    if not isatty stdin
        while read -l path_from_stdin
            test -n "$path_from_stdin"
            and set --append paths "$path_from_stdin"
        end
    end

    test (count $paths) -gt 0
    or begin
        echo "rmrf: missing operand" >&2
        return 1
    end

    for x in $paths
        if not test -e "$x"; and not test -L "$x"
            echo "rmrf: $x: no such file or directory" >&2
            return 1
        end

        set -l p (path resolve -- "$x")

        switch $p
            case / /boot /dev /etc /home /proc /root /sys /usr /var
                echo "rmrf: refusing to remove $p" >&2
                return 1
        end
    end

    if command -q eza
        eza --tree --level=1 -- $paths
    else
        for x in $paths
            find "$x" -maxdepth 1
        end
    end

    echo
    read -l -P "remove? [y/N] " yn </dev/tty

    string match -rqi '^y(es)?$' -- "$yn"
    and command rm -rf -- $paths
end
