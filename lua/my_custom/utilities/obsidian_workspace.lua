--- Any miscellaneous function for handling Obsidian workspaces.

local obsidian_state = require("my_custom.utilities.obsidian_state")

local M = {}

--- Show a picker for changing the Obsidian vault workspace and select the workspace.
function M.set_workspace()
    local vault_root = obsidian_state.get_vaults_root_path()

    -- NOTE: The annotation is broken right now. See https://github.com/neovim/neovim/pull/37458
    --
    ---@diagnostic disable-next-line: param-type-mismatch
    local entries = vim.fn.readdir(vault_root, function(name)
        local full = vim.fs.joinpath(vault_root, name)

        if vim.fn.isdirectory(full) == 1 then
            return 1
        end

        return 0
    end)

    if vim.tbl_isempty(entries) then
        vim.notify(string.format('No vaults found in "%s" directory.', vault_root), vim.log.levels.WARN)

        return
    end

    table.sort(entries)

    vim.ui.select(entries, {
        prompt = "Select Obsidian workspace:",
    }, function(choice)
        if not choice then
            return
        end

        obsidian_state.set_workspace_name(choice)

        vim.notify("Obsidian workspace set to: " .. choice, vim.log.levels.INFO)
    end)
end

return M
