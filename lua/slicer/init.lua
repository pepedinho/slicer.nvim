local config = require("slicer.config")
local timer = require("slicer.timer")

local M = {}


function M.setup(opts)
	config.setup(opts)
end

M.start = timer.start_work
M.extend = timer.extend
M.toggle_pause = timer.toggle_pause
M.stop = timer.stop_timer
M.status = timer.get_status

return M
