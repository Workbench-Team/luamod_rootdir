cmd = { client_commands = { }, server_commands = { }, chat_commands = { }  };

function cmd.register(type, command, handler)
    if type ~= "client" or type ~= "server" or ~= "chat" then error("invalid type") return end
    cmd[type.."_commands"][command] = {command, handler}
end

function string.split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

engine_callback.register('pfnClientCommand', function (E, args, text)
    if cmd.client_commands[args[1]] then cmd.client_commands[args[1]][2](E, args, text) end
    if args[1] == "say" then
        local chat_args = string.split(args[2], ' ');
        if cmd.chat_commands[chat_args[1]] then return cmd.chat_commands[chat_args[1]][2](E, chat_args, text) end
    end
end)

engine_callback.register('pfnServerCommand', function (E, args, text)
    return cmd.server_commands[args[1]] and cmd.server_commands[args[1]][2](E, args, text);
end)
