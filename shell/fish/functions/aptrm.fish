# Remove APT apps interactively
function aptrm
    set selected (dpkg-query -W -f='{$Package}\n' | fzf --multi --prompt="Select package(s) to remove: ")

    if test -z "$selected"
        echo "No packages selected."
        return 1
    end

    echo "Removing: $selected"
    sudo apt remove --purge $selected
end
