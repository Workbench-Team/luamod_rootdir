plugin.register("Mr0maks", "invis", "0.0.1", "invisible admin")

local privilege = require("privilege")
local edict = require("edict")

cmd.register("client", "lm_invis", function (E, argv, args)
	if privilege.get(E) == "admin" then
		local e = edict.to(E)
		if e.v.rendermode == 5 then
			engine.client_printf(E, 1, '[invis] invis disabled\n');
			e.v.rendermode = 0
			e.v.solid = 3
		else
			engine.client_printf(E, 1, '[invis] invis enabled\n');
			e.v.rendermode = 5
			e.v.solid = 0
		end
	end
end)
