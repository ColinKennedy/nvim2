--- Force-load all Lazy plugins at once.
---
--- We do this to confirm:
---
--- 1. That all of the plugins are present
--- 2. Validate that the plugins load as expected
--- 3. Fail CI if something went wrong
---

vim.cmd("Lazy load all")
