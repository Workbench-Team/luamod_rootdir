--[[More easy get all we need from edict]]--
local function get_privilage(E)
	local name = get_entity_keyvalue(E, "name")
	for i = 1, #users.users_list do
		if users.users_list[i].name == name then return users.users_list[i].privilege end
	end
end

return { get = get_privilage }