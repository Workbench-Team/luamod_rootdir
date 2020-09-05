plugin.register("Mr0maks", "chat", "0.0.1", "Alternative for standart chat")

if MOD_PATH == "cstrike" then
	error("plugin not working with CS 1.6")
end

local globalvars = require("global_vars")
local meta_global = require("metamod")

--Original value from hlsdk
local chat_interval = 1.0
local say_text = engine.reg_user_msg("SayText", -1);

local player_next_chat_message = {}

cmd.register("client", "say", function (executor, args, split_args)
	--[[Hook original Host_Say]]--
	meta_global.mres = metamod.MRES_SUPERCEDE

	--[[ ignore string with zero len ]]--
	if #args == 1 then return end

	local name = get_entity_keyvalue(executor, 'name');

	if player_next_chat_message[name] > globalvars.time then
		return
	end

	player_next_chat_message[name] = globalvars.time + chat_interval

	local string_msg = string.format("%c[%s] %s: %s\n", 2, os.date("%X"), name, string.gsub(split_args, '"', ''));

	if MOD_PATH ~= "cstrike" then
		engine.message_begin(2, say_text, { 0, 0, 0 }, 0)
		engine.write_byte(engine.index_of_edict(executor));
		engine.write_string(string_msg);
		engine.message_end();
	end

	print(string_msg)
end)

cmd.register("client", "say_team", function (executor, args, split_args)
	--[[Hook original Host_Say]]--
	meta_global.mres = metamod.MRES_SUPERCEDE
end

engine_callback.register('pfnClientPutInServer', function (E)
	local name = get_entity_keyvalue(E, 'name');
	player_next_chat_message[name] = 0
end)

engine_callback.register('pfnClientDisconnect', function (E)
	local name = get_entity_keyvalue(E, 'name');
	player_next_chat_message[name] = nil
end)
