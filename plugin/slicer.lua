if vim.g.loaded_slicer == 1 then
	return
end
vim.g.loaded_slicer = 1

local slicer = require("slicer")

vim.api.nvim_create_user_command("SlicerStart", function(opts)
	local duration = tonumber(opts.args)
	slicer.start(duration and (duration * 60) or nil)
end, { nargs = "?" })

vim.api.nvim_create_user_command("SlicerExtend", function(opts)
	local duration = tonumber(opts.args)
	slicer.extend(duration and (duration * 60) or nil)
end, { nargs = "?" })

vim.api.nvim_create_user_command("SlicerPause", function()
	slicer.toggle_pause()
end, {})

vim.api.nvim_create_user_command("SlicerStop", function()
	slicer.stop()
end, {})
