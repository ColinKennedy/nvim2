--- Remove prefix indentation from `text`.
---
--- @param text string The text that may or may not have whitespace.
--- @return string # The original `text` but no leading whitespace.
---
local function _strip_leading_whitespace(text)
    return text:gsub("^%s*", "")
end

--- Find the prefix indentation of `text`.
---
--- @param text string The text that may or may not have whitespace.
--- @return string # Just the leading whitespace, without the rest of `text`.
---
local function _get_leading_whitespace(text)
    return text:sub(0, #text - #_strip_leading_whitespace(text))
end

--- Query minimum leading indentation that every line shares.
---
--- If a paragraph of text is indented, for example, this code is meant to find
--- that indentation.
---
--- @param lines string[] All of the lines of text to find.
--- @return string # The common indentation.
---
local function _get_common_indent(lines)
    local common_indent = nil

    for _, line in ipairs(lines) do
        local indent = _get_leading_whitespace(line)

        if indent ~= nil and (common_indent == nil or indent < common_indent) then
            common_indent = indent
        end
    end

    return common_indent
end

--- Split `text` whenever a newline is found. Return all of the found lines.
---
--- Lines with no text, whitespace, are preserved.
---
--- @param text string A blob of text to split up.
--- @return string[] # The split lines.
---
local function _split_lines(text)
    local lines = {}

    for line in text:gmatch("([^\n]*)\n?") do
        table.insert(lines, line)
    end

    -- The last line sometimes registers an extra \n. If there, remove it
    local last_line = #lines

    if lines[last_line] == "" then
        table.remove(lines, last_line)
    end

    return lines
end

--- Shift `lines` horizontally so to give it new whitespace.
---
--- @param lines string[] Some text that may or may not already have leading whitespace.
--- @param extra_whitespace_to_add string A common, minimum whitespace to use, instead.
--- @return string[] # The newly indented lines.
---
local function _reposition_text(lines, extra_whitespace_to_add)
    local common_indent = _get_common_indent(lines)

    if not common_indent then
        vim.api.nvim_err_write(
            string.format(
                "Lines \""
                .. vim.inspect(lines)
                .. "\" could not be parsed for whitespace."
            )
        )

        return
    end

    local output = {}

    for _, line in ipairs(lines) do
        local line_ = line:gsub("^" .. common_indent, "")

        if line ~= "" then
            table.insert(output, extra_whitespace_to_add .. line_)
        else
            table.insert(output, line_)
        end
    end

    return output
end

vim.keymap.set(
    "n",
    "[p",
    function()
        local window = 0
        local buffer = 0
        local strict = true

        local row = vim.api.nvim_win_get_cursor(window)[1]
        local line = vim.api.nvim_buf_get_lines(buffer, row - 1, row, strict)[1]

        if not line then
            vim.api.nvim_err_write(
                "Something went wrong. No line was found. Cannot put text."
            )

            return
        end

        local whitespace = _get_leading_whitespace(line)
        local yanked_text = vim.fn.getreg('"')
        local next_text = _reposition_text(_split_lines(yanked_text), whitespace)

        local next_row = row - 1
        vim.api.nvim_buf_set_lines(buffer, next_row, next_row, strict, next_text)
        vim.api.nvim_win_set_cursor(window, {row, #whitespace})
    end,
    {desc="Paste to the line above, at the first non-whitespace character."}
)

vim.keymap.set(
    "n",
    "]p",
    function()
        local window = 0
        local buffer = 0
        local strict = true

        local row = vim.api.nvim_win_get_cursor(window)[1]
        local line = vim.api.nvim_buf_get_lines(buffer, row - 1, row, strict)[1]

        if not line then
            vim.api.nvim_err_write(
                "Something went wrong. No line was found. Cannot put text."
            )

            return
        end

        local whitespace = _get_leading_whitespace(line)
        local yanked_text = vim.fn.getreg('"')
        local next_text = _reposition_text(_split_lines(yanked_text), whitespace)

        -- NOTE: This line is a bit weird. Vim counts the start of the line so
        -- the next line is (confusingly) counted as if it were the same line.
        -- The "current" line is actually {line - 1, line}
        --
        -- Anyway, this `next_row` works, just roll with it.
        --
        local next_row = row
        vim.api.nvim_buf_set_lines(buffer, next_row, next_row, strict, next_text)
        vim.api.nvim_win_set_cursor(window, {row, #whitespace})
    end,
    {desc="Paste to the line below, at the first non-whitespace character."}
)
