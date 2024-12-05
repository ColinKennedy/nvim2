--- Find the quickfix window when we need to. Find the code window when we need to.
---
---@module 'my_custom.utilities.choose_window'
---

local M = {}

--- Check if `data` is meant to display source code.
---
---@param data vim.fn.getwininfo.ret.item The window to consider.
---@return boolean # If `data` is for code, return `true`.
---
local function _is_code_buffer(data)
    local buffer_type = vim.fn.getbufvar(data.bufnr, "&buftype")

    if (
        buffer_type == "terminal"
        or buffer_type == "quickfix"
        or buffer_type == "loclist"
        or buffer_type == "nofile"  -- Needed for floating / virtual windows
    )
    then
        return false
    end

    return true
end


---@return number? # Find the quickfix in the current tab.
local function get_current_quick_fix_window()
    local winner_buffer = nil

    for _, data in pairs(vim.fn.getwininfo())
    do
        local buffer = data.bufnr
        local info = vim.fn.getbufinfo(buffer)

        for _, entry in pairs(info)
        do
            if entry ~= nil
            then
                if entry.hidden == 0 and vim.fn.getbufvar(data.bufnr, "&buftype") == "quickfix"
                then
                    winner_buffer = data.winid
                end
            end
        end
    end

    return winner_buffer
end

---@return number # Find the last buffer that is no a terminal.
local function get_latest_non_terminal_buffer()
    local winner_buffer = nil
    local winner_last_used = 0

    for _, data in pairs(vim.fn.getwininfo())
    do
        local buffer = data.bufnr
        local info = vim.fn.getbufinfo(buffer)

        for _, entry in pairs(info)
        do
            if entry ~= nil
            then
                local used = entry.lastused

                if entry.hidden == 0 and used and used > winner_last_used and _is_code_buffer(entry)
                then
                    winner_last_used = used
                    winner_buffer = data.winid
                end
            end
        end
    end

    if winner_buffer ~= nil
    then
        return winner_buffer
    end

    return nil
end

--- Select the last window in the current tab that was not a quickfix window.
function M.select_last_code_window()
    local window = get_latest_non_terminal_buffer()

    if window == nil
    then
        print("No alternate buffer could be found.")

        return
    end

    vim.api.nvim_set_current_win(window)
end


--- Find the nearest quickfix window in the current tab and switch to it.
function M.select_quick_fix_window()
    local window = get_current_quick_fix_window()

    if window == nil
    then
        print("No QuickFix buffer could be found.")

        return
    end

    vim.api.nvim_set_current_win(window)
end

return M
