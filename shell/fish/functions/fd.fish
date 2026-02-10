function fd --wraps=fd --description 'fd with default excludes'

    set -l default_excludes \
        .git \
        node_modules \
        dist \
        build \
        venv \
        .venv \
        __pycache__ \
        .cache \
        .next \
        .DS_Store

    set -l extra_args

    for excl in $default_excludes
        set -a extra_args --exclude $excl
    end

    command fd $extra_args --hidden $argv
end
