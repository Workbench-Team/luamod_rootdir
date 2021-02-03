plugin.register("Aru Moon", "RCON", "no version", "RCON")

local privilege = require("privilege")
local edict = require("edict")

cmd.register("client", "lm_rcon", function (E, argv, args)
	if privilege.get(E) == "admin" then
		engine.server_print(string.format("^7RCON from %s^7: %s\n", get_entity_keyvalue(E, "name"), args))
		engine.server_command(args)
	else
		engine.server_print(string.format("^7Bad RCON from %s^7 (%s privilege): %s\n", get_entity_keyvalue(E, "name"), privilege.get(E), args))
	end
end)
