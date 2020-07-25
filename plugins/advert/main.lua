register_plugin("Mr0maks", "Advert Message", "0.0.1", "Be carefully (may be crache your server!)")

local tskid = set_task("luamod_hudmsg", -1, 10, "luamod_advert");

local ad_msg = 'This server is using LuaMod ' ..luamod_version();

local gmsgHudText = reg_user_msg("HudText", -1)

function luamod_advert()
	message_begin(0, gmsgHudText, {0, 0, 0}, 0)
	write_string(ad_msg)
	message_end()
end

