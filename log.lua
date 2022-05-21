log = {}

-- Log without any tag --
local function log_write(self, fmt, ...)
	local time = os.date("*t")
	local str = string.format(fmt, ...)
	local str2 = string.format("[%02i:%02i:%02i] %s\n", time.hour, time.min, time.sec, str)
	local file_str = os.date(self.filename.."_%Y_%m_%d.log")
	local file = io.open(file_str, "a+")
	file:write(str2)
	file:close()
end

-- Log with DEBUG: tag --
local function log_debug(self, fmt, ...)
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
local function log_warning(self, fmt, ...)
	local time = os.date("*t")
	local str = string.format(fmt, ...)
	local str2 = string.format("[%02i:%02i:%02i] WARNING: %s\n", time.hour, time.min, time.sec, str)
	local file_str = os.date(self.filename.."_%Y_%m_%d.log")
	local file = io.open(file_str, "a+")
	file:write(str2)
	file:close()
end

-- Log WITH ERROR: tag and throw error --
local function log_error(self, fmt, ...)
	local time = os.date("*t")
	local str = string.format(fmt, ...)
	local str2 = string.format("[%02i:%02i:%02i] ERROR: %s\n", time.hour, time.min, time.sec, str)
	local file_str = os.date(self.filename.."_%Y_%m_%d.log")
	local file = io.open(file_str, "a+")
	file:write(str2)
	file:close()
	error(str)
end

function log_debug_allow(self, boolean)
	self.debug_print = true
end

function log.open(filename)
	local local_table = { write = log_write, debug = log_debug, warning = log_warning, error = log_error, debug_allow = log_debug_allow }
	local_table.debug_print = false
	local_table.filename = string.format("%s/%s", LOGS_PATH, filename)
	return local_table
end
