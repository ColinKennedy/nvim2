--- Force-load all Lazy plugins at once.
---
--- We do this to confirm:
---
--- 1. That all of the plugins are present
--- 2. Validate that the plugins load as expected
--- 3. Fail CI if something went wrong
---

print("ALL SOURCED PATHS")
-- TODO: Remove this later
vim.cmd.scriptnames()

print("ALL RUNTIME PATHS")
print(table.concat(vim.opt.runtimepath:get(), "\n"))

vim.cmd("Lazy load all")
