--- A module for finding and applying `par` to Neovim (or compiling it, if neededed).
---
---@module 'my_custom.utilities.par'
---

local shell = require("my_custom.utilities.git_stash.shell")

local _COMMAND_NAME = "par"

local M = {}

--- Create a command-line call to copy `source` to `destination`.
---
---@param source string The absolute path to some file on-disk to copy.
---@param destination string The absolute path to some path to copy to.
---@return string[] # The command to run via the command-line
---
local _get_copy_command = function(source, destination)
    if vim.fn.has("win32") == 1 then
        return { "Xcopy", source, destination }
    end

    return { "cp", source, destination }
end

--- Get the commands needed in order to compile `par` from scratch.
---
---@param source string The absolute path to `"$XDG_CONFIG_PATH/nvim/sources/par"`.
---@param bin string The absolute path where the `par` executable goes when it's compiled.
---@return string[] # The commands to run.
---
local _get_par_compile_commands = function(source, bin)
    local extraction_directory = "par-master" -- TODO: Auto-get this directory name

    ---@type string[][]
    local output = {}

    if vim.fn.filereadable(vim.fs.joinpath(source, "master.tar.gz")) == 0 then
        table.insert(output, { "wget", "https://github.com/sergi/par/archive/refs/heads/master.tar.gz" })
    end

    local commands = {
        { "tar", "-xzvf", "master.tar.gz" }, -- This creates `extraction_directory`
        { "make", "-C", extraction_directory, "-f", "protoMakefile" },
    }

    -- TODO: Make this code simpler. Just dispatch separate jobs for tar / make
    -- and then rely on the Lua / Vimscript APIs as much as possible.
    --
    table.insert(
        commands,
        _get_copy_command(
            vim.fs.joinpath(source, extraction_directory, _COMMAND_NAME),
            vim.fs.joinpath(bin, _COMMAND_NAME)
        )
    )

    if vim.fn.isdirectory(bin) == 0 then
        vim.fn.mkdir(bin, "p") -- Recursively create directories
    end

    for _, command in ipairs(commands) do
        table.insert(output, command)
    end

    return output
end

--- Add `path` to the `$PATH` environment variable.
---
---@param path string An absolute or relative directory on-disk.
---
local _prepend_to_path = function(path)
    vim.cmd("let $PATH='" .. path .. ":" .. os.getenv("PATH") .. "'")
end

---@source http://www.nicemice.net/par
---@source https://stackoverflow.com/q/6735996
---
--- s0 - disables suffixes
---
local _enable_par = function()
    vim.opt.formatprg = "par s0w88"
end

--- Find a valid `par` executable and load it, if able.
function M.load_or_install()
    local executable = vim.fn.executable("par") == 1

    if executable then
        -- If `par` is installed, add it here
        _enable_par()

        return
    end

    local bin = vim.fs.joinpath(vim.g.vim_home, "bin", vim.uv.os_uname().sysname)

    if vim.fn.filereadable(vim.fs.joinpath(bin, _COMMAND_NAME)) == 1 then
        -- If `par` exists on-disk, add it to (Neo)vim
        _prepend_to_path(bin)
        _enable_par()

        return
    end

    local source = vim.fs.joinpath(vim.g.vim_home, "sources", "par")

    if vim.fn.isdirectory(source) == 0 then
        vim.fn.mkdir(source, "p") -- Recursively create directories
    end

    local commands = _get_par_compile_commands(source, bin)

    for _, command in ipairs(commands) do
        ---@type string[]
        local stderr = {}

        if
            not shell.run_command(command, {
                cwd = source,
                on_stderr = function(_, data, _)
                    for line in ipairs(data) do
                        table.insert(stderr, line)
                    end
                end,
            })
        then
            vim.api.nvim_err_writeln("Cannot install par.")

            return
        end
    end

    if vim.fn.isdirectory(bin) == 0 then
        vim.fn.mkdir(bin, "p") -- Recursively create directories
    end

    _prepend_to_path(bin)
    _enable_par()
end

return M
