return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.2.1", -- ← optional: pin if you want exact known-good version
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				-- Your originals + small modern improvements
				path_display = { "filename_first" },
				preview = {
					filesize_limit = 0.1, -- MB (your setting)
					timeout = 250,
				},
				sorting_strategy = "descending",
				layout_config = {
					horizontal = {
						prompt_position = "bottom",
					},
				},

				-- Nice 2026 defaults (reversible if unwanted)
				prompt_prefix = "   ", -- Added an extra space for breathing room
				selection_caret = "  ", -- No character, just a highlight (cleaner)
				entry_prefix = "  ",

				-- Better insert-mode feel without changing core behavior
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-c>"] = actions.close, -- quick close like many modern UIs
					},
				},
			},

			pickers = {
				live_grep = {
					additional_args = {
						"--glob=!package-lock.json",
						"--glob=!yarn.lock",
						"--glob=!pnpm-lock.yaml",
						"--glob=!node_modules",
						"--glob=!dist",
						"--glob=!build",
						"--smart-case",
					},
				},
				buffers = {
					sort_lastused = true, -- useful & low-impact
				},
			},

			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
	end,

	keys = {
		-- Your exact original keymaps — untouched
		{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "[S]earch [F]iles" },
		{ "<leader>so", "<cmd>Telescope oldfiles<cr>", desc = "[S]earch [O]ld Files" },
		{ "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "[S]earch [B]uffers" },
		{ "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[S]earch in [S]ame Buffer" },

		{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "[S]earch by [G]rep" },
		{ "<leader>*", "<cmd>Telescope grep_string<cr>", desc = "[S]earch word under cursor" },

		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[S]earch [H]elp" },
		{ "<leader>sc", "<cmd>Telescope commands<cr>", desc = "[S]earch [C]ommands" },
		{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "[S]earch [K]eymaps" },
		{ "<leader>sr", "<cmd>Telescope resume<cr>", desc = "[S]earch [R]esume" },

		{ "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", desc = "[D]ocument [S]ymbols" },
		{ "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "[W]orkspace [S]ymbols" },

		{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "[G]it [C]ommits" },
		{ "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "[G]it Buffer [C]ommits" },
		{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "[G]it [B]ranches" },
		{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "[G]it [S]tatus" },

		{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "[S]earch [D]iagnostics" },
		{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "[S]earch [M]arks" },
		{ "<leader>scs", "<cmd>Telescope colorscheme<cr>", desc = "[S]earch [C]olor[S]chemes" },
	},
}
