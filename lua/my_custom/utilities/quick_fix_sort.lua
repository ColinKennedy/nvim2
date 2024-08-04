--- Numerically and alphabetically sort the quick-fix list.
---
--- @module 'my_custom.utilities.quick_fix_sort'
---

local M = {}

--- Numerically and alphabetically sort the quick-fix list.
function M.sort_quick_fix()
    local list = vim.fn.getqflist()

    table.sort(
        list,
        function(left, right)
            local left_buffer = vim.fn.bufname(left.bufnr)
            local right_buffer = vim.fn.bufname(right.bufnr)

            if left_buffer < right_buffer then
                return true
            end

            if left_buffer > right_buffer then
                return false
            end

            if left.lnum < right.lnum then
                return true
            end

            if left.lnum > right.lnum then
                return false
            end

            if left.col < right.col then
                return true
            end

            if left.text < right.text then
                return true
            end

            if left.text > right.text then
                return false
            end

            return false
        end
    )

    vim.fn.setqflist(list)
end

return M
