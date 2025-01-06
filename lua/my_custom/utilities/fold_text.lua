--- A custom fold text for Neovim. The default fold looks bad, this one is better.
---
---@module 'my_custom.utilities.fold_text'
---

local M = {}

--- Find the starting indentation of `node`.
---
---@param node TSNode A tree-sitter node that probably starts at a column that is > 1.
---@return string # The text used to indent the fold.
---
local function _get_indent(node)
    local start_row, start_column, _, _ = node:range()

    local current = node:parent()

    while current ~= nil do
        local start_current_row, start_current_column, _, _ = current:range()

        if start_current_row ~= start_row then
            break
        end

        current = current:parent()
        start_column = math.min(start_column, start_current_column)
    end

    return string.rep("·", start_column)
end

--- Summarize the lines between `start_line` and `end_line`.
---
--- Important:
---     This function is *inclusive* - both the start and end lines are
---     included in the fold.
---
---@param start_line number The first line to fold.
---@param end_line number The last line to fold.
---@return string # The text that will be used for the Vim fold.
---
function M.get_summary(start_line, end_line)
    local buffer = 0
    local column = 0

    local node = vim.treesitter.get_node({ bufnr = buffer, pos = { start_line, column } })

    if not node then
        return ""
    end

    local indent = _get_indent(node)
    local text = vim.treesitter.get_node_text(node, buffer)
    local left_stripped = string.gsub(text, "^%s+", "")
    local summary_line = left_stripped

    -- luacheck: ignore 512
    for line in left_stripped:gmatch("([^\n]*)\n?") do
        summary_line = line

        break
    end

    local stripped = string.gsub(summary_line, "%s+$", "")
    local line_count_text = "[" .. (end_line - start_line) .. " lines]"
    -- ``padding_count`` looks good with 88-limit lines
    local padding_count = 80 - (stripped:len() + line_count_text:len())
    local formatted = stripped .. string.rep("·", padding_count) .. line_count_text

    return indent .. "<" .. formatted .. ">"
end

return M
