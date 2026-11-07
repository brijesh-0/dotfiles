-- MINI: ai, surround, pairs, operators, hipatterns, statusline
return {
	"echasnovski/mini.nvim",
	version = false,
	event = "VeryLazy",
	config = function()
		-- Text objects (a/i): function, argument, quotes, brackets, etc.
		require("mini.ai").setup({ n_lines = 500 })

		-- sa / sd / sr: add, delete, replace surroundings
		require("mini.surround").setup()

		-- Autopairs (overtype closing char, delete pair with <BS>)
		require("mini.pairs").setup()

		-- gr / gx / gm / gs / g=: replace, exchange, multiply, sort, evaluate
		require("mini.operators").setup()

		-- Highlight TODO/FIXME/HACK/NOTE and hex colors
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})

		-- Statusline (git branch comes from gitsigns)
		require("mini.statusline").setup({ use_icons = vim.g.have_nerd_font })
	end,
}
