local plugin_id = { author = "Mr0maks", name = "Core", version = "0.0.1", description = "First step to make good scripting addon for metamod" }

print(string.format("[LuaMod] CORE by Mr0maks ver %s starting on luamod version %s", plugin_id.version, LUAMOD_VERSION))

CORE_PATH = string.format("%s/addons/luamod/plugins/core", MOD_PATH)
PACKAGE_PATH = string.format("%s/package", CORE_PATH)
PLUGINS_PATH = string.format("%s/plugins", CORE_PATH)
LOGS_PATH = string.format("%s/logs", CORE_PATH)

package.path = string.format("%s/?.lua;%s/?/init.lua;", PACKAGE_PATH, PACKAGE_PATH)

dofile(CORE_PATH.."/log.lua")
dofile(INCLUDE_PATH.."/edict.lua")
dofile(CORE_PATH.."/engine_callback.lua")
dofile(CORE_PATH.."/users.lua")
dofile(CORE_PATH.."/cmd.lua")
dofile(CORE_PATH.."/plugin.lua")

plugin.register(plugin_id.author, plugin_id.name, plugin_id.version, plugin_id.description)

local JSON = require("JSON")

file_config = io.open(CORE_PATH.."/config.json", "r")
config = JSON:decode(file_config:read("*a"))
file_config:close()

local inspect = require("inspect")

for i = 1,#config.plugins do
	local func, err = loadfile(PLUGINS_PATH.."/"..config.plugins[i].."/main.lua")
	if func == nil then print(string.format("[LuaMod] CORE: Plugin %s Failed to load with error %s", config.plugins[i], err)) end
	local ok, result = pcall(func)
	if ok == false then print(string.format("[LuaMod] CORE: Plugin %s Failed to load with error %s", config.plugins[i], result)) end
end

register_plugin(plugin_id.author, plugin_id.name, plugin_id.version, plugin_id.description)
