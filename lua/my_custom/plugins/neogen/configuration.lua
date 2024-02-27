require("neogen").setup(
    {
        languages = {
            python = {
                template = {
                    annotation_convention = "google_docstrings"
                }
            },
        },
        placeholders_hl = "String",
        snippet_engine = "luasnip",
    }
)

-- TODO: Not sure how useful Neogen is, in practice. Seems to break too easily.
vim.keymap.set(
    "n",
    "<leader>id",
    -- Note:
    --     Recompute folds with ``normal zx`` because (neo)vim
    --     never seems to generate folds properly whenever you make
    --     a command that makes folds from scratch.
    --
    function()
        local result = vim.fn.getpos(".")
        local current_row = result[2]
        local current_column = result[3]
        local first_non_empty_column = vim.fn.match(vim.fn.getline("."), "\\S")

        if first_non_empty_column == -1
        then
            first_non_empty_column = current_column
        end

        local current_window = 0

        -- Because Neogen uses nvim-treesitter and nvim-treesitter
        -- is cursor-column-aware, it may not think your cursor is
        -- inside of a function if it's too far left or right. So
        -- move it to a place where there Neogen will pick up the
        -- function context properly (the start of the function
        -- definition, which we **assume** is the first non-empty
        -- character in the current line).
        --
        vim.api.nvim_win_set_cursor(
            current_window,
            {current_row, first_non_empty_column}
        )
        -- Make the docstring
        vim.cmd[[:Neogen]]
        -- Recompute folds because (neo)vim breaks folds super often without it
        vim.cmd[[execute "normal zx"]]
    end,
    {
        desc="[i]nsert auto-[d]ocstring. Uses plug-ins to auto fill the docstring contents.",
        silent = true,
    }
)
