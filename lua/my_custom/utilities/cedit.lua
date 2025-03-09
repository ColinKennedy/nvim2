--- The implementation for `:CEdit`.


local M = {}

--- Save `:h autochdir`, run `caller`, and then restore it.
---
---@generic T : any
---@param caller fun(): T Some function to call and (hopefully) return.
---@return T? # The return value of `caller`, assuming it did not error.
---
local function _enable_autochdir(caller)
    local original = vim.o.autochdir
    vim.o.autochdir = true
    local success, result = pcall(caller)
    vim.o.autochdir = original

    if not success then
        vim.notify(result, vim.log.levels.ERROR)

        return nil
    end

    return result
end

--- Get the direct-parent directory of some `buffer` (assuming the buffer is a file).
---
---@param buffer integer? 0-or-more Vim data buffer number.
---@return string? # The found directory, if any.
---
local function _get_current_buffer_directory(buffer)
    buffer = buffer or vim.api.nvim_get_current_buf()

    local success, path = pcall(function() return vim.api.nvim_buf_get_name(buffer) end)

    if not success or path == "" then
        return nil
    end

    return vim.fn.fnamemodify(path, ":h")
end

--- Get the auto-completion options for a user's `text` relative file path.
---
---@param text string
---    Text that comes directly from the user's command-line mode. Usually it's
---    the start of a path on-disk.
---@return string[]?
---    All found auto-completion options, if any.
---
function M.complete_relative(text)
    local directory = _get_current_buffer_directory()

    if not directory then
        vim.cmd.edit(text)

        return nil
    end

    local options = _enable_autochdir(function()
        return vim.fn.getcompletion("edit ", "cmdline")
    end)

    ---@type string[]
    local output = {}

    for _, item in ipairs(options or {}) do
        if vim.startswith(item, text) then
            table.insert(output, item)
        end
    end

    return vim.fn.sort(output)
end

--- Open `text` relative path using the current directory as a root.
---
--- If the current buffer has no directory then this function is treated as
--- a normal `:edit` command.
---
---@param text string Some relative path. e.g. `"foo.txt"` or "../bar.txt"`, etc.
---
function M.open_relative(text)
    local directory = _get_current_buffer_directory()

    if not directory then
        vim.cmd.edit(text)

        return
    end

    vim.cmd.edit(vim.fs.normalize(vim.fs.joinpath(directory, text)))
end

return M
