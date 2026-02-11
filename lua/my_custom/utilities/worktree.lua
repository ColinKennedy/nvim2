local _P = {}
local M = {}

unpack = unpack or table.unpack -- NOTE: This is for compatibility with newer Lua versions.

function _P.get_git_root(directory)
    local root = vim.fs.root(directory, { ".git" })

    if root then
        return root
    end

    if vim.fn.filereadable(vim.fs.joinpath(directory, "HEAD")) == 1 then
        return directory
    end

    return nil
end


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

function _P.on_worktree_created(git_root, branch_directory)
    -- local destination_session_path = vim.fs.joinpath(branch_directory, "Session.vim")
    --
    -- local paths = {
    --     {
    --         vim.fs.joinpath(git_root, "Session.local.vim"),
    --         destination_session_path,
    --     },
    --     {
    --         vim.fs.joinpath(git_root, "Session.claude.vim"),
    --         vim.fs.joinpath(branch_directory, "Sessionx.vim"),
    --     },
    -- }
    --
    -- for _, pair in ipairs(paths) do
    --     local source, destination = unpack(pair)
    --
    --     if vim.fn.filereadable(source) == 0 then
    --         local success, error_ = _P.copy_file(source, destination)
    --
    --         if not success then
    --             vim.schedule(function()
    --                 vim.api.nvim_err_writeln(string.format('Path "%s" failed to copy to "%s". Error: %s', source, destination, error_))
    --             end)
    --
    --             return
    --         end
    --     end
    -- end

    vim.schedule(function()
        vim.cmd.tabnew()
        vim.cmd.tcd(vim.fn.fnameescape(branch_directory))

        _P.setup_session_details()
    end)
end

function _P.setup_session_details()
    -- NOTE: Requires: https://github.com/ColinKennedy/toggleterminal.nvim.git
    vim.cmd.ToggleTerminal()
    -- NOTE: Requires: https://github.com/coder/claudecode.nvim
    vim.cmd.ClaudeCode("--continue")
end

function M.create_worktree_tab(branch)
    local git_root = _P.get_git_root(vim.fn.getcwd())

    if not git_root then
        vim.api.nvim_err_writeln(string.format('Directory "%s" is not in a git repository.', current_directory))

        return
    end

    local branch_directory = vim.fs.joinpath(git_root, ".trees", branch)
    local command = { "git", "worktree", "add", branch_directory, "-b", branch }

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

        _P.on_worktree_created(git_root, branch_directory)
    end)
end

return M
