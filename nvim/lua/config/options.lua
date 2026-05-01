-- Leader key settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- General settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 15
vim.o.confirm = true
vim.o.linebreak = true
vim.o.clipboard = "unnamedplus"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.winborder = "rounded"
vim.o.pumborder = "rounded"

-- 0.12 Native Features
vim.o.autocomplete = true -- Native auto-completion
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldtext = "" -- Use native treesitter foldtext

vim.o.laststatus = 3 -- Global statusline

function MyStatusLine()
  return table.concat({
    " %f",       -- File path
    " %m",       -- Modified flag
    "%=",        -- Right align spacer
    " %y ",      -- Filetype
    " %l:%c ",   -- Line:Column
    " %P ",      -- Percentage through file
  })
end

vim.o.statusline = "%!v:lua.MyStatusLine()"

vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
