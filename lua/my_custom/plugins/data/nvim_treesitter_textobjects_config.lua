local installation_directory = vim.g.vim_home .. "/parsers/" .. vim.loop.os_uname().sysname

-- If you need to change the installation directory of the parsers (see
-- "Advanced Setup" in the nvim-treesitter documentation).
--
vim.opt.runtimepath:append(installation_directory)


local value = "V"

require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "diff",
        "usd",
        "python",
        -- "vim",  -- Note: This currently errors on-install during compiling. Not sure why.
        "vimdoc",
        "query",
    },
    parser_install_dir = installation_directory,
    highlight = {
        -- Reference: https://github.com/nvim-treesitter/nvim-treesitter/pull/3570
        --
        -- Disable slow highlights for large files. Not sure if this truly needed.
        --
        disable = function(lang, buf)
            local max_filesize = 120 * 1024 -- 120 KB. About 3300 lines of Python. ish.
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        enable = true,
    },
    indent = {
        enable = true,
        -- I'm preferring to use the ``Vimjas/vim-python-pep8-indent``
        -- plug-in until the treesitter plugin is fixed.
        --
        -- Reference: https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
        --
        disable = {"cpp"},
    },


    textobjects = {
        -- TODO: Not working, fix
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]k"] = "@class.outer",
            -- ["]m"] = "@function.outer",  -- TODO: Add again once speed improves
          },
          goto_next_end = {
            ["]K"] = "@class.outer",
            ["]M"] = "@function.outer",
          },
          goto_previous_start = {
            ["[k"] = "@class.outer",
            -- ["[m"] = "@function.outer",  -- TODO: Add again once speed improves
          },
          goto_previous_end = {
            ["[K"] = "@class.outer",
            ["[M"] = "@function.outer",
          },
        },

        select = {
            -- Important: This option has been changed so whitespace is retrieved more sensibly
            --
            -- Reference: https://github.com/ColinKennedy/nvim-treesitter-textobjects/tree/modified_include_surrounding_whitespace_behavior
            --
            include_surrounding_whitespace = true,

            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                ["ab"] = {
                    desc = "Delete the current if / for / try / while block.",
                    query = "@block.outer",
                },

                ["ad"] = {
                    -- Reference: https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/439#issuecomment-1505411083
                    desc = "Select around an entire docstring",
                    query = "@string.documentation",
                    query_group = "highlights",
                },
                -- TODO: Add ``did`` support
                -- Requires:
                --
                -- (
                --   (function_definition
                --     (block
                --       .
                --       (expression_statement
                --         (string (string_content) @documentation.inner)) @documentation.outer
                --     )
                --   )
                -- )
                --
                ["id"] = {
                    desc = "Select the inside of a docstring",
                    query = "@documentation.inner",
                },

                ["af"] = {
                    desc = "Select function + whitespace to the next function / class",
                    query = "@function.outer",
                },
                ["if"] = {
                    desc = "Select function up to last source code line (no trailing whitespace)",
                    query = "@function.inner",
                },

                -- Note: I use aC / iC (capital C) so that I can use ac / ic
                -- for ``glts/vim-textobj-comment``, which is a much more
                -- common case.
                --
                ["aC"] = {
                    desc = "Select class + whitespace to the next class / class",
                    query = "@class.outer",
                },
                ["iC"] = {
                    desc = "Select class up to last source code line (no trailing whitespace)",
                    query = "@class.inner",
                },
            },
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
    },
}
