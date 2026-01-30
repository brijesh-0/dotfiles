-- 1. CLEAR HIGHLIGHTS (Esc)
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 2. BETTER SAVE (Simpler)
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Save File" })

-- 3. DIAGNOSTICS (Use Snacks Picker instead of LocList)
-- If Snacks is not loaded yet, this falls back gracefully or errors.
-- Better to put this in your snacks config, but here is a safe native fallback:
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic List" })

-- 4. TERMINAL ESCAPE
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- 5. MOVEMENT (Wrapped Lines)
vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })

-- 6. CENTERED SCROLLING (Keep Context)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- 7. SMART H/L (Start/End of Line)
vim.keymap.set({ "n", "v", "o" }, "H", function()
	local line = vim.fn.getline(".")
	local first_non_blank_col = vim.fn.match(line, "\\S") + 1
	if vim.fn.col(".") == first_non_blank_col then
		return "0"
	else
		return "^"
	end
end, { expr = true, silent = true, desc = "Smart Start of Line" })

vim.keymap.set({ "n", "v", "o" }, "L", function()
	local line = vim.fn.getline(".")
	local cursor_col = vim.fn.col(".")
	if vim.fn.match(line, "\\S", cursor_col) == -1 then
		return "$"
	else
		return "g_"
	end
end, { expr = true, silent = true, desc = "Smart End of Line" })

-- 8. PASTE WITHOUT YANK (Visual Mode)
vim.keymap.set("x", "p", [["_c<Esc>p]], { desc = "Paste (No Yank)" })

-- 9. WINDOW RESIZING
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Lower Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Upper Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right Window" })
