local config = require("slicer.config")
local ui = require("slicer.ui.progress")

local M = {}

M.STATE = {
	STOPPED = "STOPPED",
	WORKING = "WORKING",
	PAUSED = "PAUSED",
	BREAK = "BREAK",
}

M.current_state = M.STATE.STOPPED
M.time_remaining = 0
M.total_duration = 0
local uv_timer = nil

local function notify(msg, level)
	level = level or vim.log.levels.INFO
	if config.options.notifications and config.options.notifications.enabled then
		vim.notify(msg, level, { title = config.options.notifications.title or "Slicer" })
	end
end

local function tick()
	if M.current_state == M.STATE.PAUSED or M.current_state == M.STATE.STOPPED then
		return
	end

	if M.time_remaining > 0 then
		M.time_remaining = M.time_remaining - 1
	else
		local previous_state = M.current_state
		M.stop_timer()

		if previous_state == M.STATE.WORKING then
			notify("Slice ended ! Take time to relax 🍵", vim.log.levels.WARN)
		else
			notify("Break finished ! Ready to work ?", vim.log.levels.INFO)
		end
	end

	vim.schedule(function()
		vim.cmd("redrawstatus")
	end)
end

function M.start_work(custom_duration)
	M.stop_timer()
	M.total_duration = custom_duration or config.options.work_duration
	M.time_remaining = M.total_duration
	M.current_state = M.STATE.WORKING

	local uv = vim.uv or vim.loop
	uv_timer = uv.new_timer()
	uv_timer:start(1000, 1000, vim.schedule_wrap(tick))

	notify("Slice started for " .. math.floor(M.total_duration / 60) .. " min. Nice session!")
end

function M.extend(seconds)
	if M.current_state == M.STATE.STOPPED then
		M.start_work(seconds or config.options.extend_amount)
		return
	end
	local add_time = seconds or config.options.extend_amount
	M.time_remaining = M.time_remaining + add_time
	M.total_duration = M.total_duration + add_time
	notify("Slice extended by " .. math.floor(add_time / 60) .. " min")
end

function M.toggle_pause()
	if M.current_state == M.STATE.WORKING then
		M.current_state = M.STATE.PAUSED
		notify("Slice in break mode")
	elseif M.current_state == M.STATE.PAUSED then
		M.current_state = M.STATE.WORKING
		notify("Slice returned to work mode")
	end
	vim.cmd("redrawstatus")
end

function M.stop_timer()
	if uv_timer then
		uv_timer:stop()
		uv_timer:close()
		uv_timer = nil
	end
	M.current_state = M.STATE.STOPPED
	vim.cmd("redrawstatus")
end

function M.get_status()
	if M.current_state == M.STATE.STOPPED then
		return ""
	end

	local opts = config.options
	local ratio = M.time_remaining / M.total_duration
	local bar = ui.render_bar(ratio, opts.gauge_width, opts.icons.filled, opts.icons.empty)
	local time_str = ui.format_time(M.time_remaining)

	local icon = opts.icons.work
	if M.current_state == M.STATE.PAUSED then
		icon = opts.icons.paused
	elseif M.current_state == M.STATE.BREAK then
		icon = opts.icons.break_time
	end

	return string.format("%s %s [%s]", icon, time_str, bar)
end

return M
