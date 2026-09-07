if vim.g.loaded_slicer == 1 then
	return
end
vim.g.loaded_slicer = 1

-- On définit les commandes utilisateur sans importer immédiatement le module Lua
vim.api.nvim_create_user_command("SlicerStart", function(opts)
	local duration = tonumber(opts.args)
	require("slicer").start(duration and (duration * 60) or nil)
end, { nargs = "?" })

vim.api.nvim_create_user_command("SlicerExtend", function(opts)
	local duration = tonumber(opts.args)
	require("slicer").extend(duration and (duration * 60) or nil)
end, { nargs = "?" })

vim.api.nvim_create_user_command("SlicerPause", function()
	require("slicer").toggle_pause()
end, {})

vim.api.nvim_create_user_command("SlicerStop", function()
	require("slicer").stop()
end, {})
