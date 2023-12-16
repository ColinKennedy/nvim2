local protected_window = require("my_custom.utilities.protected_window")

-- Make it so the quick-fix window will always display the quick-fix buffer
protected_window.register_window_and_buffer(
    vim.api.nvim_get_current_win(),
    vim.fn.bufnr()
)

-- If the list of matches is smaller than the window, shrink the window to match.
-- If it's the first time initializing the window, set it to a reasonable default size
-- Otherwise, don't resize the quickfix window
--
local _DEFAULT_SIZE = 10
vim.api.nvim_create_autocmd(
    "QuickFixCmdPost",
    {
        callback = function()
            local window = vim.fn.getqflist({winid=1}).winid

            if window == 0
            then
                return
            end

            local quickfix_length = #vim.fn.getqflist()
            local window_height = vim.api.nvim_win_get_height(window)

            if quickfix_length <= window_height
            then
                vim.api.nvim_win_set_height(window, quickfix_length)

                return
            end

            if window_height > _DEFAULT_SIZE
            then
                return
            end

            vim.api.nvim_win_set_height(window, math.min(quickfix_length, _DEFAULT_SIZE))
        end
    }
)
