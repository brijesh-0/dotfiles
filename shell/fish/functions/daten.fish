function daten --description "Format dates interactively with fzf, defaults to now"
    if not command -q date
        echo "Error: date command not found." >&2
        return 1
    end

    set -l input now
    if set -q argv[1]
        set input (string join " " $argv)
    end

    # Detect and convert epoch input
    if string match -qr '^\d{10}$' -- "$input"
        set input "@$input"
    end

    if not date -d "$input" >/dev/null 2>&1
        echo "Error: Invalid date '$input'." >&2
        return 1
    end

    if not command -q fzf
        echo "Error: fzf is required." >&2
        return 1
    end

    set -l formats \
        "Date (DD-MM-YYYY)      | %d-%m-%Y" \
        "Date (YYYY-MM-DD)      | %Y-%m-%d" \
        "Date (YYYY-MMM-DD)     | %Y-%b-%d" \
        "Date and Time          | %F %T" \
        "Filename safe          | %Y%m%d_%H%M%S" \
        "Timestamp              | %Y%m%dT%H%M%S" \
        "Human Readable         | %a %b %d %H:%M:%S %Z %Y" \
        "UTC Timestamp          | (TZ=UTC)%Y-%m-%dT%H:%M:%S.000Z" \
        "Unix Epoch (seconds)   | %s" \
        "Unix Epoch (millis)    | %s000" \
        "Full Date with TZ      | %a, %d %b %Y %H:%M:%S %z" \
        "ISO Full               | %Y-%m-%dT%H:%M:%S%:z" \
        "Full Date              | %A, %B %d, %Y" \
        "Short Date             | %b %d" \
        "Time (24h)             | %H:%M:%S" \
        "Time (12h)             | %I:%M:%S %p" \
        "Year-Month             | %Y-%m" \
        "Weekday (full)         | %A" \
        "Weekday (short)        | %a" \
        "Month (full)           | %B" \
        "Month (short)          | %b" \
        "Day of year            | %j" \
        "Week number            | %V" \
        "Year-Week              | %G-W%V" \
        "Quarter                | [special]%Y-Q{quarter}"
    set -l selection (
        printf "%s\n" $formats |
        fzf \
            --prompt="Format: " \
            --height="50%" \
            --layout=reverse \
            --header="Select output format for: "(date -d "$input" +"%F %T")
    )

    if test -z "$selection"
        return 1
    end

    set -l fmt (string split -m 2 " | " "$selection")[2]

    # Handle special wrapper formats
    if string match -q "UTC / Zulu*" -- "$selection"
        TZ=UTC date -d "$input" +"%Y-%m-%dT%H:%M:%S.000Z"
    else if string match -q "Quarter*" -- "$selection"
        set -l m (date -d "$input" +%m)
        set -l q (math "($m - 1) / 3 + 1")
        echo (date -d "$input" +"%Y")-Q$q
    else
        date -d "$input" +"$fmt"
    end
end
