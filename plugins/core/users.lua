users = { auth = {}, users_list = {}, user = {} }

local JSON = require("JSON")

file_config = io.open(CORE_PATH.."/users.json", "r")
users.users_json = JSON:decode(file_config:read("*a"))
file_config:close()

function users.auth_need(E)
	local name = get_entity_keyvalue(E, "name")
	for i = 1, #users.users_list do
		if users.users_list[i].name == name then table.remove(users.users_list, i) print(inspect(users.users_list)) return end
	end
end

local inspect = require("inspect")

function users.user.push(E)
	users.user.delete(E)
	table.insert(users.users_list, {edict = E, name = get_entity_keyvalue(E, "name"), authid = get_player_authid(E), ip = get_entity_keyvalue(E, "ip"), on_server = false, auth = false})
	print(inspect(users.users_list))
end

function users.user.delete(E)
	local name = get_entity_keyvalue(E, "name")
	for i = 1, #users.users_list do
		if users.users_list[i].name == name then table.remove(users.users_list, i) print(inspect(users.users_list)) return end
	end
end

function users.user.on_server(E)
	local name = get_entity_keyvalue(E, "name")
	for i = 1, #users.users_list do
		if users.users_list[i].name == name then users.users_list[i].on_server = true print(inspect(users.users_list)) return end
	end
end

function users.auth(E, player_name)
	if #users.users_json.users == 0 then return end
	for i = 1, #users.users_json.users do
		if users.users_json.users[i].name == player_name then return true end
	end
	return false
end

function users.add(player_name, auth_type, auth_data)

end

function users.remove(player_name)

end


engine_callback.register('pfnClientConnect', users.user.push)
engine_callback.register('pfnClientDisconnect', users.user.delete)
engine_callback.register('pfnClientPutInServer', users.user.on_server)