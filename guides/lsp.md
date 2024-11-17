


## Old Virtual Text colors
```lua
vim.diagnostic.config(
    {
        virtual_text = {
            format = function(diagnostic)
                local cutoff = 20
                if #diagnostic.message > cutoff then
                    return diagnostic.message:sub(0, cutoff) .. "..."
                end

                return diagnostic.message
            end,
            prefix = function(diagnostic)
                if diagnostic.severity == vim.diagnostic.severity.ERROR then
                    return ""
                  elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                    return ""
                  elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                    return ""
                  elseif diagnostic.severity == vim.diagnostic.severity.HINT then
                    return ""
                  else
                    return "X"
                end
            end,
        }
    }
)
```

## A Built-In LSP For Snippets
https://www.reddit.com/r/neovim/comments/1g1x0v3/hacking_native_snippets_into_lsp_for_builtin/
