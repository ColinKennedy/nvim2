--- Fix the issue where quick-fix buffers choose the wrong window.
---
--- How To:
---     - Run `initialize()` once
---     - Run `choose_last_window()` before choosing a quick-fix entry.
---
--- @module 'my_custom.utilities.quick_fix_selection_fix'
---

local M = {}

local _PREVIOUS_ALLOWED_WINDOWS_BY_TAB = {}


--- Check if the cursor's current window is "okay for quick-fix to select".
---
local _is_current_window_allowed = function()
    local type_ = vim.o.filetype

    if (
        type_ == "toggleterm" -- Reference: https://github.com/akinsho/toggleterm.nvim
        or type_ == "qf"
        or type_ == "aerial"  -- Reference: https://github.com/stevearc/aerial.nvim
        or vim.o.buftype == "terminal"
    )
    then
        return false
    end

    return true
end


--- Set up auto-commands to track every "allowed" window for quick-fix to switch to.
function M.initialize()
    vim.api.nvim_create_autocmd(
        "BufEnter",
        {
            callback = function()
                local current_tab = vim.fn.tabpagenr()

                vim.schedule(
                    function()
                        if _is_current_window_allowed()
                        then
                            _PREVIOUS_ALLOWED_WINDOWS_BY_TAB[current_tab] = vim.api.nvim_get_current_win()
                        end
                    end
                )
            end
        }
    )
end


--- Make sure the current tab's cursor is on a "last okay" window.
---
--- - Requires `initialize()` to be called once, prior to calling this function.
--- - Run this function before calling any quick-fix next/previous commands.
---
function M.choose_last_window()
    if _is_current_window_allowed()
    then
        return
    end

    local current_tab = vim.fn.tabpagenr()
    local previous_window = _PREVIOUS_ALLOWED_WINDOWS_BY_TAB[current_tab]

    if previous_window == nil
    then
        vim.api.nvim_err_writeln(
            'Tab "' .. current_tab .. '" has no previous window to fall back to.'
        )

        return
    end

    vim.api.nvim_set_current_win(previous_window)
end


function M.safe_run(text)
    local success, _ = pcall(vim.cmd, text)

    if not success
    then
        vim.api.nvim_err_writeln("No more items")
    end
end


return M
