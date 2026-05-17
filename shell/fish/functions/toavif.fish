function toavif --description "Convert image file(s) to AVIF into a specific output folder"
    # ---- defaults ----
    set -l quality 75

    # ---- argument parsing ----
    set -l args
    set -l i 1
    while test $i -le (count $argv)
        switch $argv[$i]
            case -q --quality
                set i (math $i + 1)
                if test $i -gt (count $argv)
                    echo "Error: --quality requires a value"
                    return 1
                end
                set quality $argv[$i]
            case '-*'
                echo "Error: unknown option: $argv[$i]"
                return 1
            case '*'
                set -a args $argv[$i]
        end
        set i (math $i + 1)
    end

    # ---- dependency check ----
    if not command -q magick
        echo "Error: ImageMagick 'magick' command not found."
        return 1
    end

    # ---- argument check ----
    if test (count $args) -lt 2
        echo "Usage: toavif [--quality N] <source-file-or-dir>... <output-dir>"
        return 1
    end

    set -l sources $args[1..-2]
    set -l out_dir (path resolve $args[-1])

    # ---- quality validation ----
    if not string match -rq '^\d+$' -- $quality
        echo "Error: quality must be a positive integer, got: $quality"
        return 1
    end
    if test $quality -lt 1 -o $quality -gt 100
        echo "Error: quality must be between 1 and 100, got: $quality"
        return 1
    end

    # Create the output directory if it doesn't exist
    mkdir -p "$out_dir"

    # ---- collect files ----
    set files
    set rel_dirs
    for source in $sources
        set -l target (path resolve "$source")
        if not test -e "$target"
            echo "Error: source path does not exist: $target"
            return 1
        end

        if test -f "$target"
            set -a files "$target"
            set -a rel_dirs .
        else if test -d "$target"
            for f in (path filter -f -- $target/**/*.{jpg,jpeg,png,webp,tif,tiff,bmp})
                set -l rel_path (string replace -- "$target/" "" "$f")
                set -a files "$f"
                set -a rel_dirs (path dirname "$rel_path")
            end
        end
    end

    if test (count $files) -eq 0
        echo "No supported image files found."
        return 0
    end

    # ---- pre-scan ----
    set -l total (count $files)
    set -l skipped 0
    set -l to_convert 0

    for n in (seq (count $files))
        set -l f $files[$n]
        set -l rel_dir $rel_dirs[$n]
        set -l filename (basename "$f")

        set -l out_name
        set out_name (string replace -r '\.[^.]+$' '.avif' "$filename")
        set -l out_subdir "$out_dir"
        if test "$rel_dir" != "."
            set out_subdir "$out_dir/$rel_dir"
        end
        set -l out_path "$out_subdir/$out_name"

        if test -e "$out_path"
            set skipped (math $skipped + 1)
        else
            set to_convert (math $to_convert + 1)
        end
    end

    echo "Found $total image files ($skipped already in output, $to_convert to convert)"
    if test $to_convert -eq 0
        echo "Nothing to do."
        return 0
    end
    echo "Converting $to_convert files to AVIF..."

    # ---- conversion loop ----
    set -l idx 0
    set -l converted 0
    set -l failed 0

    for n in (seq (count $files))
        set -l f $files[$n]
        set -l rel_dir $rel_dirs[$n]
        set -l filename (basename "$f")

        set -l out_name
        set out_name (string replace -r '\.[^.]+$' '.avif' "$filename")
        set -l out_subdir "$out_dir"
        if test "$rel_dir" != "."
            set out_subdir "$out_dir/$rel_dir"
        end
        set -l out_path "$out_subdir/$out_name"

        if test -e "$out_path"
            continue
        end

        set idx (math $idx + 1)
        echo "[$idx/$to_convert] Converting: $filename → $out_name"
        mkdir -p "$out_subdir"

        magick "$f" \
            -strip \
            -define avif:speed=3 \
            -quality $quality \
            "$out_path"

        if test $status -ne 0
            echo "  Failed: $filename"
            set failed (math $failed + 1)
        else
            set converted (math $converted + 1)
        end
    end

    echo "Done: $converted converted, $skipped skipped, $failed failed"
end
