local _is_terminal = function(data)
    local variables = data["variables"]

    if variables == nil
    then
        return false
    end

    return variables["terminal_job_id"] ~= nil
end


local _is_code_buffer = function(data)
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


local get_current_quick_fix_window = function()
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


local get_latest_non_terminal_buffer = function()
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

local select_last_code_window = function()
    local window = get_latest_non_terminal_buffer()

    if window == nil
    then
        print("No alternate buffer could be found.")

        return
    end

    vim.api.nvim_set_current_win(window)
end


local select_quick_fix_window = function()
    local window = get_current_quick_fix_window()

    if window == nil
    then
        print("No QuickFix buffer could be found.")

        return
    end

    vim.api.nvim_set_current_win(window)
end


local M = {}

M.select_last_code_window = select_last_code_window
M.select_quick_fix_window = select_quick_fix_window

return M
