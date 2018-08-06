function set_health (E, value)
    local entvars = get_offset_data(E, 0x80);
    set_offset_float(entvars, 0x160, value)
end
