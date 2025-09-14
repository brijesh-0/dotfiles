return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {
		default_file_explorer = true, -- replace netrw
		columns = {
			"icon", -- file icons
		},
		view_options = {
			show_hidden = true, -- show dotfiles
			is_hidden_file = function(name, bufnr)
				return vim.startswith(name, ".") -- hide dotfiles unless overridden
			end,
			natural_order = true, -- sort like human (e.g. file2 < file10)
		},
	},
}
