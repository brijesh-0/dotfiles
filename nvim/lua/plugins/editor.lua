return {
	-- TREESITTER: Syntax Highlighting (Main Branch Strategy)
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			-- 1. Install Parsers (Helper)
			local parsers = {
				"bash",
				"c",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"python",
				"javascript",
				"typescript",
				"tsx", -- Added tsx/typescript explicitly
			}

			for _, parser in ipairs(parsers) do
				local installed = pcall(vim.treesitter.language.get_lang, parser)
				if not installed then
					vim.cmd("TSInstall " .. parser)
				end
			end

			-- 2. FORCE ENABLE HIGHLIGHTING (The Fix)
			-- The 'main' branch no longer auto-starts highlighting via setup().
			-- We must use Neovim's native API to start it on FileType.
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					-- Exclude large files if needed
					local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(args.buf))
					if size > 1024 * 1024 then
						return
					end -- Skip files > 1MB

					-- Try to start treesitter
					local ok, _ = pcall(vim.treesitter.start, args.buf)
					if not ok then
						-- Fail silently if no parser available (fallback to regex syntax)
					end
				end,
			})
		end,
	},

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

				-- Navigation (Jump between changes)
				map("n", "]h", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, "Next Hunk")

				map("n", "[h", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, "Prev Hunk")

				-- Actions (The "Manage Hunks" part you asked for)
				map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage Hunk (Visual)")
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset Hunk (Visual)")
				map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<leader>hd", gs.diffthis, "Diff This")
			end,
		},
	},
}
