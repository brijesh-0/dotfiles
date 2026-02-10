function genid
    # Define the valid options
    # -l/--len: takes an integer
    # -n/--num: takes an integer (renamed from count to avoid confusion with the 'count' command)
    # -U/--upper: a boolean flag
    argparse l/len= n/num= U/upper -- $argv
    or return

    # Set defaults if flags aren't provided
    set -l len 6
    set -l count 1
    set -l charset '23456789abcdefghjkmnpqrstuvwxyz'

    if set -q _flag_l
        set len $_flag_l
    end

    if set -q _flag_n
        set count $_flag_n
    end

    # Handle the uppercase flag
    if set -q _flag_U
        set charset (string upper $charset)
    end

    # Generate and print
    LC_ALL=C tr -dc $charset < /dev/urandom | fold -w $len | head -n $count
end
