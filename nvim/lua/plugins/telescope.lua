return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		-- 📁 Files & Buffers
		{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "[S]earch [F]iles" },
		{ "<leader>so", "<cmd>Telescope oldfiles<cr>", desc = "[S]earch [O]ld Files" },
		{ "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "[S]earch [B]uffers" },
		{ "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[S]earch in [S]ame Buffer" },

		-- 🔍 Grep & Text
		{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "[S]earch by [G]rep" },
		{ "<leader>*", "<cmd>Telescope grep_string<cr>", desc = "[S]earch word under cursor" },

		-- ⚙️ Utilities
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[S]earch [H]elp" },
		{ "<leader>sc", "<cmd>Telescope commands<cr>", desc = "[S]earch [C]ommands" },
		{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "[S]earch [K]eymaps" },
		{ "<leader>sr", "<cmd>Telescope resume<cr>", desc = "[S]earch [R]esume" },

		-- ⚡ LSP
		{ "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", desc = "[D]ocument [S]ymbols" },
		{ "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "[W]orkspace [S]ymbols" },

		-- 🧑‍💻 Git
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "[G]it [C]ommits" },
		{ "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "[G]it Buffer [C]ommits" },
		{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "[G]it [B]ranches" },
		{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "[G]it [S]tatus" },

		-- 🔧 Misc
		{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "[S]earch [D]iagnostics" },
		{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "[S]earch [M]arks" },
		{ "<leader>scs", "<cmd>Telescope colorscheme<cr>", desc = "[S]earch [C]olor[S]chemes" },
	},
}
