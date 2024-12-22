--- Make Neovim visual selections easier to handler.
---
---@module 'my_custom.utilities.selector'
---

local M = {}

--- @alias _CursorRange table<integer, integer>
---     Two values, both 1-or-more, indicating the start and end line of a text block.

---@return _CursorRange? # Get the start/end lines of a visual selection, if in visual mode.
function M.get_current_mode_visual_lines()
    if not vim.tbl_contains({
        "v",
        "vs",
        "V",
        "Vs",
        "CTRL-V",
        "CTRL-Vs",
        "s",
        "S",
        "CTRL-S",
    }, vim.fn.mode()
    )
    then
        return nil
    end

    return M.get_visual_lines()
end

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
