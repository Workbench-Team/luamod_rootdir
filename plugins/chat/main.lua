plugin.register("Mr0maks", "chat", "0.0.1", "Alternative for standart chat")

if MOD_PATH == "cstrike" then
	error("plugin not working with CS 1.6")
end

local globalvars = require("global_vars")
local meta_global = require("metamod")
local log = log.open("chat")

local say_text = engine.reg_user_msg("SayText", -1);

local chat_player_ratelimit = {}
local chat_sliding_window_capacity = 10 -- 30 messages
local chat_sliding_window_time_unit = 1 -- 1 sec

cmd.register("client", "say", function (executor, args, split_args)
	--[[Hook original Host_Say]]--
	meta_global.mres = metamod.MRES_SUPERCEDE

	--[[ ignore string with zero len ]]--
	if #args == 1 then return end

	local name = get_entity_keyvalue(executor, 'name');
	local id = engine.get_player_authid(executor);

	if globalvars.time - chat_player_ratelimit[name].time > chat_sliding_window_time_unit then
		chat_player_ratelimit[name].time = globalvars.time
		chat_player_ratelimit[name].previous_count = chat_player_ratelimit[name].current_count
		chat_player_ratelimit[name].current_count = 0
	end

	local ec = (chat_player_ratelimit[name].previous_count * (chat_sliding_window_time_unit - (globalvars.time - chat_player_ratelimit[name].time)) / chat_sliding_window_time_unit) + chat_player_ratelimit[name].current_count

	if ec > chat_sliding_window_capacity then
		return
	end

	local string_msg = string.format("%c[%s] %s: %s\n", 2, os.date("%X"), name, string.gsub(split_args, '"', ''));

	engine.message_begin(2, say_text, nil, nil)
	engine.write_byte(engine.index_of_edict(executor));
	engine.write_string(string_msg);
	engine.message_end();

	log:write("%s %s: %s", id, name, split_args)
	print(string_msg)
end)

cmd.register("client", "say_team", function (executor, args, split_args)
	--[[Hook original Host_Say]]--
	meta_global.mres = metamod.MRES_SUPERCEDE
end)

engine_callback.register('pfnClientPutInServer', function (E)
	local name = get_entity_keyvalue(E, 'name');
	chat_player_ratelimit[name] = { time = globalvars.time, previous_count = 0, current_count = 0 }
end)

engine_callback.register('pfnClientDisconnect', function (E)
	local name = get_entity_keyvalue(E, 'name');
	chat_player_ratelimit[name] = nil
end)
