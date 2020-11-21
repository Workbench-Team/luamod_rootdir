--[[More easy get all we need from edict]]--
local function get_privilage(E)
	local name = get_entity_keyvalue(E, "name")
	for i,v in ipairs(users.users_table) do
		if users.users_table[i].name == name then return users.users_table[i].privilege end
	end
	return nil
end

return { get = get_privilage }