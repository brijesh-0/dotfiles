function vim_mode
	fish_vi_key_bindings --no-erase insert

	bind -M insert \cf accept-autosuggestion
	bind \cf accept-autosuggestion

	bind -M insert \cn history-search-forward
	bind -M insert \cp history-search-backward
end
