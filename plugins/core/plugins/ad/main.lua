plugin.register("Mr0maks", "Lumod Ad", "0.0.1", "Simple plugin to show luamod ad on server")

local gmsgHudText = engine.reg_user_msg("HudText", -1);

local function advert_task()
	engine.message_begin(0, gmsgHudText, nil, nil)
	engine.write_string(string.format("This server is using LuaMod version %s", LUAMOD_VERSION))
	engine.message_end()
end

task.add(30, advert_task, task.infinite)
