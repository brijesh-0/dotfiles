-- Helper function to execute the Python URL transformation
local function url_transform(mode, range_type)
	local python_func = (mode == "encode") and "urllib.parse.quote" or "urllib.parse.unquote"
	local range = range_type == 0 and "%" or "'<,'>"

	-- We use print(...) to output the result back to the buffer
	local cmd = string.format(
		"%s!python3 -c \"import sys, urllib.parse; print(%s(sys.stdin.read().strip()), end='')\"",
		range,
		python_func
	)
	vim.cmd(cmd)
end

-- 1. URL Decode Command
vim.api.nvim_create_user_command("URLDecode", function(opts)
	url_transform("decode", opts.range)
end, { range = true, desc = "Decode URL-encoded text" })

-- 2. URL Encode Command
vim.api.nvim_create_user_command("URLEncode", function(opts)
	url_transform("encode", opts.range)
end, { range = true, desc = "Encode text for a URL" })
