cmd = { client_commands = { }, server_commands = { }, chat_commands = { } };

function cmd.setClientCommand(command, handler) cmd.client_commands[command] = { command, handler } end
function cmd.setServerCommand(command, handler) cmd.server_commands[command] = { command, handler } end
function cmd.setChatCommand  (command, handler) cmd.chat_commands  [command] = { command, handler } end

engine_events['pfnClientCommand'] = function (E, args, text)
    if cmd.client_commands[args[1]] then return cmd.client_commands[args[1]][2](E, args, text) end
    if args[2] then
        local chat_args = string.split(args[2], ' ');
        if cmd.chat_commands[chat_args[1]] then return cmd.chat_commands[chat_args[1]][2](E, chat_args, text) end
    end
end

engine_events['pfnServerCommand'] = function (E, args, text)
    return cmd.server_commands[args[1]] and cmd.server_commands[args[1]][2](E, args, text);
end
