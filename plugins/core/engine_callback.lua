engine_callback = { callbacks = {} }

function engine_callback.register(engine_callback_name, callback)
  assert(callback ~= nil)
  if engine_callback.callbacks[engine_callback_name] == nil then engine_callback.callbacks[engine_callback_name] = {} end
  table.insert(engine_callback.callbacks[engine_callback_name], callback)
end

engine_events['pfnSpawn'] = function(E)
  if engine_callback.callbacks['pfnSpawn'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnSpawn'] do
    pcall(engine_callback.callbacks['pfnSpawn'][i], E)
  end
end

engine_events['pfnThink'] = function(E)
  if engine_callback.callbacks['pfnThink'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnThink'] do
    pcall(engine_callback.callbacks['pfnThink'][i], E)
  end
end

engine_events['pfnUse'] = function(E, E2)
  if engine_callback.callbacks['pfnUse'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnUse'] do
    pcall(engine_callback.callbacks['pfnUse'][i], E, E2)
  end
end

engine_events['pfnTouch'] = function(E, E2)
  if engine_callback.callbacks['pfnTouch'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnTouch'] do
    pcall(engine_callback.callbacks['pfnTouch'][i], E, E2)
  end
end

engine_events['pfnBlocked'] = function(E,E2)
  if engine_callback.callbacks['pfnBlocked'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnBlocked'] do
    pcall(engine_callback.callbacks['pfnBlocked'][i], E, E2)
  end
end

engine_events['pfnKeyValue'] = function(E,pkv)
  if engine_callback.callbacks['pfnKeyValue'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnKeyValue'] do
    pcall(engine_callback.callbacks['pfnKeyValue'][i], E, pkv)
  end
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
  if engine_callback.callbacks['pfnClientKill'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnClientKill'] do
    pcall(engine_callback.callbacks['pfnClientKill'][i], E)
  end
end

engine_events['pfnClientPutInServer'] = function(E)
  if engine_callback.callbacks['pfnClientPutInServer'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnClientPutInServer'] do
    pcall(engine_callback.callbacks['pfnClientPutInServer'][i], E)
  end
end

engine_events['pfnClientUserInfoChanged'] = function (E, buffer)
  if engine_callback.callbacks['pfnClientUserInfoChanged'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnClientUserInfoChanged'] do
    pcall(engine_callback.callbacks['pfnClientUserInfoChanged'][i], E, buffer)
  end
end

engine_events['pfnClientCommand'] = function(E, args, text)
  if engine_callback.callbacks['pfnClientCommand'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnClientCommand'] do
    pcall(engine_callback.callbacks['pfnClientCommand'][i], E, args, text)
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
  if engine_callback.callbacks['pfnStartFrame'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnStartFrame'] do
    pcall(engine_callback.callbacks['pfnStartFrame'][i])
  end
end

engine_events['pfnServerCommand'] = function (command)
  -- body
end

engine_events['pfnCvarValue2'] = function(E, req, name, value)
  if engine_callback.callbacks['pfnCvarValue2'] == nil then return end
  for i = 1, #engine_callback.callbacks['pfnCvarValue2'] do
    pcall(engine_callback.callbacks['pfnCvarValue2'][i], E, req, name, value)
  end
end