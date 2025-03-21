local M = {}

function M.close_all_floating_windows()
    ---@type number[]
    local closed_windows = {}

    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)

        if config.relative ~= "" then -- is_floating_window?
            vim.api.nvim_win_close(win, false) -- do not force
            table.insert(closed_windows, win)
        end
    end

    print(string.format("Closed %d windows: %s", #closed_windows, vim.inspect(closed_windows)))
end

return M
