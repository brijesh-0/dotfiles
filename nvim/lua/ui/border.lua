return {
	"nvim-tree/nvim-web-devicons",
	event = "BufReadPre",
	config = function()
		local orig = vim.api.nvim_open_win
		vim.api.nvim_open_win = function(buf, enter, config)
			config.border = config.border or "rounded" -- "single", "double", "shadow", etc.
			return orig(buf, enter, config)
		end
	end,
}
