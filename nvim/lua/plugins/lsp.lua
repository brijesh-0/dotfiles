return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- Lua Development Support
		{
			"folke/lazydev.nvim",
		},
		-- Package Management
		{ "mason-org/mason.nvim", cmd = "Mason", opts = {} },
		{ "mason-org/mason-lspconfig.nvim", event = "VeryLazy" },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim", event = "VeryLazy" },
		-- UI Enhancements
		{ "j-hui/fidget.nvim", event = "LspAttach", opts = {} },
	},
	config = function()
		-- 1. SERVER CONFIGURATION
		-- Define servers and any specific overrides here
		local servers = {
			pyright = {},
			ts_ls = {},
			lua_ls = {
				settings = {
					Lua = { completion = { callSnippet = "Replace" } },
				},
			},
			tailwindcss = {
				filetypes = {
					"html",
					"css",
					"scss",
					"sass",
					"postcss",
					"javascriptreact",
					"typescriptreact",
				},
			},
		}

		-- Define tools for Mason to install (formatters, linters)
		local tools_to_install = {
			"stylua",
			"prettier",
			"prettierd",
			"shfmt",
			"black",
			"isort",
		}

		-- 2. LSP ATTACHMENT LOGIC
		-- This runs every time a buffer is attached to an LSP
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if not client then
					return
				end

				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Keymaps: Telescope Integrations
				map("grr", function()
					require("telescope.builtin").lsp_references()
				end, "[G]oto [R]eferences")
				map("gri", function()
					require("telescope.builtin").lsp_implementations()
				end, "[G]oto [I]mplementation")
				map("grd", function()
					require("telescope.builtin").lsp_definitions()
				end, "[G]oto [D]efinition")
				map("grt", function()
					require("telescope.builtin").lsp_type_definitions()
				end, "[G]oto [T]ype Definition")
				map("gW", function()
					require("telescope.builtin").lsp_dynamic_workspace_symbols()
				end, "Open Workspace Symbols")
				-- Keymaps: Native Overrides
				map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("K", vim.lsp.buf.hover, "Hover Documentation")

				-- Feature: Document Highlighting (CursorHold)
				-- Fix: Suppress param-type-mismatch for 0.11 API change
				---@diagnostic disable-next-line: param-type-mismatch
				if
					client:supports_method(
						vim.lsp.protocol.Methods.textDocument_documentHighlight,
						{ bufnr = event.buf }
					)
				then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- Feature: Inlay Hints Toggle
				---@diagnostic disable-next-line: param-type-mismatch
				if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, { bufnr = event.buf }) then
					map("<leader>th", function()
						local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
						vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = event.buf })
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- 3. DIAGNOSTIC UI CONFIGURATION
		vim.diagnostic.config({
			severity_sort = true,
			float = { source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			} or {},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					-- Custom format: "Error: My error message [source]"
					local icons = {
						[vim.diagnostic.severity.ERROR] = "Error",
						[vim.diagnostic.severity.WARN] = "Warn",
						[vim.diagnostic.severity.INFO] = "Info",
						[vim.diagnostic.severity.HINT] = "Hint",
					}
					return string.format("%s: %s", icons[diagnostic.severity], diagnostic.message)
				end,
			},
		})

		-- 4. SETUP EXECUTION
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		require("mason-tool-installer").setup({
			ensure_installed = tools_to_install,
			run_on_start = false,
		})

		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_installation = true,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- Merge default blink capabilities with server specific ones
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

					-- Native Neovim 0.11+ Setup
					vim.lsp.config(server_name, server)
					vim.lsp.enable(server_name)
				end,
			},
		})
	end,
}
