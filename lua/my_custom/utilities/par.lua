local filer = require("my_custom.utilities.filer")

local M = {}

local _enable_par = function(path)
    vim.cmd("let $PATH=" .. path .. ":" .. os.getenv("PATH"))
    vim.opt.formatprg = "par s0w88"
end


local _run_shell_command = function(command, options)
    local job = vim.fn.jobstart(command, options)
    local result = vim.fn.jobwait({job})

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
    else
        vim.api.nvim_err_writeln(
            'Command "'
            .. vim.inspect(command)
            .. '" created unknown error "'
            .. tostring(result)
            .. '".'
        )

        return false
    end
end


function M.load_or_install()
    -- TODO: Make this OS-agnostic (for Windows, too)
    local bin = vim.g.vim_home .. filer.os_separator .. "bin"

    if vim.fn.isdirectory(bin) == 0
    then
        vim.fn.mkdir(bin, "p")  -- Recursively create directories
    end

    -- If `par` is installed, add it here
    -- Reference: http://www.nicemice.net/par/
    --
    -- s0 - disables suffixes
    -- Reference: https://stackoverflow.com/q/6735996
    --
    if vim.fn.executable("par") == 1
    then
        _enable_par(bin)

        return
    end

    -- TODO: Make this OS-agnostic (for Windows, too)
    local source = vim.g.vim_home .. filer.os_separator .. "sources" .. filer.os_separator .. "par"

    if vim.fn.isdirectory(source) == 0
    then
        vim.fn.mkdir(source, "p")  -- Recursively create directories
    end

    local commands = {
        {"wget", "https://github.com/sergi/par/archive/refs/heads/master.tar.gz"},
        {"tar", "-xzvf", "master.tar.gz", "source"},
        {"make", "-C", "./source", "install"}
    }
    for _, command in ipairs(commands)
    do
        if not _run_shell_command(command, {cwd=source})
        then
            vim.api.nvim_err_writeln('Cannot install par')

            return
        end
    end

    _enable_par(bin)
end


return M
