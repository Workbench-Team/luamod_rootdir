local globalvars = require("global_vars")

local tasks = {}

local last_task_id = 0

task = {}

local time_old = 0
local global_time = 0

function task.pause( seconds )
	local time = global_time + seconds

	while(true) do
		if(time < global_time) then return end
		coroutine.yield()
	end
end

function task.remove(id)
	for i,v in ipairs(tasks) do
		if id == tasks[i].id then
			table.remove(tasks, i)
			return
		end
	end
end

local function task_callback(time, cb)
	task.pause(time)
	pcall(cb)
end

engine_callback.register("pfnStartFrame", function()
	local diff = globalvars.time - time_old
	time_old = globalvars.time
	if diff > 0 then global_time = global_time + diff else return end
	--[[print(string.format("Time now: %f\nTime diff = %f", globalvars.time, diff)) ]] --

	local tasks_remove = {}

	for i,v in ipairs(tasks) do
		if tasks[i].repeat_count ~= 0 then
			-- Resume coroutine after suspend --
			if tasks[i].coroutine ~= nil then
				if coroutine.status(tasks[i].coroutine) == "suspended" then
					coroutine.resume(tasks[i].coroutine)
				else
					-- Coroutine is dead. Not big surprise. --
					tasks[i].coroutine = coroutine.create(task_callback)
					coroutine.resume(tasks[i].coroutine, tasks[i].time, tasks[i].cb)
					if tasks[i].repeat_count ~= -1 then
						tasks[i].repeat_count = tasks[i].repeat_count - 1
					end
				end
			else
				-- Coroutine not created. Not big surprise. --
				tasks[i].coroutine = coroutine.create(task_callback)
				coroutine.resume(tasks[i].coroutine, tasks[i].time, tasks[i].cb)
				if tasks[i].repeat_count ~= -1 then
					tasks[i].repeat_count = tasks[i].repeat_count - 1
				end
			end

		else
			-- mark object to remove --
			table.insert(tasks_remove, tasks[i].id)
		end
	end

	-- collect garbage --
	for i,v in ipairs(tasks) do
		task.remove(tasks_remove[i])
	end
end)

--[[ pass -1 to repeat_count to task.add for infinite execution (if repeat == 0 task automaticaly removed)]]--

task.infinite = -1

function task.add(time, callback, repeat_count)
	last_task_id = last_task_id + 1
	local id = last_task_id

	-- FIXME: add 1 to avoid strange bug --
	if repeat_count ~= -1 then repeat_count = repeat_count + 1 end
	table.insert(tasks, {id = id, time = time, cb = callback, repeat_count = repeat_count})
	return id
end