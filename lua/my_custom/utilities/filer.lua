function ends_with(text, suffix)
    return text:sub(-#suffix) == suffix
end


local get_directory = function(path, separator)
    if vim.fn.has("win32") == 1
    then
        separator = separator or '\\'
    else
        separator = separator or '/'
    end

    directory = path:match("(.*" .. separator .. ").*")

    if ends_with(directory, separator)
    then
        return directory:sub(1, #directory - 1)
    end

    return directory
end


local get_current_directory = function()
    caller_frame = debug.getinfo(2)
    current_file = caller_frame.source:match("@?(.*)")

    return get_directory(current_file)
end


local module = {}

module.get_current_directory = get_current_directory

return module
