--- Allow writing to files asnchronously.
---
--- Reference: https://github.com/neovim/neovim/issues/11005#issuecomment-1271575651
---
---@module 'my_custom.start.saver'
---

local M = {}


--- Show an error if not `ok` and include `message`.
---
---@param ok boolean The status of the async write.
---@param message string The error message to use, if any.
---
local function _callback(ok, message)
    vim.schedule(function()
        if ok then
            vim.cmd.checktime()
        elseif message and message ~= '' then
            vim.api.nvim_err_writeln(message)
        else
            vim.api.nvim_err_writeln("Something in the async write failed, not sure what")
        end
    end)
end


--- Write `data` to `path` in another thread.
---
---@param path string The file on-disk that will be modified.
---@param data string[] The blob of text to write.
---
local function _async_write(path, data)
    local status = true
    local message = ""
    local fd, omsg, _ = vim.uv.fs_open(path, 'w', 438)
    if not fd then
        status, message = false, ("Failed to open: %s\n%s"):format(path, omsg)
    else
        local ok, wmsg, _ = vim.uv.fs_write(fd, data, 0)
        if not ok then
            status, message = false, ("Failed to write: %s\n%s"):format(path, wmsg)
        end
    end

    if fd then
        assert(vim.loop.fs_close(fd))
    end

    return status, message
end


--- Create the :AsyncWrite command (for writing without blocking Neovim)
function M.initialize()
    vim.api.nvim_create_user_command(
        "AsyncWrite",
        function()
            local work = vim.loop.new_work(_async_write, _callback)
            local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            work:queue(vim.api.nvim_buf_get_name(0), table.concat(lines, "\n"))
        end,
        {}
    )
end


return M
