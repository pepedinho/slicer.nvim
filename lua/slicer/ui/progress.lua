local M = {}

--- Generate progression gauge
---@param ratio number (entre 0.0 et 1.0)
---@param width integer
---@param filled_char string
---@param empty_char string
---@return string
function M.render_bar(ratio, width, filled_char, empty_char)
	ratio = math.max(0, math.min(1, ratio))
	local filled_len = math.floor(ratio * width + 0.5)
	local empty_len = width - filled_len
	return string.rep(filled_char, filled_len) .. string.rep(empty_char, empty_len)
end

--- Formats the remaining time in MM:SS
---@param seconds integer
---@return string
function M.format_time(seconds)
	local m = math.floor(seconds / 60)
	local s = seconds % 60
	return string.format("%02d:%02d", m, s)
end

return M
