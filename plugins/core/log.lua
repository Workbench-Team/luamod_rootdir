log = {}

function log.write(filename, string)
	local file = io.open(string.format("%s/%s", LOGS_PATH, filename), "a+")
	file:write(string)
	file:close()
end
