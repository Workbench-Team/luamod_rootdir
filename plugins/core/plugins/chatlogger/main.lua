plugin.register("Professor Brain", "Chat Logger", "no version", "Logging chat messages to file")

cmd.add("client", "say", function (E, table, args)
	local name = get_entity_keyvalue(E, "name")
	local id = engine.get_player_authid(E)
	local time = os.date("*t")
	log.write(os.date("chat_%Y_%m_%d.log"), string.format("[%02i:%02i:%02i] %s: %s\n %s\n", time.hour, time.min, time.sec, name, args, id))
	log.write(os.date("chat_%Y_%m_%d-onlymessages.log"), string.format("[%02i:%02i:%02i] %s: %s\n", time.hour, time.min, time.sec, name, args))
end)
