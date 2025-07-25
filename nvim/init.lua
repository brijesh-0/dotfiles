-- Leader key settings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- General settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = true
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

-- Clipboard setting
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- List characters configuration
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Require keymaps and lazy.nvim
require("config.keymaps")
require("config.lazy")

