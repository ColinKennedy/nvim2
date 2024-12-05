--- Simple, common text operations.
---
---@module 'my_custom.utilities.texter'
---

local M = {}

--- Check if `text` starts with whitespace.
---
---@param text string Some text. e.g. `"    foo"`.
---@return boolean # If there is whitespace, return `true`.
---
function M.has_leading_whitespace(text)
    return text:sub(1, 1) == " "
end

--- Remove all leading whitespace from `text`.
---
---@param text string Some text that might have whitespace. e.g. `"  foo      "`.
---@return string # The same text, without the starting whitespace `"foo      "`.
---
function M.lstrip(text)
    return text:match("^%s*(.*)")
end

return M
