function rmrf --description "less stupid rm -rf"

    test (count $argv) -gt 0
    or begin
        echo "rmrf: missing operand" >&2
        return 1
    end

    for x in $argv
        set -l p (realpath -e -- "$x" 2>/dev/null)
        or begin
            echo "rmrf: $x: no such file or directory" >&2
            return 1
        end

        switch $p
            case / /boot /dev /etc /home /proc /root /sys /usr /var
                echo "rmrf: refusing to remove $p" >&2
                return 1
        end
    end

    if command -q eza
        eza --tree --level=1 $argv
    else
        for x in $argv
            find "$x" -maxdepth 1
        end
    end

    echo
    read -l -P "remove? [y/N] " yn

    string match -rqi '^y(es)?$' -- "$yn"
    and command rm -rf -- $argv
end
