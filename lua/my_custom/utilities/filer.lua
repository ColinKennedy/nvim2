local get_current_directory = function()
    return debug.getinfo(2).source:match("@?(.*/)")
end

local module = {}

module.get_current_directory = get_current_directory

return module
