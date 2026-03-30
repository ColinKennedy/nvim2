--- A series of functions to make dealing with git worktrees + Claude Code easier.

local _P = {}
local M = {}

unpack = unpack or table.unpack -- NOTE: This is for compatibility with newer Lua versions.

--- Find the top-most bare git repository.
---
--- If you have git repository within a git repository, find the top-most one.
---
---@param directory string Some subdirectory to start searching from.
---@return string? # The found git bare repository root, if any.
---
function _P.get_bare_git_root(directory)
    local previous = nil
    local current = directory

    while current and current ~= previous do
        if vim.fn.filereadable(vim.fs.joinpath(current, "HEAD")) == 1 then
            return current
        end

        previous = current
        current = vim.fs.dirname(current)
    end

    return nil
end


--- Copy `source` file to `destination`.
---
---@param source string
---    A file on-disk to copy.
---@param destination string
---    The path on-disk to create or replace. If any
---    parent directories of `destination` don't exist, they are created.
---@return boolean
---    If the file could be copied, return `true`.
---@return string?
---    An error message, if any. (If the file copied, this is empty).
---
function _P.copy_file(source, destination_path)
    local source_handle = io.open(source, "r")

    if not source_handle then
        return false, "Failed to open source file: " .. source
    end

    local content = source_handle:read("*a")
    source_handle:close()

    local destination_directory = vim.fs.dirname(destination_path)

    if vim.fn.isdirectory(destination_directory) == 0 then
        vim.fn.mkdir(destination_directory, "p")
    end

    local destination_handle = io.open(destination_path, "w")

    if not destination_handle then
        return false, "Failed to open destination file: " .. destination_path
    end

    destination_handle:write(content)
    destination_handle:close()

    return true, nil
end

--- Make a new tab to display the worktree.
---
---@param directory string The worktree to view in the new tab.
---
function _P.on_worktree_created(directory)
    vim.schedule(function()
        vim.cmd.tabnew()
        vim.cmd(string.format("silent tcd %s", directory))

        _P.setup_session_details()
    end)
end

--- Make a terminal at the bottom and a Claude Code instance on the right.
function _P.setup_session_details()
    -- NOTE: Requires: https://github.com/ColinKennedy/toggleterminal.nvim.git
    local window = vim.api.nvim_get_current_win()
    vim.cmd.ToggleTerminal()

    -- NOTE: `ToggleTerminal` changes the cursor's active window, this sets it back.
    vim.api.nvim_set_current_win(window)

    -- NOTE: Requires: https://github.com/coder/claudecode.nvim
    local success, error_ = pcall(function() vim.cmd.ClaudeCode("/continue") end)

    if not success then
        vim.schedule(
            function()
                vim.api.nvim_err_writeln(
                    'claudecode.nvim is not installed. Cannot call --continue.'
                )
            end
        )

        return
    end
end

--- Make a new git worktree named `branch_name`
---
---@param branch_name string The name of the git worktree to create.
---
function M.create_worktree_tab(branch_name)
    local current_directory = vim.fn.getcwd()
    local git_root = _P.get_bare_git_root(current_directory)

    if not git_root then
        vim.api.nvim_err_writeln(string.format('Directory "%s" is not in a git repository.', current_directory))

        return
    end

    local branch_directory = vim.fs.joinpath(git_root, ".trees", branch_name)
    local command = { "git", "worktree", "add", "-b", branch_name, branch_directory }

    vim.system(command, {
        cwd = git_root,
        text = true,
    }, function(result)
        if result.code ~= 0 then
            vim.schedule(function()
                vim.api.nvim_err_writeln(
                    string.format('Git worktree command "%s" failed: %s', command, (result.stderr or "<Unknown error>"))
                )
            end)

            return
        end

        _P.on_worktree_created(vim.fn.fnameescape(branch_directory))
    end)
end

return M
