--- A configuration for [nvim-lint](https://github.com/mfussenegger/nvim-lint).


--- Check if `executable` is findable.
---
---@param executable string The name of the runnable file. e.g. `"nvim"`.
---@return string? # The found executable name, if any.
---
local function _get(executable)
    if vim.fn.executable(executable) == 0 then
        -- TODO: Add logging
        return nil
    end

    return executable
end

local lint = require("lint")
lint.linters_by_ft = {
    python = { _get("pydocstyle"), _get("pylint"), _get("mypy") },
    lua = { _get("luacheck") },
}

-- NOTE: I seem to recall that there's plans to get the vim namespace to auto-complete and work with linting
-- Reference: https://www.reddit.com/r/lua/comments/lzpqqn/luacheck_ignore_warnings_for_one_variable_name/
lint.linters.luacheck.args = { "--globals", "vim" }

lint.linters.pydocstyle.args = { "--convention=google" }

lint.try_lint()
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        lint = require("lint")
        lint.try_lint()
    end,
})
