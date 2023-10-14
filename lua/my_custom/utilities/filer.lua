local M = {}


local ends_with = function(text, suffix)
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


function M.get_current_directory()
    caller_frame = debug.getinfo(2)
    current_file = caller_frame.source:match("@?(.*)")

    return get_directory(current_file)
end

M.os_separator = package.config:sub(1, 1)

if vim.fn.has("win32") == 1
then
    M.command_separator = ";"
    M.path_separator = ";"
elseif vim.fn.has("unix") == 1
then
    M.command_separator = ";"
    M.path_separator = ":"
else
    vim.api.nvim_err_writeln("Not sure what OS path separator to use")

    M.command_separator = ";"
    M.path_separator = ":"
end


function M.join_path(parts)
    output = ""

    for _, part in ipairs(parts)
    do
        if output == ""
        then
            output = part
        else
            output = output .. M.os_separator .. part
        end
    end

    return output
end

function M.join_os_paths(paths)
    output = ""

    for _, path in ipairs(paths)
    do
        if output == ""
        then
            output = path
        else
            output = output .. M.path_separator .. path
        end
    end

    return output
end

return M
