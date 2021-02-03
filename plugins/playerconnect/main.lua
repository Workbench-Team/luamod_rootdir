plugin.register("Professor Brain", "Player Connecting", "no version", "Log when player connects in chat and console")

local say_text = engine.reg_user_msg("SayText", -1)

engine_callback.register('pfnClientConnect', function (E, name, address)
	local name = get_entity_keyvalue(E, "name")
	engine.message_begin(2, say_text, {0, 0, 0}, 0)
	engine.write_byte(engine.index_of_edict(E))
	engine.write_string(string.format('Player "%s" connecting to server now!\n', name))
	engine.message_end()
	print(string.format('Player "%s" connecting to server now!', name))
end)
