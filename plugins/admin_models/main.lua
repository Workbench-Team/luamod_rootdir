register_plugin("Mr0maks", "Admins Skins", "0.0.1", "Simple plugin to reserve models for admins")

admins_skins = { [ 'gcatman' ] = true, [ 'hevgirl' ] = true }

admins = { [ 'VALVE_XASH_be41f8420c695a8dc6ea18efad88a8d6' ] = true , [ 'VALVE_XASH_5f97bef6940d1536347b7b48e2d27222' ] = true } -- hardcoded beacause auth not created !
-- Sec
--TODO : return skin randomly

function player_have_access(E)
if admins[get_player_authid(E)] == true then return true end
return false
end

function get_skin()
return 'helmet'
end

function change_skin_if_need(E)

local model = get_entity_keyvalue(E, 'model');

print(get_entity_keyvalue(E, "name")..' : Player model : '..model..' \n'); -- debug

if admins_skins[model] == true then
if player_have_access(E) == false then
set_client_key_value(index_of_edict(E), get_info_key_buffer(E), 'model', get_skin())
end
end

end

engine_events['pfnClientUserInfoChanged'] = function (E, string)
change_skin_if_need(E)
end

engine_events['pfnClientPutInServer'] = function (E)
change_skin_if_need(E)
end
