-- WHICH-KEY
return {
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
			{ "<leader>u", group = "UI Toggles" },
		},
	},
}
