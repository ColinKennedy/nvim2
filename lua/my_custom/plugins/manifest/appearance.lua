return {
    {
        "ColinKennedy/hybrid2.nvim",
        priority = 1000,  -- Load this first
        config = function()
            vim.cmd.colorscheme("hybrid2")
        end,
        version = "1.*"
    },

    {
        "romainl/vim-cool",
        init = function()
            require("my_custom.utilities.utility").lazy_load("vim-cool")
        end,
    },

    -- Shows added, removed, etc git hunks
    {
        "lewis6991/gitsigns.nvim",
        ft = "gitcommit",
        init = function()
            -- load gitsigns only when a git file is opened
            vim.api.nvim_create_autocmd(
                { "BufRead" },
                {
                    group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                    callback = function()
                        vim.fn.system("git -C " .. vim.fn.expand "%:p:h" .. " rev-parse")
                        if vim.v.shell_error == 0 then
                            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                            vim.schedule(function()
                                require("lazy").load { plugins = { "gitsigns.nvim" } }
                            end)
                        end
                    end
                }
            )
        end,
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "x" },
                untracked = { text = "" },
            },
        }
    },

    -- TODO: Add this later
    -- " Syntax highlighting for USD Ascii files
    -- " Plug 'superfunc/usda-syntax'
    --
    -- autocmd! FileType usda execute 'source ' . g:vim_home . '/bundle/usda-syntax/vim/usda.vim'
    --
    -- " A plugin that adds Prim type names to USD auto-complete results
    -- Plug 'https://korinkite@bitbucket.org/korinkite/vim-usd-complete-schemas.git'
    --
    -- " Note: It's technically wrong to load *.usdc with usda syntax. But if
    -- " the buffer was converted to ASCII then it's fine (which in my case, it is)
    -- "
    -- autocmd! BufRead,BufNewFile *.usd set filetype=usd
    -- autocmd! BufRead,BufNewFile *.usda set filetype=usda
    -- autocmd! BufRead,BufNewFile *.usdc set filetype=usd

    -- " A plugin that enables USD autocmd and syntax files
    -- Plug 'superfunc/usda-syntax', { 'for': ['usd', 'usda'] }

    -- Add a quick status bar plugin
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            require("my_custom.utilities.utility").lazy_load("lualine.nvim")
        end,
        opts = {
            options = {
                component_separators = { left = '', right = ''},
                icons_enabled = true,
                section_separators = { left = '', right = ''},
                theme = "onedark",
            },
            sections = {
                lualine_b = {
                    {
                        "diff",
                        colored = true,
                        diff_color = {
                            added = "DiffAdd",
                            removed = "DiffDelete",
                            modified = "DiffChange",
                        },
                    }
                }
            }
        }
    },

    -- Extra, optional icons for ``nvim-lualine/lualine.nvim``
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    -- " Enhanced markdown highlighting and syntax
    {
        "tpope/vim-markdown",
        ft = "markdown",
        config = function()
            vim.g.markdown_fenced_languages = {
                "bash=sh",
                "cpp",
                "js=javascript",
                "json",
                "lua",
                "php",
                "python",
                "sql",
                -- "usd=usda",  -- TODO: Add this, later
                -- "usda",  -- TODO: Add this, later
                "yaml",
            }
        end,
    }
}
