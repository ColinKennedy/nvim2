--- A quick workspace-switcher to make creating Obsidian notes easier.

local M = {}

local _ROOT = vim.fs.joinpath(vim.fn.expand("~"), "vaults")
local _CURRENT_WORKSPACE = "politics"

---@return string The absolute path Obsidian vault workspaces.
function M.get_vaults_root_path()
    return _ROOT
end

---@return string The absolute path to the current Obsidian vault workspace.
function M.get_workspace_path()
    return vim.fs.joinpath(_ROOT, _CURRENT_WORKSPACE)
end

--- Remember `name` so that new Obsidian notes will write to this location.
---
---@param name string The vault name to save new notes to.
---
function M.set_workspace_name(name)
    _CURRENT_WORKSPACE = name
end

return M
