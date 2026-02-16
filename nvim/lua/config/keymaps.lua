local map = vim.keymap.set

-- 1. CLEAR HIGHLIGHTS (Esc)
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- 2. BETTER SAVE
map("n", "<leader>ww", "<cmd>write<CR>", { desc = "Save File" })

-- 3. DIAGNOSTICS
map("n", "<leader>q", function()
	local ok, snacks = pcall(require, "snacks")
	if ok then
		snacks.picker.diagnostics()
	else
		vim.diagnostic.setloclist()
	end
end, { desc = "Diagnostic List" })

-- 4. TERMINAL ESCAPE
map("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- 5. MOVEMENT (Wrapped Lines)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 6. CENTERED SCROLLING
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- 7. SMART H/L (Simplified expr)
map({ "n", "v", "o" }, "H", "^", { desc = "Start of Line" })
map({ "n", "v", "o" }, "L", "g_", { desc = "End of Line" })

-- 8. PASTE WITHOUT YANK
map("x", "p", [["_c<Esc>p]], { desc = "Paste without overwriting register" })

-- 9. WINDOW NAVIGATION
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
