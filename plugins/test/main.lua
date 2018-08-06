include 'cmd.lua'
include 'edict.lua'

-- Offset demo
cmd.setChatCommand('seth', function (executor, args)
    set_health(executor, tonumber(args[2]) or 100);
end);

-- Messages demo
cmd.setChatCommand('blood', function (executor, args)
    for i = 1, 10 do
    pfnMessageBegin(0, 23, { 0, 0, 0 }, 0);
    pfnWriteByte(101)
       pfnWriteCoord(1000)
       pfnWriteCoord(350)
       pfnWriteCoord(80)
       pfnWriteCoord(0)--//Вектор направления крови х
       pfnWriteCoord(0)--//Вектор направления крови у
       pfnWriteCoord(10)--//Вектор направления крови z
       pfnWriteByte(70)--//Цвет
       pfnWriteByte(math.random(50,100))--//Скорость
       pfnMessageEnd()
   end
end);
