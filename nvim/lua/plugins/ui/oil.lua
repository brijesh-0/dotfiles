-- OIL: Floating file manager
return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	keys = {
		{ "-", "<CMD>Oil --float<CR>", desc = "Open parent directory" },
	},
	opts = {
		float = { border = "rounded" },
		view_options = { show_hidden = true },
	},
}
