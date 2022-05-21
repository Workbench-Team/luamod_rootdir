plugin.register("Aru Moon", "Players connection logs", "no version", "Players connection logs")

local say_text = engine.reg_user_msg("SayText", -1)
local log = log.open("players")

engine_callback.register('pfnClientDisconnect', function (E)
	engine.server_print(string.format('^6Player ^7%s^6 left the server\n', get_entity_keyvalue(E, "name")))
	log:write("Player left the server - %s %s %s", get_entity_keyvalue(E, "name"), engine.get_player_authid(E), get_entity_keyvalue(E, "ip"))
end)

engine_callback.register('pfnClientPutInServer', function (E)
	engine.server_print(string.format('^6Player ^7%s^6 put in the server\n', get_entity_keyvalue(E, "name")))
	log:write("Player put in the server - %s %s %s", get_entity_keyvalue(E, "name"), engine.get_player_authid(E), get_entity_keyvalue(E, "ip"))
end)

engine_callback.register('pfnClientConnect', function(E)
	engine.message_begin(2, say_text, {0, 0, 0}, 0)
	engine.write_byte(engine.index_of_edict(E))
	engine.write_string(string.format('Player %s^7 connecting to the server\n', get_entity_keyvalue(E, "name")))
	engine.message_end()
	engine.server_print(string.format('^6Player ^7%s^6 connecting to the server\n', get_entity_keyvalue(E, "name")))
	log:write("Player connecting to the server - %s %s %s", get_entity_keyvalue(E, "name"), engine.get_player_authid(E), get_entity_keyvalue(E, "ip"))
end)

local function check_status()
	engine.server_command("status")
end

task.add(300, check_status, task.infinite)
