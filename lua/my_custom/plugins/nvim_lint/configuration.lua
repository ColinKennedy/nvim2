local mason_utility = require("my_custom.plugins.mason.utility")
mason_utility.add_bin_folder_to_path()

require("lint").linters_by_ft = {
    python = {"pydocstyle", "pylint", "mypy"},
    lua = {"luacheck"},
}

local lint = require("lint")
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
