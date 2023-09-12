local M = {}

function _is_assignable(text)
    count = 0

    for word in text:gmatch("%s+")
    do
        if count > 1
        then
            return false
        end

        count = count + 1
    end

    if count ~= 1
    then
        return false
    end

    last_character = text:sub(-1)

    if last_character:match("%w")  -- Reference: https://stackoverflow.com/a/12118024/3626104
    then
        return true
    end

    if last_character:match("]")
    then
        return true
    end

    if last_character:match("}")
    then
        return true
    end

    return false
end


function _strip_characters(text)
    text = text:gsub("%(.+%)", "()")
    text = text:gsub("%[.+%]", "[]")

    return text
end


-- function M.add_equal_sign_if_needed()
--     return "%<Space>"
--     -- -- _, cursor_row, cursor_column, _ = unpack(vim.fn.getpos("."))
--     -- _, cursor_row, cursor_column, _ = unpack(vim.fn.getpos("."))
--     -- current_line = vim.fn.getline(cursor_row)
--     --
--     -- current_line_up_until_cursor = current_line:sub(1, cursor_column)
--     -- stripped = _strip_characters(current_line_up_until_cursor)
--     --
--     -- if not _is_assignable(stripped)
--     -- then
--     --     vim.cmd[[execute "normal A\<Space>"]]
--     --     return
--     -- end
--     --
--     -- new_text = current_line .. " = "
--     -- vim.fn.setline(cursor_row, new_text)
--     -- current_buffer = 0
--     -- current_cursor = "."  -- See `:help setpos()`
--     -- new_column = new_text:len()
--     -- vim.fn.setpos(current_cursor, {current_buffer, cursor_row, new_column, 0})
--     -- vim.cmd[[execute "normal! A\<Space>"]]
-- end


function M.add_equal_sign_if_needed()
    _, cursor_row, cursor_column, _ = unpack(vim.fn.getpos("."))
    current_line = vim.fn.getline(cursor_row)

    current_line_up_until_cursor = current_line:sub(1, cursor_column)
    stripped = _strip_characters(current_line_up_until_cursor)

    if not _is_assignable(stripped)
    then
        return " "
    end

    return " = "
end

function M.setup()
    vim.keymap.set(
        "i",
        "<Space>",
        M.add_equal_sign_if_needed,
        {
            desc = "Add = signs when needed.",
            expr = true,
        }
    )
end

return M
