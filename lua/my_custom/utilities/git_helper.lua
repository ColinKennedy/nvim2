--- Miscellaneous functions for working with git.
---
--- @module 'my_custom.utiltiies.git_helper'
---

local M = {}

--- Find the top-level git repository from `directory`.
---
--- @param directory string?
---     An absolute path to a directory on-disk where a git repository is expected.
---     If no path is given, we reuse from `:echo getcwd()`.
--- @return string?
---     The found absolute directory, if any.
---
function M.get_git_root(directory)
    directory = directory or vim.fn.getcwd()

    local lines = vim.fn.systemlist(string.format("git -C %s rev-parse --show-toplevel", directory))
    local result = lines[1]

    if vim.fn.isdirectory(result) == 0 then
        return nil
    end

    return result
end

return M
