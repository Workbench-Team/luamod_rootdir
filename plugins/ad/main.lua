plugin.register("Mr0maks & Aru Moon", "Lumod Ad", "0.1.1", "Simple advertisment and info")

local gmsgHudText = engine.reg_user_msg("HudText", -1);
local say_text = engine.reg_user_msg("SayText", -1)

local function advert_task()
	engine.message_begin(0, gmsgHudText, nil, nil)
	engine.write_string("Support server's owner: patreon.com/arumoon")
	engine.message_end()
end

local function reporthelp_task()
	engine.message_begin(2, say_text, {0,0,0}, 0)
	engine.write_byte(0)
	engine.write_string("Found unbanned cheater? Report at this email admin@arumoon.ru\n")
	engine.message_end()
end

task.add(60, advert_task, task.infinite)
task.add(90, reporthelp_task, task.infinite)
