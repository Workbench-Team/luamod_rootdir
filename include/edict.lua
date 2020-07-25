function set_health (E, value)
    local entvars = get_offset_data(E, 0x80);
    set_offset_float(entvars, 0x160, value)
end

function set_movetype (E, value)
    local entvars = get_offset_data(E, 0x80);
    set_offset_int(entvars, 0x108, value)
end

function  set_rendermode(E, value)
	local entvars = get_offset_data(E, 0x80);
    set_offset_int(entvars, 0x148, value)
end
