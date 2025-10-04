return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "benomahony/oil-git.nvim" },
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
		lsp_file_methods = {
			enabled = true,
			timeout_ms = 1000,
			autosave_changes = true,
		},

		float = {
			padding = 2,
			max_width = 0.5, -- You can adjust this value to make it take up half of the screen
			max_height = 0.6, -- This can be adjusted similarly to make the window not too tall
			border = "rounded",
			win_options = {
				winblend = 0,
			},
			preview_split = "auto", -- You can keep this as "auto" or specify a direction like "below"
			override = function(conf)
				-- Ensure it's centered on the screen
				conf.row = math.floor((vim.o.lines - conf.height) / 2)
				conf.col = math.floor((vim.o.columns - conf.width) / 2)
				return conf
			end,
		},

		preview_win = {
			update_on_cursor_moved = true,
			preview_method = "fast_scratch", -- Ensures fast preview
			disable_preview = function(filename)
				return false
			end,
			win_options = {
				-- Customize preview window's settings if needed
				wrap = false,
			},
		},

		use_default_keymaps = true,
	},
}
