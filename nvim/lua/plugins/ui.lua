return {
	-- THEME: Catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "mocha",
			integrations = {
				snacks = true,
				treesitter = true,
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- SNACKS: Optimized for 0.12
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			explorer = { enabled = true },
			picker = {
				sources = {
					explorer = {
						layout = { preset = "sidebar", preview = false },
					},
				},
			},
		},
		keys = {
			{ "<leader>sf", function() Snacks.picker.files() end, desc = "Find Files" },
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep Text" },
			{ "<leader>sb", function() Snacks.picker.buffers() end, desc = "Buffers" },
			{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
			{ "<leader>/", function() Snacks.picker("pickers") end, desc = "Pickers" },
		},
	},

	-- OIL: Floating file manager
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		keys = {
			{ "-", "<CMD>Oil --float<CR>", desc = "Open parent directory" },
		},
		opts = {
			float = { border = "rounded" },
			view_options = { show_hidden = true },
		},
	},

	-- WHICH-KEY
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			spec = {
				{ "<leader>g", group = "Git" },
				{ "<leader>s", group = "Search" },
				{ "<leader>w", group = "Write" },
			},
		},
	},
}
