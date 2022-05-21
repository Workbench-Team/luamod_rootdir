plugin.register("Mr0maks", "Admins Models", "0.0.1", "Simple plugin to reserve models for admins")

local privilege = require("privilege")

local plugin_config = config.read("admin_models")
local admin_models = plugin_config.admin
local default_model = plugin_config.default_model

local function change_model_if_need(E)
local model = get_entity_keyvalue(E, "model");
local admin = (privilege.get(E) == "admin")

for i = 1, #admin_models do
	if admin_models[i] == model then
		if not admin then engine.client_command(E, string.format("model %s", default_model)) end
	end
end

end

engine_callback.register('pfnClientUserInfoChanged', change_model_if_need)
engine_callback.register('pfnClientPutInServer', change_model_if_need)
