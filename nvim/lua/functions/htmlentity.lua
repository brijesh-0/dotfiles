-- Helper function to execute the Python HTML transformation using shell filters
local function html_transform(mode, range_type)
    -- Map 'encode' to html.escape and 'decode' to html.unescape
    local python_func = (mode == "encode") and "html.escape" or "html.unescape"
    local range = (range_type == 0) and "%" or "'<,'>"

    -- Construct the shell command just like your URL one
    local cmd = string.format(
        "%s!python3 -c \"import sys, html; print(%s(sys.stdin.read()), end='')\"",
        range,
        python_func
    )
    vim.cmd(cmd)
end

-- 1. HTML Decode Command
vim.api.nvim_create_user_command("HtmlDecode", function(opts)
    html_transform("decode", opts.range)
end, { range = true, desc = "Decode HTML entities back to normal text" })

-- 2. HTML Encode Command
vim.api.nvim_create_user_command("HtmlEncode", function(opts)
    html_transform("encode", opts.range)
end, { range = true, desc = "Encode syntax characters into HTML entities" })
