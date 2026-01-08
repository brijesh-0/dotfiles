-- Define the theme configurations with 'name', 'repo', and 'colorscheme'
local themes = {
	catppuccin = {
		name = "catppuccin",
		repo = "catppuccin/nvim",
		colorscheme = { "catppuccin-mocha", "catppuccin-latte" }, -- Example: multiple options for colorschemes
	},
	tokyonight = {
		name = "tokyonight",
		repo = "folke/tokyonight.nvim",
		colorscheme = { "tokyonight-night", "tokyonight-day", "tokyonight-moon" }, -- Multiple variants
	},
	github = {
		name = "github-theme",
		repo = "projekt0n/github-nvim-theme",
		colorscheme = { "github_dark_dimmed", "github_light" },
	},
	kanagawa = {
		name = "kanagawa",
		repo = "rebelot/kanagawa.nvim",
		colorscheme = { "kanagawa-wave", "kanagawa-dragon" },
	},
	onedark = {
		name = "OneDark",
		repo = "olimorris/onedarkpro.nvim",
		colorscheme = { "onedark", "onelight", "onedark_vivid", "onedark_dark", "vaporwave" },
	},
	monokai = {
		name = "Monokai",
		repo = "loctvl842/monokai-pro.nvim",
		colorscheme = { "monokai-pro", "monokai-spectrum", "monokai-octagon", "monokai-machine" },
	},
}

local selected_theme_key = "kanagawa" -- Change this value to switch themes

local selected_colorscheme = themes[selected_theme_key].colorscheme[1] -- Default to the first option

return {
	{
		themes[selected_theme_key].repo,
		name = themes[selected_theme_key].name, -- optional alias
		lazy = false,
		priority = 1000,
		opts = {
			-- filter = "octagon",
		},
		config = function(_, opts)
			-- Apply the selected colorscheme
			-- require(selected_colorscheme).setup(opts)
			vim.cmd.colorscheme(selected_colorscheme)
		end,
	},
}
