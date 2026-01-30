-- Highlight on Yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- enable inlay hints
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(args)
-- 		vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
-- 	end,
-- })
