plugin = { pool = {} }

function plugin.register(author, name, version, description)
	table.insert(plugin.pool, { author = author, name = name, version = version, description = description })
end
