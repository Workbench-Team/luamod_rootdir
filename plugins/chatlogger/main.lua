register_plugin("Professor Brain", "Chat Logger", "no version", "Logging chat messages to file")

include 'cmd.lua'
include 'log.lua'

cmd.setClientCommand("say", function (E, table, args)
	local name = get_entity_keyvalue(E, "name")
	local id = get_player_authid(E)
	local time = os.date("*t")
	log.write(os.date("chat_%Y_%m_%d.log"), string.format("[%02i:%02i:%02i] ", time.hour, time.min, time.sec)..name..": "..args.."\n"..id.."\n")
	log.write(os.date("chat_%Y_%m_%d-onlymessages.log"), string.format("[%02i:%02i:%02i] ", time.hour, time.min, time.sec)..name..": "..args.."\n")
end)
