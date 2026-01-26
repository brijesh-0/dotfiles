function genid
    # Default values
    set -l len 6
    set -l count 1

    # Override defaults if arguments are passed
    if test (count $argv) -ge 1
        set len $argv[1]
    end
    if test (count $argv) -ge 2
        set count $argv[2]
    end

    # Generate and print
    LC_ALL=C tr -dc '23456789abcdefghjkmnpqrstuvwxyz' < /dev/urandom | fold -w $len | head -n $count
end
