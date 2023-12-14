--- Allow saving git stashes.
---
--- @module 'my_custom.utilities.git_stash.saver'
---

local configuration = require("my_custom.utilities.git_stash.configuration")
local giter = require("my_custom.utilities.git_stash.giter")

local M = {}


--- Do a git stash, using `options`.
---
--- @param options any
---     Arbitrary data that controls where and how the git stash occurs. See
---     @module 'my_custom.utilities.git_stash.configuration' for details.
---
function M.push(options)
    options = options or {}

    local path = options.repository_path or configuration.get_default_repository_path()
    local silent = options.silent or configuration.is_saver_silent()

    if path == nil then
        vim.api.nvim_err_writeln(
            "No git path was given and could not be automatically found. Cannot continue."
        )

        return
    end

    giter.push_stash(path)

    if not silent then
        print('Stashed "' .. path .. '"')
    end
end


return M
