-- LUAJIT
include 'log.lua'

register_plugin("Mr0maks", "ANTIOLD", "0.0.1", "no 0.19.1 xash3d and older")

engine_events['pfnCvarValue2'] = function (E, id, cvar_name, cvar_value)
if cvar_name == 'host_build' then
if cvar_value < "1200" then log.write(os.date('anti_old_xash_bad_players_%Y_%m_%d.log'), 'Authid '..get_player_authid(E)..' Cvar Value '..cvar_value..'\n'); server_command('kick #'..tostring(get_player_userid(E))..' "Only with Xash3D FWGS 0.19.2 version"') end
end
end

engine_events['pfnClientConnect'] = function (E, name, address)
query_client_cvar_value2(E, 'host_build', 133712345);
end

