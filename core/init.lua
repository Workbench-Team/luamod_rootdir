function include (file) dofile ("./valve/addons/luamod/includes/" .. file) end
function load_plugin (plugin) dofile ("./valve/addons/luamod/plugins/" .. plugin .. "/main.lua") end
function string.split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

dofile "./valve/addons/luamod/plugins.lua";
