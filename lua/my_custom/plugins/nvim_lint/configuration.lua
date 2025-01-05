local lint = require("lint")
lint.linters_by_ft = {
    python = {"pydocstyle", "pylint", "mypy"},
    lua = {"luacheck"},
}

-- NOTE: I seem to recall that there's plans to get the vim namespace to auto-complete and work with linting
-- Reference: https://www.reddit.com/r/lua/comments/lzpqqn/luacheck_ignore_warnings_for_one_variable_name/
lint.linters.luacheck.args = {"--globals", "vim"}

lint.linters.pydocstyle.args = { "--convention=google" }

lint.try_lint()
vim.api.nvim_create_autocmd(
    { "BufWritePost" },
    {
        callback = function()
            lint = require("lint")
            lint.try_lint()
        end
    }
)
