-- Leader key settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- General settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 15
vim.opt.confirm = true
vim.opt.linebreak = true
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.opt.winborder = "rounded"
vim.opt.pumborder = "single"
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.autoread = true -- Auto reload files changed outside vim
vim.opt.autowrite = true -- Auto save

-- 0.12 Native Features
vim.opt.autocomplete = true -- Native auto-completion
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldtext = "" -- Use native treesitter foldtext

vim.opt.laststatus = 3 -- Global statusline

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

vim.opt.statusline = "%!v:lua.MyStatusLine()"

vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.filetype.add({
  extension = {
    env = "dotenv",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
  },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc",
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})
