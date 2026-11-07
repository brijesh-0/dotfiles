-- SNACKS: Optimized for 0.12
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		animate = { enabled = true },
		gh = { enabled = true },
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		explorer = { enabled = true },
		picker = {
			sources = {
				explorer = {
					layout = { preset = "sidebar", preview = false },
				},
			},
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle.option("conceallevel", { off = 0, on = 2, name = "Conceal" }):map("<leader>uc")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.treesitter():map("<leader>uT")
			end,
		})
	end,
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
		{ "<leader>su", function() Snacks.picker.undo() end, desc = "Visual Undo Tree" },

		-- Pickers menu
		{ "<leader>/", function() Snacks.picker("pickers") end, desc = "Pickers" },

		-- Explorer
		{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },

		-- Git
		{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
		{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
		{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
		{ "<leader>gg", function() Snacks.lazygit.open() end, desc = "Lazygit" },
		{ "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
		{ "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
		{ "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub PRs (open)" },
		{ "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub PRs (all)" },
	},
}
