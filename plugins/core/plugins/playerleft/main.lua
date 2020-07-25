register_plugin("Professor Brain", "Player left log", "no version", "Print in console when player left the server")

engine_events['pfnClientDisconnect'] = function (E)
	print("Player "..get_entity_keyvalue(E, "name").." left the server!\n")
end
