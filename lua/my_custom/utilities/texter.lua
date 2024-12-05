--- Simple, common text operations.
---
---@module 'my_custom.utilities.texter'
---

local M = {}

--- Remove all leading whitespace from `text`.
---
---@param text string Some text that might have whitespace. e.g. `"  foo      "`.
---@return string # The same text, without the starting whitespace `"foo      "`.
---
function M.lstrip(text)
    return text:match("^%s*(.*)")
end

return M
