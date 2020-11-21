plugin.register("Mr0maks", "antiold", "no version", "kick 0.19.1 and older xash3d version")

local log = require("log").open("antiold")

engine_callback.register("pfnCvarValue2", function (E, id, cvar_name, cvar_value)
	if cvar_name == 'host_build' and cvar_value < 1200 then
		log:write('Authid: %s Cvar Value %s\n', engine.get_player_authid(E), cvar_value);
		engine.server_command('kick #'..tostring(engine.get_player_userid(E))..' "Only with Xash3D FWGS 0.19.2 version"')
	end
end)

engine_callback.register("pfnClientConnect", function (E, name, address)
engine.query_client_cvar_value2(E, 'host_build', 1);
end)
