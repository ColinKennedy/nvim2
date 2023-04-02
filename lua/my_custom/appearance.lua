return {
    packages = {
        {
            "w0ng/vim-hybrid",
            -- TODO: Consider lazy-loading the colorscheme. If it improves start-time
            priority = 1000,  -- Load this first
            config = function()
                vim.cmd.colorscheme("hybrid")
            end,
        },

        -- TODO: Check if lazy-loading can make this load faster
        { "romainl/vim-cool", event = "BufFilePost"},

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
                vim.g.gitgutter_suppress_warnings = 1
                vim.g.gitgutter_max_signs = 2000
            end,
            event = { "CursorMoved", "CursorMovedI" },
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
                "kyazdani42/nvim-web-devicons",
            },
            config = function()
                require('lualine').setup {
                  options = {
                    theme = 'onedark',
                    component_separators = '|',
                    section_separators = '',
                  },
                }
            end,
            event = { "CursorMoved", "CursorMovedI" },
        },
        -- Extra, optional icons for ``nvim-lualine/lualine.nvim``
        {
            "kyazdani42/nvim-web-devicons",
            lazy = true,
        },

        -- TODO: Add this, later
        -- " Enhanced markdown highlighting and syntax
        -- Plug 'tpope/vim-markdown', { 'for': 'markdown' }
        -- let g:markdown_fenced_languages = [
        --     \ 'bash=sh',
        --     \ 'cpp',
        --     \ 'js=javascript',
        --     \ 'json',
        --     \ 'php',
        --     \ 'python',
        --     \ 'sql',
        --     \ 'usd=usda',
        --     \ 'usda',
        --     \ 'yaml',
        --     \ ]
    }
}
