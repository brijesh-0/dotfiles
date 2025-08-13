# Remove Snap apps interactively
function snaprm
    set snaps (snap list | tail -n +2 | fzf --multi | awk '{print $1}')
    if test -z "$snaps"
        echo "No snap selected."
        return
    end
    echo "Removing: $snaps"
    snap remove $snaps
end
