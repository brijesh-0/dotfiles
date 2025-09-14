return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- Auto-format on save
	cmd = { "ConformInfo" },
	dependencies = { "williamboman/mason.nvim" },
	keys = {
		{
			"<leader>bf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "v" },
			desc = "Format buffer or range",
		},
	},
	opts = {
		-- Filetype → formatters mapping
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			sh = { "shfmt" },
		},

		-- Auto format on save
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},

		-- Extra formatter configs
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" }, -- indent=2 for shell scripts
			},
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
