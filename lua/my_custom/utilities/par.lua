local filer = require("my_custom.utilities.filer")

local _COMMAND_NAME = "par"

local M = {}


local _get_commands = function(source)
    local extraction_directory = "par-master" -- TODO: Auto-get this directory name

    local output = {}

    if vim.fn.filereadable(filer.join_path({source, "master.tar.gz"})) == 0
    then
        table.insert(
            output,
            {"wget", "https://github.com/sergi/par/archive/refs/heads/master.tar.gz"}
        )
    end

    local commands = {
        {"tar", "-xzvf", "master.tar.gz"},  -- This creates `extraction_directory`
        {"make", "-C", extraction_directory, "-f", "protoMakefile"},
        {
            "cp",
            filer.join_path({source, extraction_directory, command}),
            filer.join_path({bin, command}),
        },
    }

    vim.tbl_extend("error", output, commands)

    return output
end


local _prepend_to_path = function(path)
    vim.cmd("let $PATH='" .. path .. ":" .. os.getenv("PATH") .. "'")
end

-- Reference: http://www.nicemice.net/par/
--
-- s0 - disables suffixes
-- Reference: https://stackoverflow.com/q/6735996
--
local _enable_par = function()
    vim.opt.formatprg = "par s0w88"
end


local _run_shell_command = function(command, options)
    local job = vim.fn.jobstart(command, options)
    local result = vim.fn.jobwait({job})[1]

    if result == 0
    then
        return true
    end

    if result == -1
    then
        vim.api.nvim_err_writeln('The requested command "' .. command .. '" timed out.')

        return
    elseif result == -2
    then
        vim.api.nvim_err_writeln(
            'The requested command "'
            .. vim.inspect(command)
            .. '" was interrupted.'
        )

        return false
    elseif result == -3
    then
        vim.api.nvim_err_writeln('Job ID is invalid "' .. tostring(job) .. '"')

        return false
    -- TODO: Figure out if I need this, later
    -- else
    --     vim.api.nvim_err_writeln(
    --         'Command "'
    --         .. vim.inspect(command)
    --         .. '" created unknown error "'
    --         .. tostring(result)
    --         .. '".'
    --     )
    --
    --     return false
    end

    -- TODO: Possible remove this
    return true
end


function M.load_or_install()
    local executable = vim.fn.executable("par") == 1

    if executable
    then
        -- If `par` is installed, add it here
        _enable_par()

        return
    end

    local bin = filer.join_path({vim.g.vim_home, "bin"})

    if vim.fn.filereadable(filer.join_path({bin, _COMMAND_NAME})) == 1
    then
        -- If `par` exists on-disk, add it to (Neo)vim
        _prepend_to_path(bin)
        _enable_par()

        return
    end

    local source = filer.join_path({vim.g.vim_home, "sources", "par"})

    if vim.fn.isdirectory(source) == 0
    then
        vim.fn.mkdir(source, "p")  -- Recursively create directories
    end

    local commands = _get_commands(source)
    print(vim.inspect(commands))

    for _, command in ipairs(commands)
    do
        stderr = {}

        if not _run_shell_command(
            command,
            {
                cwd=source,
                on_stderr=function(job_id, data, event)
                    for line in ipairs(data)
                    do
                        table.insert(stderr, data)
                    end
                end,
            }
        )
        then
            vim.api.nvim_err_writeln('Cannot install par')
            print("STDERR")
            print(sterr)

            return
        end
    end

    if vim.fn.isdirectory(bin) == 0
    then
        vim.fn.mkdir(bin, "p")  -- Recursively create directories
    end

    _prepend_to_path(bin)
    _enable_par()
end


return M
