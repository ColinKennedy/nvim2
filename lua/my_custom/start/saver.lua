-- Allow writing to files asnchronously
--
-- Reference: https://github.com/neovim/neovim/issues/11005#issuecomment-1271575651
--

local M = {}


local function callback(ok, message)
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


local function async_write(filename, data)
    local status = true
    local message = ""
    local fd, omsg, _ = vim.loop.fs_open(filename, 'w', 438)
    if not fd then
        status, message = false, ("Failed to open: %s\n%s"):format(filename, omsg)
    else
        local ok, wmsg, _ = vim.loop.fs_write(fd, data, 0)
        if not ok then
            status, message = false, ("Failed to write: %s\n%s"):format(filename, wmsg)
        end
    end

    assert(vim.loop.fs_close(fd))

    return status, message
end


--- Create the :AsyncWrite command (for writing without blocking Neovim)
function M.initialize()
    vim.api.nvim_create_user_command(
        "AsyncWrite",
        function()
            local work = vim.loop.new_work(async_write, callback)
            local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            work:queue(vim.api.nvim_buf_get_name(0), table.concat(lines, "\n"))
        end,
        {}
    )
end


return M
