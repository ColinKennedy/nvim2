local M = {}


--- Pair `window` with `buffer` so that `window` will always display `buffer`.
---
--- This is a bit of a hack. Vim doesn't actually have a way to force windows
--- to stay as one buffer. So I just revert it back as soon as it happens.
---
--- Reference:
---     https://www.reddit.com/r/vim/comments/17l2wxm/how_can_you_prevent_a_window_from_changing_buffers/
---
--- @param window integer The Window ID to "keep looking at a single `buffer`".
--- @param buffer integer The Buffer ID that will `window` will always display.
---
function M.register_window_and_buffer(window, buffer)
    vim.api.nvim_create_autocmd(
        "BufLeave",
        {
            callback = function()
                local current_window = vim.api.nvim_get_current_win()

                if current_window ~= window
                then
                    -- An unrelated window was changed. Skip.
                    return
                end

                if not vim.api.nvim_win_is_valid(current_window)
                then
                    -- The window was closed. Skip.
                    return
                end

                -- Change the window's buffer back to the buffer that it should be
                vim.schedule(
                    function()
                        local current_buffer = vim.fn.bufnr()

                        if current_buffer == buffer
                        then
                            return
                        end

                        vim.api.nvim_win_set_buf(window, buffer)
                    end
                )
            end,
        }
    )
end


return M
