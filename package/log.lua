local log = { debug_print = false }

-- Log without any tag --
function log.write(self, fmt, ...)
	local time = os.date("*t")
	local str = string.format(fmt, ...)
	local str2 = string.format("[%02i:%02i:%02i] %s\n", time.hour, time.min, time.sec, str)
	local file_str = os.date(self.filename.."_%Y_%m_%d.log")
	local file = io.open(file_str, "a+")
	file:write(str2)
	file:close()
end

-- Log with DEBUG: tag --
function log.debug(self, fmt, ...)
	if self.debug_print == false then return end
	local time = os.date("*t")
	local str = string.format(fmt, ...)
	local str2 = string.format("[%02i:%02i:%02i] DEBUG: %s\n", time.hour, time.min, time.sec, str)
	local file_str = os.date(self.filename.."_%Y_%m_%d.log")
	local file = io.open(file_str, "a+")
	file:write(str2)
	file:close()
end

-- Log with WARNING: tag --
function log.warning(self, fmt, ...)
	local time = os.date("*t")
	local str = string.format(fmt, ...)
	local str2 = string.format("[%02i:%02i:%02i] WARNING: %s\n", time.hour, time.min, time.sec, str)
	local file_str = os.date(self.filename.."_%Y_%m_%d.log")
	local file = io.open(file_str, "a+")
	file:write(str2)
	file:close()
end

-- Log WITH ERROR: tag and throw error --
function log.error(self, fmt, ...)
	local time = os.date("*t")
	local str = string.format(fmt, ...)
	local str2 = string.format("[%02i:%02i:%02i] ERROR: %s\n", time.hour, time.min, time.sec, str)
	local file_str = os.date(self.filename.."_%Y_%m_%d.log")
	local file = io.open(file_str, "a+")
	file:write(str2)
	file:close()
	error(str)
end

function log.debug_allow(self, boolean)
	self.debug_print = true
end

function log.open(filename)
	local local_table = log
	local_table.debug_print = false
	local_table.filename = string.format("%s/%s", LOGS_PATH, filename)
	return local_table
end

return log
