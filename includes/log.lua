local function write(filename, string)
	local file = io.open(string.format("%s/addons/luamod/logs/%s", MOD_PATH, filename), "a+")
	file:write(string)
	file:close()
end

log = {write = write}
