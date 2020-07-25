register_plugin("Professor Brain", "Player Connecting", "no version", "Log when player connects in chat and console")

engine_events['pfnClientConnect'] = function (E, name, address)
	--local msg = string.format("Player", name, "connecting to server now!");
	--local msg = "Player "..get_entity_keyvalue(E, "name").." connecting to server now"
	
	local say_text = reg_user_msg("SayText", -1)
	message_begin(2, say_text, {0, 0, 0}, 0)
	write_byte(index_of_edict(E))
	write_string('Player '..get_entity_keyvalue(E, "name")..' connecting to server now!\n')
	message_end()
	print('Player '..get_entity_keyvalue(E, "name")..' connecting to server now!\n')

end
