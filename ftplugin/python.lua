-- Set up Vim so it is able to parse Python tracebacks. This command uses
-- a ``$VIMHOME/compiler/python.vim``, assuming it exists (which it should,
-- I wrote it).
--
vim.cmd[[
if !exists("current_compiler")
  compiler python
endif
]]

-- Give a sensible default when running ``make`` so that ``:Make`` (from
--
-- https://github.com/tpope/vim-dispatch) knows how to process Python files.
--
-- It's not technically "correct" to have a ``:make`` call immediately run unittests
-- but you don't normally call ``:make`` / ``:Make`` in Python so it's ours to use.
--
vim.o.makeprg = "python -m unittest discover"


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


function add_equal_sign_if_needed()
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

    if not _is_assignable(stripped)
    then
        return " "
    end

    return " = "
end


vim.keymap.set(
    "i",
    "<Space>",
    add_equal_sign_if_needed,
    { desc = "Add = signs when needed.", expr = true }
)
