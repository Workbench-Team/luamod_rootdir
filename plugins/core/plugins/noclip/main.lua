plugin.register("Mr0maks", "noclip", "0.0.1", "noclip for admin")

local privilege = require("privilege")
local edict = require("edict")

cmd.add("client", "lm_noclip", function (E, argv, args)
	if privilege.get(E) == "admin" then
		local e = edict.to(E)
		if e.v.movetype == 8 then
			engine.client_printf(E, 1, '[noclip] noclip disabled\n');
			e.v.movetype = 0
		else
			engine.client_printf(E, 1, '[noclip] noclip enabled\n');
			e.v.movetype = 8
		end
	end
end)