local map = vim.keymap.set

-- 1. CLEAR HIGHLIGHTS
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })

-- 2. BETTER SAVE
map("n", "<leader>ww", "<cmd>write<CR>", { desc = "Save File" })

-- 3. NATIVE UNDOTREE
map("n", "<leader>u", "<cmd>Undotree<CR>", { desc = "Toggle Undotree" })

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

-- 7. SMART H/L
map({ "n", "v", "o" }, "H", "^", { desc = "Start of Line" })
map({ "n", "v", "o" }, "L", "g_", { desc = "End of Line" })

-- 8. PASTE WITHOUT YANK
map("x", "p", [["_c<Esc>p]], { desc = "Paste without yank" })

-- 9. WINDOW NAVIGATION
map("n", "<C-h>", "<C-w>h", { desc = "Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Right Window" })
