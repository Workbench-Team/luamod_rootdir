log = { debug_level = 0 }

function log.write(filename, str)
	local file = io.open(string.format("%s/%s", LOGS_PATH, filename), "a+")
	file:write(str)
	file:close()
end