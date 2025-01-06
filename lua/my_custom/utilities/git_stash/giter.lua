--- Some functions to make working with the `git` CLI easier.
---
---@module 'my_custom.utilities.git_stash.giter'
---

local shell = require("my_custom.utilities.git_stash.shell")

local M = {}

--- Stash any uncommitted git changes at `directory`.
---
--- Warning:
---     Calling this function will modify the state of your git repository.
---
---@param directory string A folder on-disk within some git repository.
---
local function _create_git_stash(directory)
    local command = "git stash"

    ---@type string[]
    local stderr = {}
    local result = shell.run_command(command, {
        cwd = directory,
        on_stderr = function(_, data, _)
            for _, line in ipairs(data) do
                table.insert(stderr, line)
            end
        end,
    })

    if not result then
        vim.api.nvim_err_writeln('git stash stderr: "' .. vim.inspect(stderr) .. '"')
    end
end

--- Stash any uncommitted git changes at `directory` under a specific `name`.
---
--- Warning:
---     Calling this function will modify the state of your git repository.
---
---@param name string A description to save with the git stash.
---@param directory string A folder on-disk within some git repository.
---
local function _push_named_git_stash(name, directory)
    local command = 'git stash push -m "' .. name .. '"'

    ---@type string[]
    local stderr = {}
    local result = shell.run_command(command, {
        cwd = directory,
        on_stderr = function(_, data, _)
            for _, line in ipairs(data) do
                table.insert(stderr, line)
            end
        end,
    })

    if not result then
        vim.api.nvim_err_writeln('git named stash stderr: "' .. vim.inspect(stderr) .. '"')
    end
end

--- Find any previously-saved git stashes at `directory`.
---
---@param directory string A folder on-disk within some git repository.
---@return string[]? # The found git stashes, if any.
---
function M.get_stashes(directory)
    ---@type string[]
    local stderr = {}
    ---@type string[]
    local stdout = {}

    local result = shell.run_command("git stash list --format='%gd: %gs'", {
        cwd = directory,
        on_stderr = function(_, data, _)
            for _, line in ipairs(data) do
                table.insert(stderr, line)
            end
        end,
        on_stdout = function(_, data, _)
            for _, line in ipairs(data) do
                table.insert(stdout, line)
            end
        end,
    })

    if not result then
        vim.api.nvim_err_writeln('git stash stderr: "' .. vim.inspect(stderr) .. '"')

        return nil
    end

    ---@type string[]
    local output = {}

    for _, line in ipairs(stdout) do
        if line ~= "" then
            -- Sometimes the stdout gets empty lines. We filter them out, here
            table.insert(output, line)
        end
    end

    return output
end

--- Prompt the user for a git stash and then stash any uncommitted git changes.
---
--- Warning:
---     Calling this function will modify the state of your git repository.
---
---@param directory string A folder on-disk within some git repository.
---
function M.push_stash(directory)
    local name = vim.fn.input("Stash Name (default=empty): ")

    -- Add newline for any follow-up print-outs. Why does Neovim not clear after
    -- input() is called, I don't know
    --
    print("\n")

    if name == "" then
        _create_git_stash(directory)
    else
        _push_named_git_stash(name, directory)
    end
end

return M
