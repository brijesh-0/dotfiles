# Jump to a Git worktree selected with fzf.
function gw --description 'Jump to a Git worktree'
    set -l path (git worktree list | fzf | awk '{print $1}')

    if test -n "$path"
        cd "$path"
    end
end
