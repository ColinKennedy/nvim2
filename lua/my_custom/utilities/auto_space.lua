local M = {}

local _BUILTINS = {
    ["False"] = true,
    ["None"] = true,
    ["True"] = true,
    ["and"] = true,
    ["as"] = true,
    ["assert"] = true,
    ["break"] = true,
    ["class"] = true,
    ["continue"] = true,
    ["def"] = true,
    ["del"] = true,
    ["elif"] = true,
    ["else"] = true,
    ["except"] = true,
    ["finally"] = true,
    ["for"] = true,
    ["from"] = true,
    ["global"] = true,
    ["if"] = true,
    ["import"] = true,
    ["in"] = true,
    ["is"] = true,
    ["lambda"] = true,
    ["nonlocal"] = true,
    ["not"] = true,
    ["or"] = true,
    ["pass"] = true,
    ["raise"] = true,
    ["return"] = true,
    ["try"] = true,
    ["while"] = true,
    ["with"] = true,
    ["yield"] = true,
}

function _has_expected_last_character(character)
    if character:match("%w")  -- Reference: https://stackoverflow.com/a/12118024/3626104
    then
        return true
    end

    if character:match("]")
    then
        return true
    end

    if character:match("}")
    then
        return true
    end

    return false
end


function _is_assignable(text)
    _, count = string.gsub(text, "%s+", "")

    if count ~= 0
    then
        return false
    end

    if not _has_expected_last_character(text:sub(-1))
    then
        return false
    end

    if _is_builtin_keyword(text:gsub("%s+", ""))
    then
        -- Strip whitespace of `text` and check if it's a built-in keyword
        return false
    end

    if _is_blacklisted_context()
    then
        return false
    end

    return true
end


function _is_blacklisted_context()
    return vim.treesitter.get_node({buffer=0}):type() == "string_content"
end


function _is_builtin_keyword(text)
    return _BUILTINS[text] ~= nil
end


local _lstrip = function(text)
    return text:match("^%s*(.*)")
end


function _strip_characters(text)
    text = text:gsub("%(.+%)", "()")
    text = text:gsub("%[.+%]", "[]")

    return text
end


function M.add_equal_sign_if_needed()
    _, cursor_row, cursor_column, _ = unpack(vim.fn.getpos("."))
    current_line = vim.fn.getline(cursor_row)

    if cursor_column <= #current_line
    then
        -- If the cursor isn't at the end of the line, stop. There's no
        -- container data-type in Python where `=` are expected so this is
        -- always supposed to be a space.
        --
        return " "
    end

    current_line_up_until_cursor = current_line:sub(1, cursor_column)
    stripped = _strip_characters(current_line_up_until_cursor)

    if not _is_assignable(_lstrip(stripped))
    then
        return " "
    end

    return " = "
end

return M
