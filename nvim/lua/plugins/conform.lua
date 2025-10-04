return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- auto-format on save
	cmd = { "ConformInfo" },
	dependencies = { "williamboman/mason.nvim" },
	keys = {
		{
			"<leader>bf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "v" },
			desc = "format buffer or range",
		},
	},
	opts = {
		-- filetype → formatters mapping
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			graphql = { "prettier" },
			sh = { "shfmt" },
		},

		-- auto format on save
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},

		default_format_opts = {
			lsp_format = "fallback",
		},

		-- extra formatter configs
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
