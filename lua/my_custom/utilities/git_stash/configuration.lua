--- Customize the runtime behavior of the "save a git stash" code.
---
--- @module 'my_custom.utilities.git_stash.configuration'
---

local filer = require("my_custom.utilities.git_stash.filer")

local _CONFIGURATION = {
    git = {
        fallbacks = {
            filer.get_pwd,
            filer.get_current_buffer_directory,
        },
    },
    saver = {
        silent = false,
    },
}

local M = {}

--- Check if saving a stash should be silent or print to Neovim's command-line.
---
--- @return boolean # If `true`, allow printed messages.
---
function M.is_saver_silent()
    return _CONFIGURATION.saver.silent
end

--- Find the path on-disk where the git repository should exist.
---
--- Note:
---     The found directory is only guaranteed to be in a git repository. It is
---     not the git repository root.
---
--- @return string? # The found git repository path, if any.
---
function M.get_default_repository_path()
    for _, caller in ipairs(_CONFIGURATION.git.fallbacks or {}) do
        local directory = caller()

        if directory ~= nil then
            return directory
        end
    end

    return nil
end

return M
