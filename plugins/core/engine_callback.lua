engine_callback = { callbacks = {} }

function engine_callback.register(engine_callback_name, callback)
  assert(callback ~= nil)
  if engine_callback.callbacks[engine_callback_name] == nil then engine_callback.callbacks[engine_callback_name] = {} end
  table.insert(engine_callback.callbacks[engine_callback_name], callback)
end

local function do_action(name, ...)
  if engine_callback.callbacks[name] == nil then return end

    for k,v in ipairs(engine_callback.callbacks[name]) do
      v(...)
    end
end

engine_events['pfnSpawn'] = function(...) do_action('pfnSpawn', ...) end
engine_events['pfnThink'] = function(...) do_action('pfnThink', ...) end
engine_events['pfnUse'] = function(...) do_action('pfnUse', ...) end
engine_events['pfnTouch'] = function(...) do_action('pfnTouch', ...) end
engine_events['pfnBlocked'] = function(...) do_action('pfnBlocked', ...) end
engine_events['pfnKeyValue'] = function(...) do_action('pfnKeyValue', ...) end

engine_events['pfnClientConnect'] = function(...) do_action('pfnClientConnect', ...) end
engine_events['pfnClientDisconnect'] = function(...) do_action('pfnClientDisconnect', ...) end
engine_events['pfnClientKill'] = function(...) do_action('pfnClientKill', ...) end
engine_events['pfnClientPutInServer'] = function(...) do_action('pfnClientPutInServer', ...) end
engine_events['pfnClientUserInfoChanged'] = function (...) do_action('pfnClientUserInfoChanged', ...) end
engine_events['pfnClientCommand'] = function(...) do_action('pfnClientCommand', ...) end

--[[
engine_events['pfnPlayerPreThink'] = function(E) end
engine_events['pfnPlayerPostThink'] = function(E) end
]]--

engine_events['pfnStartFrame'] = function(...) do_action('pfnStartFrame', ...) end
engine_events['pfnServerCommand'] = function (...) do_action('pfnServerCommand', ...) end
engine_events['pfnCvarValue2'] = function(...) do_action('pfnCvarValue2', ...) end
