users = { auth = {}, users_list = {}, user = {} }

local JSON = require("JSON")

file_config = io.open(CORE_PATH.."/users.json", "r")
users.users_json = JSON:decode(file_config:read("*a")).users
file_config:close()

local authentication_failed_msg = "Authentication failed!"

function users.auth_need(E)
	local name = get_entity_keyvalue(E, "name")
	for i = 1, #users.users_json do
		if users.users_json[i].name == name then return true end
	end
	return false
end

local function try_authentication(E)
	local name = get_entity_keyvalue(E, "name")
	for i = 1, #users.users_json do
		if users.users_json[i].name == name then

			--[[ 0.0.0.0 - 255.255.255.255 ]]--
			if users.users_json[i].ip ~= nil then
				local ip = ""

				for i = 1, #users.users_list do
					if users.users_list[i].name == name then
						ip = users.users_list[i].ip
					end
				end

				if users.users_json[i].ip ~= ip then
					engine.server_command(string.format('kick #%i "%s"', engine.get_player_userid(E), authentication_failed_msg))
					return nil
				end
			end

			 --[[ setinfo _pw "password" ]]--
			if users.users_json[i].password ~= nil then
				local password = get_entity_keyvalue(E, "_pw")
				if users.users_json[i].password ~= password then
					engine.server_command(string.format('kick #%i "%s"', engine.get_player_userid(E), authentication_failed_msg))
					return nil
				end
			end

			--[[For example VALVE_XASH_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx for xash3d]]--
			if users.users_json[i].id ~= nil then
				local id = get_player_authid(E)
				if users.users_json[i].id ~= id then
					engine.server_command(string.format('kick #%i "%s"', engine.get_player_userid(E), authentication_failed_msg))
					return nil
				end
			end

			return users.users_json[i].privilege
		end
	end
	return nil
end

local inspect = require("inspect")

function users.user.push(E)
	users.user.delete(E)
	local ip = get_entity_keyvalue(E, "ip"):match("(%d+.%d+.%d+.%d+)")

	table.insert(users.users_list, {edict = E, name = get_entity_keyvalue(E, "name"), authid = engine.get_player_authid(E), ip = ip, on_server = false, auth = false})
	print(inspect(users.users_list))
end

function users.user.delete(E)
	local name = get_entity_keyvalue(E, "name")
	for i = 1, #users.users_list do
		if users.users_list[i].name == name then
			table.remove(users.users_list, i)
		end
	end
	print(inspect(users.users_list))
end

function users.user.on_server(E)
	local name = get_entity_keyvalue(E, "name")
	if users.auth_need(E) == true then
		local privilege = try_authentication(E)
		-- player kicked from server
		if privilege == nil then return end

		for i = 1, #users.users_list do
			if users.users_list[i].name == name then
				users.users_list[i].privilege = privilege
				users.users_list[i].auth = true
				return
			end
		end
	end

	for i = 1, #users.users_list do
		if users.users_list[i].name == name then users.users_list[i].on_server = true end
	end
	print(inspect(users.users_list))
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