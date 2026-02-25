return {
	-- THEMES
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- Load this first
		opts = {
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			transparent_background = false, -- Set to true if you want your terminal bg
			integrations = {
				mini = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				snacks = true, -- Built-in support for snacks.nvim
				treesitter = true,
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin") -- Set as default
		end,
	},

	{
		"rebelot/kanagawa.nvim",
		lazy = true, -- Lazy load since we aren't using it by default
		opts = {
			compile = true, -- Compile for startup speed
			undercurl = true,
			commentStyle = { italic = true },
			keywordStyle = { italic = true },
			theme = "wave", -- wave, dragon, lotus
			colors = {
				palette = {},
				theme = { wave = {}, dragon = {}, lotus = {} },
			},
		},
	},

	-- SNACKS: The "Swiss Army Knife"

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
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			explorer = { enabled = true }, -- Enable the explorer module
			picker = {
				sources = {
					explorer = {
						layout = { preset = "sidebar", preview = false },
						auto_close = false,
						jump = { close = false },
					},
				},
			},
		},
		keys = {
			-- File Navigation
			{
				"<leader>sf",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep Text",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lines()
				end,
				desc = "Search Buffer",
			},
			{
				"<leader>sb",
				function()
					Snacks.picker.buffers({
						layout = { preset = "select", preview = false },
						focus = "list",
					})
				end,
				desc = "Buffers",
			},
			{
				"<leader>sr",
				function()
					Snacks.picker.resume()
				end,
				desc = "Resume last picker search",
			},

			-- LSP-Adjacent Pickers (Global)
			{
				"<leader>ds",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "[D]ocument [S]ymbols",
			},
			{
				"<leader>ws",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "[W]orkspace [S]ymbols",
			},
			{
				"<leader>sd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "[S]earch [D]iagnostics",
			},
			{
				"<leader>sm",
				function()
					Snacks.picker.marks()
				end,
				desc = "[S]earch [M]arks",
			},
			{
				"<leader>scs",
				function()
					Snacks.picker.colorschemes()
				end,
				desc = "[S]earch [C]olorschemes",
			},

			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "File Explorer",
			},
			{
				"<leader>/",
				function()
					Snacks.picker("pickers")
				end,
				desc = "Search picker list",
			},
			{
				"<leader>?",
				function()
					Snacks.picker("keymaps")
				end,
				desc = "Search keymaps",
			},

			-- Themes
			{
				"<leader>th",
				function()
					vim.cmd("colorscheme kanagawa")
				end,
				desc = "Switch to Kanagawa",
			},
			{
				"<leader>tc",
				function()
					vim.cmd("colorscheme catppuccin")
				end,
				desc = "Switch to Catppuccin",
			},
		},
	},

	-- MINI
	{
		"nvim-mini/mini.surround",
		version = "*",
		opts = {},
	},
	{
		"nvim-mini/mini.pairs",
		version = "*",
		event = "InsertEnter",
		opts = {},
	},
	{
		"nvim-mini/mini.statusline",
		version = "*",
		opts = {},
	},

	-- Oil
	{
		"stevearc/oil.nvim",
		-- This ensures the plugin only loads when you hit the keymap or run :Oil
		cmd = "Oil",
		keys = {
			{ "-", "<CMD>Oil --float<CR>", desc = "Open parent directory (floating)" },
		},
		opts = {
			-- Basic floating window configuration
			float = {
				padding = 2,
				max_width = 0.7, -- 0 means no limit
				max_height = 0.7,
				border = "rounded", -- Options: "single", "double", "shadow", "rounded"
			},
			quit_on_open = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
			},
		},
	},

	-- WHICH-KEY: Keybinding Helper
	{
		"folke/which-key.nvim",
		event = "VeryLazy", -- Load after startup
		opts = {
			preset = "modern", -- The new clean look (vs "classic")
			delay = 500, -- Delay before showing the popup (adjust to preference)
			spec = {
				{ "<leader>c", group = "Code" }, -- For Conform/Lint mappings
				{ "<leader>g", group = "Git" }, -- For Lazygit
				{ "<leader>s", group = "Search" }, -- For Grep/Buffers
				{ "<leader>t", group = "Toggle/Theme" }, -- For Colorschemes
				{ "<leader>w", group = "Window/Write" }, -- For Save/Windows
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group
			},
		},
	},
}
