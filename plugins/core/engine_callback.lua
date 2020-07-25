engine_callback = { callbacks = {} }

function engine_callback.register(engine_callback_name, callback)
  assert(callback ~= nil)
  if engine_callback.callbacks[engine_callback_name] == nil then engine_callback.callbacks[engine_callback_name] = {} end
  table.insert(engine_callback.callbacks[engine_callback_name], callback)
end

engine_events['pfnClientConnect'] = function(E, name, addr)
  if engine_callback.callbacks['pfnClientConnect'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnClientConnect'] do
    pcall(engine_callback.callbacks['pfnClientConnect'][i], E, name, addr)
  end
end

engine_events['pfnClientDisconnect'] = function(E)
  if engine_callback.callbacks['pfnClientDisconnect'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnClientDisconnect'] do
    pcall(engine_callback.callbacks['pfnClientDisconnect'][i], E)
  end
end

engine_events['pfnClientKill'] = function(E)
  -- body
end

engine_events['pfnClientPutInServer'] = function(E)
  if engine_callback.callbacks['pfnClientPutInServer'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnClientPutInServer'] do
    pcall(engine_callback.callbacks['pfnClientPutInServer'][i], E)
  end
end

engine_events['pfnClientUserInfoChanged'] = function (E, buffer)
  -- body
end

engine_events['pfnClientCommand'] = function(E, args, text)
  print(args[1])
  if engine_callback.callbacks['pfnClientCommand'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnClientCommand'] do
    pcall(engine_callback.callbacks['pfnClientCommand'][i], E, args)
  end
end
--[[
engine_events['pfnPlayerPreThink'] = function(E)
  -- body
end

engine_events['pfnPlayerPostThink'] = function(E)
  -- body
end
]]--
engine_events['pfnStartFrame'] = function()
  -- body
end

engine_events['pfnServerCommand'] = function (command)
  -- body
  print("Server cmd: "..command)
end

engine_events['pfnCvarValue2'] = function(E, req, name, value)
  -- body
end