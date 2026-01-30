return {
	-- 1. LSP Configuration (Lazy Loaded)
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
			-- Add Vtsls plugin for extra commands (optional but recommended)
			"yioneko/nvim-vtsls",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			-- Configure Diagnostics (Global)
			vim.diagnostic.config({
				float = { border = "rounded" },
				-- ENABLE INLINE DIAGNOSTICS (Virtual Text)
				virtual_text = {
					prefix = "●", -- Could be '■', '▎', 'x'
					source = "if_many", -- Or "always"
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- MODIFIED: Global on_attach function for LSP keymaps
			local on_attach = function(client, bufnr)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
				end

				-- Native LSP Actions (Always work, instant)
				map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				map("gy", vim.lsp.buf.type_definition, "[G]oto T[y]pe Definition")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				-- Snacks Pickers (For "list" scenarios - with fallback)
				map("gr", function()
					if pcall(require, "snacks") then
						Snacks.picker.lsp_references()
					else
						vim.lsp.buf.references()
					end
				end, "[G]oto [R]eferences (Picker)")
			end

			-- ADDED: Define Border Handlers
			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
			}

			-- MODIFIED: Added ui.border to Mason setup
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "vtsls", "basedpyright", "ruff" },
				automatic_installation = true,
				handlers = {
					-- MODIFIED: Default Handler now includes handlers and on_attach
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
							handlers = handlers,
							on_attach = on_attach,
						})
					end,

					-- MODIFIED: PYTHON - Added handlers and on_attach
					["basedpyright"] = function()
						lspconfig.basedpyright.setup({
							capabilities = capabilities,
							handlers = handlers,
							on_attach = on_attach,
							settings = {
								basedpyright = {
									disableOrganizeImports = true, -- Let Ruff handle this
									analysis = {
										ignore = { "*" },
										typeCheckingMode = "off",
										diagnosticSeverityOverrides = {
											reportGeneralTypeIssues = "error", -- Catch "int + string" errors
											reportOptionalSubscript = "error", -- Catch "None['key']" errors
											reportOptionalMemberAccess = "error", -- Catch "None.attr" errors
											reportOptionalCall = "error", -- Catch "None()" errors

											-- Ensure everything else stays dead silent
											reportMissingTypeStubs = "none",
											reportUnknownMemberType = "none",
											reportUnknownArgumentType = "none",
											reportUnknownVariableType = "none",
										},
									},
								},
							},
						})
					end,

					-- MODIFIED: Ruff - Added handlers, merged on_attach
					["ruff"] = function()
						lspconfig.ruff.setup({
							capabilities = capabilities,
							handlers = handlers,
							on_attach = function(client, bufnr)
								-- Call global on_attach first
								on_attach(client, bufnr)
								-- Then apply Ruff-specific overrides
								client.server_capabilities.hoverProvider = false
								client.server_capabilities.completionProvider = false
							end,
						})
					end,

					-- MODIFIED: TYPESCRIPT - Added handlers, merged on_attach, added semantic token fix
					["vtsls"] = function()
						lspconfig.vtsls.setup({
							capabilities = capabilities,
							handlers = handlers,
							on_attach = function(client, bufnr)
								-- Call global on_attach first
								on_attach(client, bufnr)
								-- DISABLE SEMANTIC TOKENS (Fix for "No Colors" in TS)
								client.server_capabilities.semanticTokensProvider = nil
							end,
							settings = {
								typescript = {
									updateImportsOnFileMove = { enabled = "always" },
									suggest = { completeFunctionCalls = true },
								},
								vtsls = {
									enableMoveToFileCodeAction = true,
									autoUseWorkspaceTsdk = true,
									experimental = { completion = { enableServerSideFuzzyMatch = true } },
								},
							},
						})
					end,
				},
			})
		end,
	},

	-- 2. Completion (Lazy Loaded by InsertEnter or LSP)
	{
		"saghen/blink.cmp",
		version = "*",
		event = "InsertEnter", -- LOAD ONLY WHEN TYPING
		-- or "LspAttach" if you want it ready before typing
		dependencies = "rafamadriz/friendly-snippets",
		opts = {
			keymap = { preset = "default" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			signature = { enabled = true },
		},
	},
}
