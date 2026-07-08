function __dateconv_process --description "Internal date processing helper"
    set -l input $argv[1]

    # Convert epoch input
    if set -q _flag_from_epoch
        if not string match -qr '^\d+$' -- "$input"
            echo "Error: --from-epoch requires a numeric timestamp." >&2
            return 1
        end
        set input "@$input"

    else if string match -qr '^\d{10}$' -- "$input"
        set input "@$input"
    end

    # Validate date
    if not date -d "$input" >/dev/null 2>&1
        echo "Error: Invalid date input '$input'." >&2
        return 1
    end

    # Apply timezone only when requested
    if set -q _flag_tz
        set -lx TZ $_flag_tz
    end

    # Generate values
    set -l iso (
        date -d "$input" +"%Y-%m-%dT%H:%M:%S%:z"
    )

    set -l utc (
        TZ=UTC date -d "$input" +"%Y-%m-%dT%H:%M:%S.000Z"
    )

    set -l simple (
        date -d "$input" +"%Y-%m-%d"
    )

    set -l epoch (
        date -d "$input" +"%s"
    )

    set -l human (
        date -d "$input" +"%a %b %d %H:%M:%S %Z %Y"
    )

    # JSON output
    if set -q _flag_json
        printf '{\n'
        printf '  "input": %s,\n' (string escape --json "$input")
        printf '  "iso": %s,\n' (string escape --json "$iso")
        printf '  "utc": %s,\n' (string escape --json "$utc")
        printf '  "date": %s,\n' (string escape --json "$simple")
        printf '  "epoch": %s,\n' "$epoch"
        printf '  "human": %s\n' (string escape --json "$human")
        printf '}\n'
        return
    end

    # All formats
    if set -q _flag_all
        echo "Input:"
        echo "  $input"
        echo
        echo "ISO:"
        echo "  $iso"
        echo
        echo "UTC:"
        echo "  $utc"
        echo
        echo "Date:"
        echo "  $simple"
        echo
        echo "Epoch:"
        echo "  $epoch"
        echo
        echo "MongoDB:"
        echo "  ISODate(\"$utc\")"
        echo
        echo "Human:"
        echo "  $human"
        return
    end

    # Direct output modes
    if set -q _flag_mongo
        echo "ISODate(\"$utc\")"
        return
    end

    if set -q _flag_epoch
        echo "$epoch"
        return
    end

    # Interactive mode
    if not command -q fzf
        echo "Error: fzf is required for interactive mode." >&2
        return 1
    end

    set -l formats \
        "Standard ISO Date       | %Y-%m-%d" \
        "MongoDB Legacy ISODate | ISODate(\"%Y-%m-%dT%H:%M:%S.000Z\")" \
        "Unix Epoch             | %s" \
        "Full Timestamp         | %Y-%m-%dT%H:%M:%S%z" \
        "Human Readable         | %a %b %d %H:%M:%S %Z %Y"

    set -l selection (
        printf "%s\n" $formats |
        fzf \
            --prompt="Select Output Format > " \
            --height=10% \
            --layout=reverse
    )

    if test -z "$selection"
        echo "Selection cancelled."
        return 1
    end

    set -l fmt (string split -m 1 " | " "$selection")[2]

    if string match -q "ISODate*" -- "$fmt"
        echo "ISODate(\"$utc\")"
    else
        date -d "$input" +"$fmt"
    end
end

function dateconv --description "Convert dates into various formats interactively or via flags"

    set -l options \
        (fish_opt -s h -l help) \
        (fish_opt -s m -l mongo) \
        (fish_opt -s e -l epoch) \
        (fish_opt -s r -l from-epoch) \
        (fish_opt -l all) \
        (fish_opt -l json) \
        (fish_opt -l tz --long-only) \
        (fish_opt -l stdin --long-only)

    if not argparse $options -- $argv
        return 1
    end

    if set -q _flag_help
        echo "Usage: dateconv [DATE_STRING] [OPTIONS]"
        echo
        echo "Examples:"
        echo "  dateconv now"
        echo "  dateconv 2026-07-07 14:30"
        echo "  dateconv now --tz Asia/Kolkata"
        echo "  dateconv now --all"
        echo "  cat dates.txt | dateconv --stdin"
        echo
        echo "Options:"
        echo "  -h, --help          Show help"
        echo "  -m, --mongo         MongoDB ISODate output"
        echo "  -e, --epoch         Unix timestamp output"
        echo "  -r, --from-epoch    Treat input as epoch"
        echo "      --all           Show all formats"
        echo "      --json          JSON output"
        echo "      --tz ZONE       Output timezone"
        echo "      --stdin         Read dates from stdin"
        return 0
    end

    if not command -q date
        echo "Error: date command not found." >&2
        return 1
    end

    # stdin mode
    if set -q _flag_stdin
        while read -l line
            __dateconv_process "$line"
        end
        return
    end

    # Accept unquoted dates:
    # dateconv 2026-07-07 14:30
    set -l input (string join " " $argv)

    if test -z "$input"
        read -P "Enter Date or Epoch: " input

        if test -z "$input"
            echo "Cancelled."
            return 1
        end
    end

    __dateconv_process "$input"
end
