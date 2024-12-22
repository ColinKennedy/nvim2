--- Make Neovim visual selections easier to handler.
---
---@module 'my_custom.utilities.selector'
---

local M = {}

--- @alias _CursorRange table<integer, integer>
---     Two values, both 1-or-more, indicating the start and end line of a text block.

    return M.get_visual_lines()
---@return _CursorRange # Get the start/end lines of a visual selection.
function M.get_visual_lines()
    local _, start_line, _, _ = unpack(vim.fn.getpos("v"))
    local _, end_line, _, _ = unpack(vim.fn.getpos("."))

    if start_line > end_line
    then
        start_line, end_line = end_line, start_line
    end

    return {start_line, end_line}
end

return M
