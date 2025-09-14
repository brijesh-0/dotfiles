return {
	"nmac427/guess-indent.nvim",
	event = "BufReadPre", -- load before opening files
	config = function()
		require("guess-indent").setup({
			auto_cmd = true, -- set indent when opening buffer
			override_editorconfig = false,
			filetype_exclude = { "netrw", "tutor" },
			buftype_exclude = { "help", "nofile", "terminal", "prompt" },
		})
	end,
}
