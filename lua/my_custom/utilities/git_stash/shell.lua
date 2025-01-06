--- Functions to make it easier to communicate with an external shell.
---
--- @module 'my_custom.utilities.git_stash.shell'
---

local M = {}

--- @class _ShellArguments
--- @field cwd string? The directory on-disk where a shell command will be called from.
--- @field on_stderr fun(job_id: integer, data: table<string>, event): nil An on-error callback.

--- Run `command` with shell `options` and indicate if the call succeeded.
---
--- @param command string The shell command to call. No string escapes needed.
--- @param options _ShellArguments Optional data to include for the shell command.
--- @return boolean # If success, return `true`.
---
function M.run_command(command, options)
    local job = vim.fn.jobstart(command, options)
    local result = vim.fn.jobwait({ job })[1]

    if result == 0 then
        return true
    end

    if result == -1 then
        vim.api.nvim_err_writeln('The requested command "' .. command .. '" timed out.')

        return false
    elseif result == -2 then
        vim.api.nvim_err_writeln('The requested command "' .. vim.inspect(command) .. '" was interrupted.')

        return false
    elseif result == -3 then
        vim.api.nvim_err_writeln('Job ID is invalid "' .. tostring(job) .. '"')

        return false
    end

    return true
end

return M
