return {
    {
        "w0ng/vim-hybrid",
        priority = 1000,  -- Load this first
        config = function()
            vim.cmd.colorscheme("hybrid")
        end,
    },

    {
        "romainl/vim-cool",
        init = function()
            require("my_custom.utilities.utility").lazy_load("vim-cool")
        end,
    },

    -- Whenever you highlight, there's a brief "blink" to show you what you highlighted
    {
        "machakann/vim-highlightedyank",
        config = function()
            vim.g.highlightedyank_highlight_duration = 100
        end,
        event = "TextYankPost",
    },
    -- GitGutter - Shows commits/unmodified text/etc
    {
        "airblade/vim-gitgutter",
        config = function()
            require("my_custom.plugins.data.vim_gitgutter")
        end,
        init = function()
            require("my_custom.utilities.utility").lazy_load("vim-gitgutter")
        end,
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
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup {
              options = {
                theme = "onedark",
                component_separators = "|",
                section_separators = "",
              },
            }
        end,
        init = function()
            require("my_custom.utilities.utility").lazy_load("lualine.nvim")
        end,
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
