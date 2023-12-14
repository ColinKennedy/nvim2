--- Interact with git and the filesystem more easily.
---
--- @module 'my_custom.utilities.git_stash.filer'
---

local M = {}


--- @return string? # Get the directory of the current buffer, if any.
function M.get_current_buffer_directory()
  return M.get_directory(vim.fn.expand("%:p"))
end


--- Find the nearest directory from `path`.
---
--- @param path string A file or directory path which may or may not exist on-disk.
--- @return string? # The directory path, if any.
---
function M.get_directory(path)
  if vim.fn.isdirectory(path) then
    return path or nil
  end

  return vim.fn.fnamemodify(path, ":h") or nil
end


--- @return string? # Neovim's current directory (not related to buffers), if any.
function M.get_pwd()
  local directory = vim.fn.getcwd()

  if vim.fn.isdirectory(directory) then
    return directory
  end

  return nil
end


return M
