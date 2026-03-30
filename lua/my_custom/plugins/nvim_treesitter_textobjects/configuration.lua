local installation_directory = vim.g.vim_home .. "/parsers/" .. vim.uv.os_uname().sysname

-- If you need to change the installation directory of the parsers (see
-- "Advanced Setup" in the nvim-treesitter documentation).
--
vim.opt.runtimepath:append(installation_directory)

local value = "V"

require("nvim-treesitter-textobjects").setup({
    move = {
        set_jumps = true,
    },

    select = {
        -- Important: This option has been changed so whitespace is retrieved more sensibly
        include_surrounding_whitespace = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
            ["@class.inner"] = value,
            ["@class.outer"] = value,
            ["@function.inner"] = value,
            ["@function.outer"] = value,
            ["@string.documentation"] = value,
        },
    },
})

do
    vim.keymap.set({ "x", "o" }, "ab", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects")
    end, { desc = "Delete the current if / for / try / while block." })

    vim.keymap.set({ "x", "o" }, "ad", function()
        -- luacheck: ignore 631
        -- Reference: https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/439#issuecomment-1505411083
        require("nvim-treesitter-textobjects.select").select_textobject("@string.documentation", "highlights")
    end, { desc = "Select around an entire docstring" })

    vim.keymap.set({ "x", "o" }, "id", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@documentation.inner", "textobjects")
    end, { desc = "Select the inside of a docstring" })

    vim.keymap.set({ "x", "o" }, "af", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
    end, { desc = "Select function + whitespace to the next function / class" })

    vim.keymap.set({ "x", "o" }, "if", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
    end, { desc = "Select function up to last source code line (no trailing whitespace)" })

    vim.keymap.set({ "x", "o" }, "aC", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
    end, { desc = "Select class + whitespace to the next class / class" })

    vim.keymap.set({ "x", "o" }, "iC", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
    end, { desc = "Select class up to last source code line (no trailing whitespace)" })
end

do
    vim.keymap.set({ "n", "x", "o" }, "]m", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "]k", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "]M", function()
        require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "]K", function()
        require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "[m", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "[k", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "[M", function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "[K", function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
    end)
end
