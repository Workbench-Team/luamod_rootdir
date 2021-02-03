plugin.register("Mr0maks", "god", "0.0.1", "god mode for admin")

local bit = require("bit")
local privilege = require("privilege")
local edict = require("edict")
local band, bxor = bit.band, bit.bxor

cmd.register("client", "lm_god", function (E, argv, args)
	if privilege.get(E) == "admin" then
		local e = edict.to(E)
		e.v.flags = bxor(e.v.flags, 0x40);
		if band(e.v.flags, 0x40) == 0 then
			engine.client_printf(E, 1, '[invis] god disabled\n');
		else
			engine.client_printf(E, 1, '[invis] god enabled\n');
		end
	end
end)
