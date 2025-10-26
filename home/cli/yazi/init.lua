function Linemode:size_mtime()
	local mtime_num = math.floor(self._file.cha.mtime or 0)
	local mtime_str
	if mtime_num == 0 then
		mtime_str = ""
	else
		mtime_str = os.date("%Y-%m-%d %H:%M", mtime_num)
	end

	local size = self._file:size()

	return string.format("%s %s", size and ya.readable_size(size) or "-", mtime_str)
end

-- starship.yazi
require("starship"):setup()
