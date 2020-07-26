plugin.register("Mr0maks", "helloworld", "no version", "helloworld plugin")

local inspect = require("inspect")

cmd.setChatCommand("hello", function (E)
	print("Hello World luamod!")
end)