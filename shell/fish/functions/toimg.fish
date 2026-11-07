function toimg --description 'Convert images to a chosen format'
    argparse -n toimg -x s,no-strip 'q/quality=' 's/strip' 'no-strip' 'k/keep-name' 'f/force' 'n/dry-run' 'l/list-formats' 'h/help' -- $argv; or return 1

    if set -q _flag_help
        echo 'Usage: toimg <format> [options] <source-file-or-dir>... <output-dir>'
        echo '  -q, --quality N    Output quality (1–100)'
        echo '  -s, --strip        Remove metadata (default)'
        echo '      --no-strip     Keep metadata when supported'
        echo '  -k, --keep-name    Append the output extension to the original name'
        echo '  -f, --force        Replace existing output files'
        echo '  -n, --dry-run      Show actions without writing files'
        echo '  -l, --list-formats List available image formats'
        echo '  -h, --help         Show this help'
        return
    end
    if not command -q magick
        echo "Error: ImageMagick 'magick' command not found." >&2
        return 1
    end

    # Limit directory scans to common image formats, and check local codec support.
    set -l formats avif jpg jpeg png webp heic heif tif tiff bmp gif svg
    set -l available (magick -list format)
    or begin
        echo 'Error: could not list ImageMagick formats.' >&2
        return 1
    end
    set -l readable
    set -l writable
    for format in $formats
        set -l coder (string upper -- $format)
        switch $coder
            case JPG
                set coder JPEG
            case TIF
                set coder TIFF
        end
        for entry in $available
            set -l fields (string split -n ' ' -- (string trim -- $entry))
            if set -q fields[1]; and test (string replace -r '\*$' '' -- $fields[1]) = "$coder"
                set -l mode (string match -r '^[r-][w-][+-]$' -- $fields[2..])
                if string match -q 'r*' -- $mode
                    set -a readable $format
                end
                if string match -rq '^.w' -- $mode
                    set -a writable $format
                end
                break
            end
        end
    end
    if set -q _flag_list_formats
        echo 'Readable: '(string join ', ' $readable)
        echo 'Writable: '(string join ', ' $writable)
        return
    end
    if test (count $argv) -lt 3
        echo 'Usage: toimg <format> [options] <source-file-or-dir>... <output-dir>' >&2
        return 1
    end

    set -l format (string lower -- $argv[1])
    if not contains -- $format $writable
        echo "Error: unsupported output format: $format (see toimg --list-formats)" >&2
        return 1
    end
    set -l quality
    if set -q _flag_quality
        set quality $_flag_quality
        if not string match -rq '^\d+$' -- $quality; or test $quality -lt 1 -o $quality -gt 100
            echo "Error: quality must be an integer between 1 and 100: $quality" >&2
            return 1
        end
        if not contains -- $format avif jpg jpeg webp heic heif
            echo "Error: --quality is not supported for $format output" >&2
            return 1
        end
    else
        switch $format
            case avif
                set quality 75
            case jpg jpeg
                set quality 85
        end
    end

    set -l sources $argv[2..-2]
    set -l out_dir (path resolve -- $argv[-1])
    set -l files
    set -l rel_dirs
    for source in $sources
        set -l target (path resolve -- $source)
        if test -f "$target"
            set -a files "$target"
            set -a rel_dirs .
        else if test -d "$target"
            for f in (path filter -f -- $target/**/*)
                set -l ext (string lower -- (string replace -r '^.*\.' '' -- (path basename -- "$f")))
                if contains -- $ext $readable
                    set -a files "$f"
                    set -a rel_dirs (path dirname -- (string replace -- "$target/" '' "$f"))
                end
            end
        else
            echo "Error: source path does not exist: $target" >&2
            return 1
        end
    end
    if not set -q files[1]
        echo 'No supported image files found.'
        return 0
    end

    set -l converted 0
    set -l skipped 0
    set -l failed 0
    for i in (seq (count $files))
        set -l f $files[$i]
        set -l filename (path basename -- "$f")
        set -l name (string replace -r '\.[^.]+$' '' -- "$filename")
        if set -q _flag_keep_name
            set name "$filename"
        end
        set -l output (path normalize -- "$out_dir/$rel_dirs[$i]/$name.$format")
        if contains -- "$output" $files
            echo "Skipping output that is also a source: $output"
            set skipped (math $skipped + 1)
            continue
        end
        if test -e "$output"; and not set -q _flag_force
            echo "Skipping existing: $output"
            set skipped (math $skipped + 1)
            continue
        end
        if set -q _flag_dry_run
            echo "Would convert: $f → $output"
            set converted (math $converted + 1)
            continue
        end
        echo "Converting: $f → $output"
        mkdir -p -- (path dirname -- "$output"); or return 1
        set -l options -auto-orient
        if contains -- $format jpg jpeg
            set -a options -background white -alpha remove -alpha off
        end
        if not set -q _flag_no_strip
            set -a options -strip
        end
        if test "$format" = avif
            set -a options -define avif:speed=3
        end
        if set -q quality[1]
            set -a options -quality $quality
        end
        if magick "$f" $options "$output"
            set converted (math $converted + 1)
        else
            set failed (math $failed + 1)
        end
    end
    if set -q _flag_dry_run
        echo "Done: $converted would convert, $skipped skipped"
    else
        echo "Done: $converted converted, $skipped skipped, $failed failed"
    end
    test $failed -eq 0
end
