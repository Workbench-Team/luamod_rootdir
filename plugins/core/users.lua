users = { users_table = {}, user = {} }

local JSON = require("JSON")
local inspect = require("inspect")

local users_config = {}

local file_config = io.open(CORE_PATH.."/users.json", "r")
users_config.config = JSON:decode(file_config:read("*a")).users
file_config:close()

local authentication_failed_msg = "Authentication failed!"

function users_config.find(name)
	for i,v in ipairs(users_config.config) do
		if v.name == name then return v end
	end
	return nil
end

function users.find_by_name(name)
	for i,v in ipairs(users.users_table) do
		if v.name == name then return v end
	end
end

function users.find_by_edict(E)
	local name = get_entity_keyvalue(E, "name")
	for i,v in ipairs(users.users_table) do
		if v.name == name then return v end
	end
end

local auth = { methods = {} }

function auth.methods.none( user, config )
	return true
end

function auth.methods.ip( user, config )
	return user.ip == config.ip
end

function auth.methods.password( user, config )
	local password = get_entity_keyvalue(user.edict, "_pw")
	return password == config.password
end

function auth.methods.authid( user, config )
	return user.authid == config.authid
end

function auth.user(user, config)
	local method = auth.methods[config.method]
	if method ~= nil then return method(user,config) end
	return false
end

function users.add(player_name, auth_method, auth_data)
end

function users.remove(player_name)
end

engine_callback.register('pfnClientConnect', function (E)
	local ip = get_entity_keyvalue(E, "ip"):match("(%d+.%d+.%d+.%d+)")

	table.insert(users.users_table,
		{
			edict = E,
			name = get_entity_keyvalue(E, "name"),
			authid = engine.get_player_authid(E),
			ip = ip,
			on_server = false,
			auth = false
		}
		)
	print(inspect(users.users_table))
end)

engine_callback.register('pfnClientDisconnect', function (E)
	local name = get_entity_keyvalue(E, "name")
	for i,v in ipairs(users.users_table) do
		if users.users_table[i].name == name then
			table.remove(users.users_table, i)
		end
	end
	print(inspect(users.users_table))
end)

engine_callback.register('pfnClientPutInServer', function (E)
	local name = get_entity_keyvalue(E, "name")
	local config = users_config.find(name)

	if config ~= nil then
		local auth_user = users.find_by_name(name)
		local authentication_success = auth.user(auth_user, config)

		if authentication_success ~= true then
			engine.server_command(string.format('kick #%i "%s"', engine.get_player_userid(E), authentication_failed_msg))
			return
		end

		for i,v in ipairs(users.users_table) do
			if users.users_table[i].name == name then
				users.users_table[i].privilege = config.privilege
				users.users_table[i].auth = true
			end
		end
	end

	for i,v in ipairs(users.users_table) do
		if users.users_table[i].name == name then users.users_table[i].on_server = true end
	end
	print(inspect(users.users_table))
end)
