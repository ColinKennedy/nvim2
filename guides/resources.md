## Possibly useful libraries to check out later
Auto-format Python docstrings to fix them

https://github.com/DanielNoord/pydocstringformatter

Find dead Python code

https://github.com/jendrikseipp/vulture


Auto-add ()s around functions and methods
Note: I think I already do this. So I could remove this
- https://github.com/hrsh7th/nvim-cmp/wiki/Advanced-techniques#add-parentheses-after-selecting-function-or-method-item

Auto-refactoring (based on tree-sitter)
- https://github.com/ThePrimeagen/refactoring.nvim


- Maybe consider this. I'm mostly happy with my mappings but could be something there - https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping

https://andrewwegner.com/find-broken-links-with-github-actions.html


This post shows how to enable OSC52 in Neovim: https://marceloborges.dev/posts/3/

In short:
```lua
vim.o.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
    local copy_to_unnamedplus = require("vim.ui.clipboard.osc52").copy("+")
    copy_to_unnamedplus(vim.v.event.regcontents)
    local copy_to_unnamed = require("vim.ui.clipboard.osc52").copy("*")
    copy_to_unnamed(vim.v.event.regcontents)
  end,
})
```
