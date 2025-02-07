--- Make file / directory operations easier.
---
---@module 'my_custom.utilities.filer'
---

local M = {}

if vim.fn.has("win32") == 1 then
    M.command_separator = ";"
    M.path_separator = ";"
elseif vim.fn.has("unix") == 1 then
    M.command_separator = ";"
    M.path_separator = ":"
else
    vim.notify("Not sure what OS path separator to use", vim.log.levels.ERROR)

    M.command_separator = ";"
    M.path_separator = ":"
end

--- Get the directory of the current Lua script that called this function.
---
---@return string # The found directory on-disk.
---
function M.get_current_directory()
    local caller_frame = debug.getinfo(2)
    local current_file = caller_frame.source:match("@?(.*)")

    return vim.fs.dirname(current_file)
end

--- Combine `paths` into a single OS-separated string.
---
---@param paths string[] All files or directories on-disk to join. e.g. `{"/foo/bar", "/fizz"}`.
---@return string # The joined paths. `"/foo/bar:/fizz"`.
---
function M.join_os_paths(paths)
    local output = ""

    for _, path in ipairs(paths) do
        if output == "" then
            output = path
        else
            output = output .. M.path_separator .. path
        end
    end

    return output
end

--- Find the top-most directory, starting from `directory`.
---
---@param directory string? An absolute path within some git, Rez, etc directory.
---@return string? # The found path, if any.
---
function M.get_project_root(directory)
    local current = directory or vim.fn.getcwd()
    -- TODO: Convert these functions to Lua when I feel like it someday
    local search_options = {
        "searcher#get_cmake_root",
        "searcher#get_rez_root",
        "searcher#get_git_root",
    }

    for _, name in ipairs(search_options) do
        local root = vim.fn[name](current)

        if root ~= "" then
            return root
        end
    end

    return nil
end

return M
