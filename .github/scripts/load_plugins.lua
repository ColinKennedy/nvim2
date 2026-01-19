--- Force-load all Lazy plugins at once.
---
--- We do this to confirm:
---
--- 1. That all of the plugins are present
--- 2. Validate that the plugins load as expected
--- 3. Fail CI if something went wrong
---

-- local caller_frame = debug.getinfo(2)
-- local current_file = caller_frame.source:match("@?(.*)")
-- local configuration = vim.fs.joinpath(vim.fs.dirname(vim.fs.dirname(current_file)), "init.lua")
-- TODO: get this path dynamically
local configuration = vim.fs.joinpath("nvim", "init.lua")

vim.cmd.source(configuration)
-- TODO: Remove this later
vim.cmd.scriptnames()

print("ALL RUNTIME PATHS")
print(table.concat(vim.opt.runtimepath:get(), "\n"))

vim.cmd("Lazy load all")
