return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
	    -- Keymaps using <leader> as prefix
	    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
	    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
	    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
	    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
	    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
	    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
	    { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in Buffer" },
	  },
}
