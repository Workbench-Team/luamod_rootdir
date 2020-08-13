plugin.register("Mr0maks", "chat", "0.0.1", "Alternative for standart chat")

if MOD_PATH == "cstrike" then
	error("plugin not working with CS 1.6")
end

local say_text = reg_user_msg("SayText", -1);

cmd.register("client", "say", function (executor, args, split_args)
	local name = get_entity_keyvalue(executor, 'name');
	local string_msg = string.format("%c[%s] %s: %s\n", 2, os.date("%X"), name, string.gsub(split_args, '"', ''));

	if MOD_PATH ~= "cstrike" then
		message_begin(2, say_text, { 0, 0, 0 }, 0)
		write_byte(index_of_edict(executor));
		write_string(string_msg);
		message_end();
	end

	print(string_msg)
end);