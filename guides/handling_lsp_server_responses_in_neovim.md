https://github.com/neovim/neovim/pull/26957#issuecomment-1885774765
```lua
---@param result lsp.DocumentDiagnosticReport
vim.lsp.handlers["textDocument/diagnostic"] = function(err, result, ctx, config)
  if result == nil -- an invalid response, should never be nil (see #26957)
    -- 1. fail early
    -- error("invalid textDocument/diagnostic response, result is nil")

    -- 2. treat as if an empty response
    result = { kind = "full", items = {} } --[[ @as lsp.FullDocumentDiagnosticReport ]]

    -- 3. or treat as if were an "unchanged" response
    -- result = { kind = "unchanged", resultId = "" } --[[ @as lsp.UnchangedDocumentDiagnosticReport ]]
  end
  return require('vim.lsp.diagnostic').on_diagnostic(err, result, ctx, config)
end
```
