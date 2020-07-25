plugin.register("Mr0maks", "luamod", "no version", "test plugin")

local inspect = require("inspect")

cmd.setChatCommand("lm", function (E)
	print(inspect(users.users_list))
end)