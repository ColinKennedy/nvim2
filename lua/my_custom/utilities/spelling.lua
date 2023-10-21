--- A module for controlling Neovim's spelling features.
---
--- @module 'my_custom.utilities.spelling'
---

local M = {}

--- @return boolean # If Neovim is showing only limited words or all words
function M.in_strict_mode()
    return vim.tbl_contains(vim.split(vim.o.spelllang, ","), "en-strict")
end

return M
