local function has_value (tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local function prequire (package_name)
	local status_ok, package = pcall(require, package_name)
	if not status_ok then
		vim.notify(package_name + "package not found")
		return
	end

	return package

end

return {
	prequire = prequire,
	has_value = has_value
}
