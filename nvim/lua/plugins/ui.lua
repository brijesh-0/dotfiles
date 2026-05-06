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
			-- Find (files/objects)
			{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
			{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers" },
			{ "<leader>fr", function() Snacks.picker.resume() end, desc = "Resume Last" },

			-- Search (text/content)
			{ "<leader>ss", function() Snacks.picker.lines() end, desc = "Search Same Buffer" },
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep Text" },
			{ "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
			{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
			{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
			{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },

			-- Pickers menu
			{ "<leader>/", function() Snacks.picker("pickers") end, desc = "Pickers" },

			-- Explorer
			{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },

			-- Git
			{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
			{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
			{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
			{ "<leader>gg", function() Snacks.lazygit.open() end, desc = "Lazygit" },
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
				{ "<leader>f", group = "Find" },
				{ "<leader>s", group = "Search" },
				{ "<leader>w", group = "Write" },
				{ "<leader>h", group = "Hunks" },
				{ "<leader>q", group = "Quit" },
			},
		},
	},
}
