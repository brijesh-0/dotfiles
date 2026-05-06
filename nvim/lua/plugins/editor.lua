return {
	-- GITSIGNS: Git integration (Signs, Hunk Actions)
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				-- Navigation
				map("n", "]h", gs.next_hunk, "Next Hunk")
				map("n", "[h", gs.prev_hunk, "Prev Hunk")

				-- Actions
				map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
				map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
				map("n", "<leader>hd", gs.diffthis, "Diff This")
				map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>hb", gs.blame_line, "Blame Line")
				map("n", "<leader>hB", gs.blame, "Blame")
			end,
		},
	},
	{
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
}
