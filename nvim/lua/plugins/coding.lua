return {
	-- CONFORM: Formatting
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>bf",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettierd", "prettier", stop_after_first = true },
				jsonc = { "prettierd", "prettier", stop_after_first = true },
				graphql = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				python = { "ruff_format", "ruff_organize_imports" },
				sh = { "shfmt" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettier" },
			},
			format_on_save = { timeout_ms = 500 },
		},
	},
}
