return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown", "quarto" }, -- Lazy load on markdown files
	config = function()
		-- Crucial Neovim settings for internal markdown rendering
		vim.opt.conceallevel = 2 -- Hide markup text like ** or _ unless cursor is on the line
		vim.opt.concealcursor = "nc" -- Keep hidden in Normal and Command modes

		require("render-markdown").setup({
			-- Modern plugins come with presets out of the box
			preset = "obsidian", -- Options: 'obsidian', 'lazy', or 'none'

			anti_conceal = {
				enabled = true, -- Reveals raw text on the line your cursor is currently on
			},

			win_options = {
				conceallevel = {
					rendered = 2,
					raw = 0,
				},
			},
		})
	end,
}
