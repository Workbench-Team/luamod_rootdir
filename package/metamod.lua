local ffi = require("ffi")

ffi.cdef[[
enum META_RES
{
        MRES_UNSET = 0,
        MRES_IGNORED,       // plugin didn't take any action
        MRES_HANDLED,       // plugin did something, but real function should still be called
        MRES_OVERRIDE,      // call real function, but use my return value
        MRES_SUPERCEDE,     // skip real function; use my return value
};

struct meta_globals_t
{
        enum META_RES mres;          // writable; plugin's return flag
        enum META_RES prev_mres;     // readable; return flag of the previous plugin called
        enum META_RES status;        // readable; "highest" return flag so far
        void *orig_ret;         // readable; return value from "real" function
        void *override_ret;     // readable; return value from overriding/superceding plugin
};
]]

return ffi.cast("struct meta_globals_t *", METAMOD_GLOBALS)