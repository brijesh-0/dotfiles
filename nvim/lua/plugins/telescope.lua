return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
		-- Keymaps using <leader> as prefix
		{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
		{ "<leader>so", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
		{ "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
		{ "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in Buffer" },
	},
}
