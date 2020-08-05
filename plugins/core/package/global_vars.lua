local ffi = require("ffi")

ffi.cdef[[
typedef struct {
	float 	time;
	float 	frametime;
	float 	force_retouch;
	string_t 	mapname;
	string_t 	startspot;
	float 	deathmatch;
	float 	coop;
	float 	teamplay;
	float 	serverflags;
	float 	found_secrets;
	vec3_t 	v_forward;
	vec3_t 	v_up;
	vec3_t 	v_right;
	float 	trace_allsolid;
	float 	trace_startsolid;
	float 	trace_fraction;
	vec3_t 	trace_endpos;
	vec3_t 	trace_plane_normal;
	float 	trace_plane_dist;
	edict_t * 	trace_ent;
	float 	trace_inopen;
	float 	trace_inwater;
	int 	trace_hitgroup;
	int 	trace_flags;
	int 	msg_entity;
	int 	cdAudioTrack;
	int 	maxClients;
	int 	maxEntities;
	const char * 	pStringBase;
	void * 	pSaveData;
	vec3_t 	vecLandmarkOffset;
} globalvars_t;
]]

return ffi.cast("globalvars_t *", GAME_GLOBALS)