function apprm --description "Interactively uninstall Snap or DPKG packages using fzf"
    # 1. Define the package manager via argument
    set -l manager $argv[1]

    # 2. Validation & Usage
    if not contains -- "$manager" snap apt dpkg
        echo (set_color red)"Error: Please specify 'snap' or 'apt'"(set_color normal)
        echo "Usage: uninstall [snap|apt]"
        return 1
    end

    # 3. Source Selection Logic
    set -l selected_pkgs
    switch $manager
        case snap
            # Checks if snap is installed before running
            if not command -sq snap
                echo "Snap is not installed on this system."
                return 1
            end
            set selected_pkgs (snap list | tail -n +2 | fzf --multi --header="Select Snaps to remove" --preview "snap info {1}" | awk '{print $1}')

        case apt dpkg
            # Filter for only 'installed' packages to keep the list clean
            set selected_pkgs (dpkg-query -W -f='${Package}\t${Status}\n' | grep "install ok installed" | cut -f1 | fzf --multi --header="Select APT packages to remove" --preview "apt-cache show {1}")
    end

    # 4. Guard Clause: Exit if nothing selected (ESC or ctrl-c in fzf)
    if test -z "$selected_pkgs"
        echo (set_color yellow)"Selection cancelled. No packages removed."(set_color normal)
        return 0
    end

    # 5. Execution with Confirmation
    echo (set_color cyan)"The following packages will be removed:"(set_color normal)
    printf "  - %s\n" $selected_pkgs

    read -l -P "Are you sure you want to proceed? [y/N] " confirm
    if not string match -iq "y" -- "$confirm"
        echo "Aborted."
        return 0
    end

    # 6. Perform Removal
    switch $manager
        case snap
            sudo snap remove $selected_pkgs
        case apt dpkg
            sudo apt-get purge -y $selected_pkgs
            # Optional: Clean up orphaned dependencies
            sudo apt-get autoremove -y
    end
end
