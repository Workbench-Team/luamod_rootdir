plugin.register("Professor Brain", "Log Player Put", "no version", "Print player put in server to console")

engine_callback.register("pfnClientPutInServer", function (E)
	print("Player "..get_entity_keyvalue(E, "name").." put in server!")
end)
