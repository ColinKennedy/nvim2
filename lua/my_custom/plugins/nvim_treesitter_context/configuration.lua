local context = require("treesitter-context")

context.setup {
    on_attach = function(bufnr)
        local type_ = vim.bo[bufnr].filetype

        return type_ == "diff" or type_ == "usd" or type_ == "objdump"
    end,
}

-- Make the context background black
vim.api.nvim_set_hl(0, "TreesitterContext", { ctermbg = 16, bg = "#101010" })
