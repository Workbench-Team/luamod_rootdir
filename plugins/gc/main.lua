plugin.register("Mr0maks", "gc", "0.0.1", "garbage collector")

local plugin_config = config.read("gc")
local garbage = {}

local log = logger.open("gc")

garbage.entities_list = plugin_config.entities
garbage.count_to_collect = plugin_config.count
garbage.collected = 0
-- seconds
garbage.time = plugin_config.time

function garbage.collect()
	local garbage_table = {}
	print("[GC] start marking for collect garbage")
	for v in pairs(garbage.entities_list) do
		for edict in pairs(engine.find_entities_by_string(nil, 'classname', v)) do
			log:debug("[GC] Found: "..v)
			table.insert(garbage_table, edict)
		end
	end

	if #garbage_table >= garbage.count_to_collect then
		for v in pairs(garbage_table) do
			engine.remove_entity(v)
		end
		print("Job well done.")
		print("Collected "..#garbage_table.." objects")
		garbage.collected = #garbage_table + garbage.collected
		print("Total collected "..garbage.collected.." objects")
	else
		print("Engineer is engihere.")
		print(""..#garbage_table.." garbage objects on map")
		print("Total collected "..garbage.collected.." objects")
	end
end

task.add(garbage.time, garbage.collect, -1)
