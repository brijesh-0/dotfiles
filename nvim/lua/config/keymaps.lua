vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Intelligent goto start of line:
-- Toggles between the first non-blank character (^) and the absolute start (0).
vim.keymap.set({ "n", "v", "o" }, "H", function()
	local line = vim.fn.getline(".")
	-- Find the column of the first non-whitespace character.
	-- `vim.fn.match` returns a 0-based index. We add 1 to get the 1-based column.
	local first_non_blank_col = vim.fn.match(line, "\\S") + 1

	-- If the cursor's current column is the same as the first non-blank column,
	-- or if there's no non-blank character on the line, jump to the absolute start.
	if vim.fn.col(".") == first_non_blank_col then
		return "0"
	-- Otherwise, jump to the first non-blank character.
	else
		return "^"
	end
end, { noremap = true, expr = true, silent = true })

-- Intelligent goto end of line: Move to last non-blank (g_) if non-whitespace exists after cursor, else absolute end ($)
vim.keymap.set({ "n", "v", "o" }, "L", function()
	local line = vim.fn.getline(".") -- Get current line
	local cursor_col = vim.fn.col(".") -- Get cursor column (1-based)
	-- Check for non-whitespace from cursor onward
	if vim.fn.match(line, "\\S", cursor_col) == -1 then
		return "$" -- No non-whitespace after cursor: go to end of line
	else
		return "g_" -- Non-whitespace exists: go to last non-blank
	end
end, { noremap = true, expr = true, silent = true })

vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "LSP: Hover info" })

vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
