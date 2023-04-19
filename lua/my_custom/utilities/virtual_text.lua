local M = {}

local _NAMESPACE = vim.api.nvim_create_namespace("x_marks_the_spot")


function _in(key, set)
    return set[key] ~= nil
end


function _extend_set(set, keys)
    for _, key in pairs(keys)
    do
        set[key] = true
    end
end


function _remove_from_set(key, set)
    set[key] = nil
end


function M.add_all_marks(window)
    local window = window or 0  -- 0 == "the current window"
    local replacement_character = "x"
    local allowed_characters = {}
    _extend_set(allowed_characters, {" ", "\\t"})

    local highest_priority = 999

    for row=0,vim.fn.line("$")
    do
        local line = vim.fn.getline(row)

        for index=1,#line
        do
            local character = string.sub(line, index, index)

            if not _in(character, allowed_characters)
            then
                vim.api.nvim_buf_set_extmark(
                    window,
                    _NAMESPACE,
                    row - 1,  -- Neovim APIs expect 0-or-more indices
                    index - 1,  -- Neovim APIs expect 0-or-more indices
                    {
                        virt_text = { {replacement_character, "String" }},
                        virt_text_pos = "overlay",
                        hl_mode = "replace",
                        priority = highest_priority,
                    }
                )
            end
        end
    end
end


function M.remove_all_marks(window)
    local window = window or 0  -- 0 == "the current window"
    local line_start = 0
    local line_end = -1

    vim.api.nvim_buf_clear_namespace(window, _NAMESPACE, line_start, line_end)
end

return M
