local M = {}

local _get_indent = function(node)
    local start_row, start_column, _, _ = node:range()

    local current = node:parent()

    while current ~= nil
    do
        local start_current_row, start_current_column, _, _ = current:range()

        if start_current_row ~= start_row
        then
            break
        end

        current = current:parent()
        start_column = math.min(start_column, start_current_column)
    end

    return string.rep("·", start_column)
end

function M.get_summary(start_line, end_line)
    buffer = 0
    column = 0

    local node = vim.treesitter.get_node({bufnr=buffer, pos={start_line, column}})
    local indent = _get_indent(node)
    local text = vim.treesitter.get_node_text(node, buffer)
    local left_stripped = string.gsub(text, "^%s+", "")
    local summary_line = left_stripped

    for line in left_stripped:gmatch("([^\n]*)\n?")
    do
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
