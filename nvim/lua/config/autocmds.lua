-- Highlight on Yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("native-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Native Treesitter Highlighting (0.12 Optimized)
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("native-treesitter", { clear = true }),
	callback = function(args)
		local bufnr = args.buf
		-- Ensure the buffer is valid and has a filetype
		if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].filetype == "" then
			return
		end

		-- Skip for large files (> 1MB)
		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
		if ok and stats and stats.size > 1024 * 1024 then
			return
		end

		-- Attempt to start treesitter highlighting
		pcall(vim.treesitter.start, bufnr)
	end,
})

-- We use BufWinEnter because it fires earlier in the 0.12 window lifecycle
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("native-fix-picker", { clear = true }),
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local bt = vim.bo[args.buf].buftype
    
    -- Target specifically the snacks picker or any prompt
    if ft == "snacks_picker_input" or bt == "prompt" then
      -- In 0.12, we must use vim.opt_local to ensure the engine 
      -- unbinds the internal completion thread
      vim.opt_local.autocomplete = false
    end
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = vim.api.nvim_create_augroup("checktime", { clear = true }),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
  pattern = { "text", "plaintext", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})


-- Auto create dir when saving a file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function(event)
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
-- Set filetype for .env and .env.* files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("env_filetype", { clear = true }),
  pattern = { "*.env", ".env.*" },
  callback = function()
    vim.opt_local.filetype = "sh"
  end,
})

-- Set filetype for .toml files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("toml_filetype", { clear = true }),
  pattern = { "*.tomg-config*" },
  callback = function()
    vim.opt_local.filetype = "toml"
  end,
})

-- Set filetype for .ejs files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("ejs_filetype", { clear = true }),
  pattern = { "*.ejs", "*.ejs.t" },
  callback = function()
    vim.opt_local.filetype = "embedded_template"
  end,
})

-- Set filetype for .code-snippets files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("code_snippets_filetype", { clear = true }),
  pattern = { "*.code-snippets" },
  callback = function()
    vim.opt_local.filetype = "json"
  end,
})
