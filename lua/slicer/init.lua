local config = require("slicer.config")
local timer = require("slicer.timer")

local M = {}

local function inject_into_lualine()
	local ok, lualine = pcall(require, "lualine")
	if not ok then return end

	local lualine_cfg = lualine.get_config()

	local slicer_component = {
		function() return timer.get_status() end,
		color = { fg = "#FFB86C", gui = "bold" },
	}

	table.insert(lualine_cfg.sections.lualine_x, 1, slicer_component)
	lualine.setup(lualine_cfg)
end

function M.setup(opts)
	config.setup(opts)
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = inject_into_lualine,
	})
end

M.start = timer.start_work
M.extend = timer.extend
M.toggle_pause = timer.toggle_pause
M.stop = timer.stop_timer
M.status = timer.get_status

return M
