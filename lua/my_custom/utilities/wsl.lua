--- Check if in WSL (Windows Subsystem For Linux)
---
--- @module 'my_customl.utilities.wsl'
---

local M = {}

--- Read the first line from `path`.
---
--- @see https://superuser.com/a/1749792
---
--- @param path string An absolute path to a file on-disk.
--- @return string? # The found text, if any.
---
local function _read_line_from_path(path)
    if vim.fn.filereadable(path) ~= 1 then
        return nil
    end

    local handler = io.open(path, "r")

    if not handler then
        vim.api.nvim_err_writeln(string.format('Path "%s" was not readable.', path))

        return nil
    end

    local text = handler:read()

    handler:close()

    return text
end

--- Read the first line from the UNIX kernel.
---
--- @see https://superuser.com/a/1749792
---
--- @return string? # The found text, if any.
---
local function _read_from_kernel_os_release()
    local path = "/proc/sys/kernel/osrelease"

    return _read_line_from_path(path)
end

--- Read the first line from the proc version.
---
--- @see https://superuser.com/a/1749792
---
--- @return string? # The found text, if any.
---
local function _read_from_proc_version()
    local path = "/proc/version"

    return _read_line_from_path(path)
end

--- @return boolean # Check if Neovim is running from within WSL.
function M.in_wsl()
    -- Example text:
    --     Linux version 5.15.146.1-microsoft-standard-WSL2 (root@65c757a075e2)
    --     (gcc (GCC) 11.2.0, GNU ld (GNU Binutils) 2.37) #1 SMP Thu Jan 11 04:09:03 UTC 2024
    --
    local text = _read_from_proc_version()
    local pattern = ".*-microsoft-.*-WSL.*"

    if text then
        return text:match(pattern) ~= nil
    end

    -- Example text:
    --     5.15.146.1-microsoft-standard-WSL2
    --
    text = _read_from_kernel_os_release()

    if text then
        return text:match(pattern) ~= nil
    end

    return false
end

return M
