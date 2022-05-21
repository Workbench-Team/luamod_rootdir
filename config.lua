config = {}

local JSON = require("JSON")

function config.read(filename)
	local config_handle = io.open(string.format("%s/%s.json", CONFIGS_PATH, filename), "r")
	local json = JSON:decode(config_handle:read("*a"))
	config_handle:close()
	return json
end
