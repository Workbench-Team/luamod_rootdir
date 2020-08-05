plugin.register("Mr0maks", "Lumod Ad", "0.0.1", "Simple plugin to show luamod ad on server")

local gmsgHudText = reg_user_msg("HudText", -1);

local function advert_task()
	message_begin(0, gmsgHudText, {0,0,0}, nil)
	write_string(string.format("This server is using LuaMod version %s", LUAMOD_VERSION))
	message_end()
end

task.add(30, advert_task, task.infinite)
