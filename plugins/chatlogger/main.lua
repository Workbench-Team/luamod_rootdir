plugin.register("Professor Brain", "Chat Logger", "no version", "Logging chat messages to file")

local log = log.open("chat")

cmd.register("client", "say", function (E, table, args)
	local name = get_entity_keyvalue(E, "name")
	local id = engine.get_player_authid(E)
	log:write("%s %s: %s", id, name, args)
end)
