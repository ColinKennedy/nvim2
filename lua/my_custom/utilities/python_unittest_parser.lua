--- Parse a Python unittest's error output.
---
--- @module 'my_custom.utilities.python_unittest_parser'
---

local M = {}

--- Convert a unittest path into Python's dot.separated.namespace equivalent.
---
--- @param text string Some unittest text. e.g. `"FAIL: test_boo (tests.test_foo.Bar)"`.
--- @return string? # The found dot-path, if any
---
local function _get_dot_path(text)
    local pattern = "[^%s]+:%s*([%w_]+)%s*%(([^%)]+)%)"
    local name, parent = text:match(pattern)

    if not name then
        return nil
    end

    return string.format("%s.%s", parent, name)
end


--- Parse a Python unittest's error output into your current clipboard.
function M.copy_current_line_unittest_to_clipboard()
    local line = vim.fn.getline(".")
    local text = _get_dot_path(line)

    if not text then
        vim.notify(string.format('Line "%s" has no match.', line), vim.log.levels.ERROR)

        return
    end

    vim.fn.setreg("+", text)
    vim.notify(string.format('Text "%s" was copied.', text), vim.log.levels.INFO)
end

return M
