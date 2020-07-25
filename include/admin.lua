include 'admins.lua'

function admin_check(E)
local authid = get_player_authid(E);
local is_admin = 0;
for i = 0, #admins do
if authid == admins[i] then is_admin = 1; end
end
return is_admin;
end

function admin_id(E)
local authid = get_player_authid(E);
for i = 0, #admins do
if authid == admins[i] then number_in_mass = i; end
end
return number_in_mass;
end
