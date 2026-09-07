local M = {}

--@class SlicerConfig
M.defaults = {
	work_duration = 25 * 60,
	break_duration = 5 * 60,
	extend_amount = 10 * 60,
	gauge_width = 8,
	icons = {
		work = "󰔟 ",
		break_time = "󰒲 ",
		paused = "󰏤 ",
		filled = "█",
		empty = "░",
	},
	notifications = {
		enable = true,
		title = "Slicer",
	},
	bar_color = "#FFB86C"
}

M.options = {}

function M.setup(user_opts)
	M.options = vim.tbl_deep_extend("force", {}, M.defaults, user_opts or {})
end

return M
