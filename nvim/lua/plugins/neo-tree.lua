return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	keys = {
		{
			"<leader>e",
			function()
				if vim.bo.filetype == "neo-tree" then
					vim.cmd("wincmd p")
				else
					vim.cmd("Neotree focus filesystem")
				end
			end,
			desc = "Focus Tree/Editor",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	init = function()
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
			once = true,
			callback = function()
				local stats = vim.uv.fs_stat(vim.api.nvim_buf_get_name(0))
				if stats and stats.type == "directory" then
					require("neo-tree.setup.netrw").hijack()
				end
			end,
		})
	end,
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			sources = { "filesystem", "buffers", "git_status", "document_symbols" },
			auto_clean_empty_groups = true,
			hide_root_node = true,
			use_popups_for_input = true,
			git_status_async = true,
			git_status_timeout = 1000,
			diagnostics = {
				symbols = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = true,
					hide_gitignored = true,
					never_show = { ".DS_Store", "thumbs.db" },
					always_show = {},
					always_show_by_pattern = {
						".env*",
						".gitignore*",
					},
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
				use_libuv_file_watcher = true,
			},
			window = {
				position = "left",
				width = 30,
				mappings = {
					["<cr>"] = "open",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["h"] = "close_node",
					["l"] = "open",
					["a"] = "add",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["q"] = "close_window",
					["R"] = "refresh",
					["<2-LeftMouse>"] = "open",
					["<C-c>"] = "copy_to_clipboard",
					["<C-v>"] = "paste_from_clipboard",
					["<C-r>"] = "refresh",
					-- Focus jump logic within the tree window
					["<leader>e"] = function()
						vim.cmd("wincmd p")
					end,
				},
			},
			default_component_configs = {
				indent = {
					padding = 1,
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "󰉖",
					folder_empty_open = "󰷏",
					default = "",
				},
				git_status = {
					symbols = {
						added = "✚",
						deleted = "✖",
						modified = "",
						renamed = "󰁕",
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
					align = "right",
				},
			},
		})

		-- Auto-open on every new tab
		vim.api.nvim_create_autocmd("TabEnter", {
			group = vim.api.nvim_create_augroup("NeotreeOnNewTab", { clear = true }),
			callback = function()
				vim.cmd("Neotree show")
			end,
		})
	end,
}
