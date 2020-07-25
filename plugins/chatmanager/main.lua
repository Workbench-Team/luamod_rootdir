register_plugin("Mr0maks", "ChatManager", "0.0.1-beta", "Best Chat Manager Writed in LuaMod !!!!11")

include 'cmd.lua'
include 'edict.lua'
include 'killed.lua'
include 'admin.lua'
include 'admins.lua'

local tskid = set_task("luamod_hudmsg", -1, 10, "luamod_advert");

function luamod_advert()
	hud_message_all('This server is using LuaMod ' ..luamod_version());
end

banned_words = { 
	--['"testword"'] = true, 
	--['"testword2"'] = true
	['"пидор"'] = true,
	['"лох"'] = true,
	['"урод"'] = true
}

muted_players_nics = {
	--["^1[Eclipse]Mr0maks"] = true
}

cmd.setClientCommand("say", function (executor, args, split_args)

	--local entvars = get_offset_data(E, 0x80);
	--local netname_string = get_offset_int(entvars, 0x250);

	local netname = get_entity_keyvalue(executor, 'name');

	if muted_players_nics[netname] == true then
		return
	end

	local count_banned_words = 0;

	for word in string.gmatch(split_args, "%S+") do
		print(word);
		if banned_words[word] == true then 
			print('WORD '..word..' BANNED!!!');
			count_banned_words = count_banned_words + 1;
		end
	end

	if count_banned_words > 1 then 

		local banned_words_log = string.format("BANNED WORDS FAILED [%s] %s: %s\n", 2, os.date("%X"), netname, string.gsub(split_args, '"', ''));
		write_log('chat_banned.log', banned_words_log);
		return
	end

	local string_msg = string.format("%c[%s] %s: %s\n", 2, os.date("%X"), netname, string.gsub(split_args, '"', ''));

	write_log('chat.log', string_msg);

	say_text = reg_user_msg("SayText", -1);

--	message_begin(0, say_text, { 0, 0, 0 }, 0)
	message_begin(2, say_text, { 0, 0, 0 }, 0)
	write_byte(index_of_edict(executor));
--	write_string("#Cstrike_Chat_All");
--	write_string("");
	write_string(string_msg);
	message_end();

	print(string_msg)

end);

cmd.setClientCommand("lm_rcon", function (executor, args, split_args)
print(split_args)
local admin_chk = admin_check(executor) 
    if admin_chk == 1 then client_printf(executor, 1 ,'Admin check for you OK!\n'); server_command(split_args); server_execute(); else client_printf(executor, 1 ,'Admin check for you FAILED!\n'); end
end);

engine_events['pfnClientKill'] = function (E)
end

engine_events['pfnCvarValue2'] = function (E, id, cvar_name, cvar_value)
write_log('cvar_users.log', 'Authid '..get_authid_by_edict(E)..' Id '..id..' Cvar Name '..cvar_name..' Cvar Value '..cvar_value..'\n')
end

engine_events['pfnClientConnect'] = function (E, name, address)
get_cvar2(E, 'm_ignore', 1);
write_log('users.log', 'Nick: '..name..' Address: '..address..' Authid: '..get_authid_by_edict(E)..' setinfo _pw : '..get_entity_keyvalue(E, '_pw')..'\n');
end

cmd.setClientCommand('luamod', function (executor, args)
	client_printf(executor, 1 ,'LUAMOD '..luamod_version()..' by Mr0maks\n');
end);

