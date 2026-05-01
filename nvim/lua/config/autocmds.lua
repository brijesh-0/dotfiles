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
