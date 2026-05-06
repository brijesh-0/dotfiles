function vim_mode
    fish_vi_key_bindings --no-erase insert

    set -g fish_escape_delay_ms 10

    bind \cf accept-autosuggestion
    bind -M insert \cf accept-autosuggestion

    bind \cn history-search-forward
    bind \cp history-search-backward
    bind -M insert \cn history-search-forward
    bind -M insert \cp history-search-backward


    bind -M default H beginning-of-line
    bind -M default L end-of-line

    bind -M default \ee edit_command_buffer
end
