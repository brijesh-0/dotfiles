function hcat --description 'Print file names relative to current dir and their contents'
    for file in $argv
        if test -f "$file"
            # Get the path relative to current directory
            # If the file is outside the current dir, it shows the full path
            set -l relative_path (realpath --relative-to=(pwd) "$file")
            
            echo "------------"
            echo ""
            echo "FILE: $relative_path"
            
            cat "$file"
            echo ""
        end
    end
    if set -q argv[1]
        echo "-----------"
    end
end
