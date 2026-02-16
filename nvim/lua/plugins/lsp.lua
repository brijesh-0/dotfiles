return {
	-- 1. LSP Configuration
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
			"yioneko/nvim-vtsls",
			{ "folke/lazydev.nvim", ft = "lua", opts = {} },
			{ "j-hui/fidget.nvim", opts = {} }, -- Progress tracking (Trace)
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			-- Configure Diagnostics (Global)
			vim.diagnostic.config({
				float = { border = "rounded" },
				virtual_text = {
					prefix = "●",
					source = "if_many",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- The Global Attach Function (Optimized)
			local on_attach = function(client, bufnr)
				local has_snacks, snacks = pcall(require, "snacks")

				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
				end

				-- Cached Picker Logic
				local picker = function(name, fallback)
					return function()
						if has_snacks then
							snacks.picker[name]({ jump_to_single = true })
						else
							fallback()
						end
					end
				end

				map("grd", picker("lsp_definitions", vim.lsp.buf.definition), "Goto Definition")
				map("grr", picker("lsp_references", vim.lsp.buf.references), "References")
				map("gri", picker("lsp_implementations", vim.lsp.buf.implementation), "Implementation")
				map("gry", picker("lsp_type_definitions", vim.lsp.buf.type_definition), "Type Definition")
				map("grD", vim.lsp.buf.declaration, "Goto Declaration")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
			end

			-- Border Handlers
			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
			}

			require("mason").setup({ ui = { border = "rounded" } })
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "vtsls", "basedpyright", "ruff" },
				automatic_installation = true,
				handlers = {
					-- Default Handler
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
							handlers = handlers,
							on_attach = on_attach,
						})
					end,

					-- Python: Basedpyright
					["basedpyright"] = function()
						lspconfig.basedpyright.setup({
							capabilities = capabilities,
							handlers = handlers,
							on_attach = on_attach,
							settings = {
								basedpyright = {
									disableOrganizeImports = true,
									analysis = {
										typeCheckingMode = "basic",
										-- Disable diagnostics that Ruff handles better
										diagnosticSeverityOverrides = {
											reportUnusedImport = "none",
											reportUnusedVariable = "none",
											reportUndefinedVariable = "none",
										},
									},
								},
							},
						})
					end,

					-- Python: Ruff (The Linter)
					["ruff"] = function()
						lspconfig.ruff.setup({
							capabilities = capabilities,
							handlers = handlers,
							on_attach = function(client, bufnr)
								on_attach(client, bufnr)
								client.server_capabilities.hoverProvider = false
								client.server_capabilities.completionProvider = false
							end,
						})
					end,

					-- TypeScript: Vtsls
					["vtsls"] = function()
						lspconfig.vtsls.setup({
							capabilities = capabilities,
							handlers = handlers,
							on_attach = function(client, bufnr)
								on_attach(client, bufnr)
								-- Fix for "flat/no color" syntax highlighting in TS
								client.server_capabilities.semanticTokensProvider = nil
							end,
							settings = {
								typescript = {
									updateImportsOnFileMove = { enabled = "always" },
									suggest = { completeFunctionCalls = true },
									preferences = { preferGoToSourceDefinition = true },
								},
							},
						})
					end,

					-- Lua: lua_ls
					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							handlers = handlers,
							on_attach = on_attach,
							settings = {
								Lua = {
									diagnostics = { globals = { "vim" } },
									workspace = { checkThirdParty = false },
									telemetry = { enabled = false },
								},
							},
						})
					end,
				},
			})
		end,
	},

	-- 2. Completion (Blink.cmp)
	{
		"saghen/blink.cmp",
		version = "*",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			keymap = { preset = "default" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			signature = { enabled = true, window = { border = "rounded" } },
			completion = {
				menu = { border = "rounded" },
				documentation = { window = { border = "rounded" } },
			},
		},
	},
}
