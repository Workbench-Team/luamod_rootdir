local plugin_id = { author = "Professor Brain", name = "Player Connecting", version = "no version", description = "Log when player connects in chat and console" }

local say_text = reg_user_msg("SayText", -1)

engine_callback.register('pfnClientConnect', function (E, name, address)
	local name = get_entity_keyvalue(E, "name")
	message_begin(2, say_text, {0, 0, 0}, 0)
	write_byte(index_of_edict(E))
	write_string(string.format('Player "%s" connecting to server now!\n', name))
	message_end()
	print(string.format('Player "%s" connecting to server now!', name))
end)

return plugin_id
