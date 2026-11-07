return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")

		ts.setup({
			highlight = { enable = true },
			indent = { enable = true },
		})

		-- This handles the actual installation of the parsers
		ts.install({
			-- Core / Web
			"lua",
			"vim",
			"vimdoc",
			"query", -- Essential for Treesitter itself
			"javascript",
			"typescript",
			"tsx",
			"html",
			"css",
			"json",
			"yaml",

			-- Scripting & Shell
			"python",
			"bash",
			"fish",

			-- Systems & Config
			"rust",
			"dockerfile",
			"toml",
			"markdown",
			"markdown_inline", -- Required for proper doc highlighting
		})
	end,
}
