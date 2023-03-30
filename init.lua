
require("my_custom.remap")
require("my_custom.setting")
require("my_custom.mapping")


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        }
    )
end

vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    {
        "w0ng/vim-hybrid",
        -- TODO: Consider lazy-loading the colorscheme. If it improves start-time
        lazy = false,
        priority = 1000,  -- Load this first
        config = function()
            vim.cmd.colorscheme("hybrid")
        end,
    },



    -- Show all file edits as an tree
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
    },

    -- Whenever you highlight, there's a brief "blink" to show you what you highlighted
    "machakann/vim-highlightedyank",

    -- Removes whitespace only on the lines you've changed. Pretty cool!
    {
        "ColinKennedy/vim-strip-trailing-whitespace",
        cmd = "StripTrailingWhitespace",
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

    -- GitGutter - Shows commits/unmodified text/etc
    "airblade/vim-gitgutter",

    -- A plugin that highlights the character to move to a word or WORD with f/t
    --
    -- Note:
    --     The original repo, unblevable/quick-scope, has been dead for a while
    --     bradford-smith94 has been added as a maintainer so hopefully the repo
    --     will get some action but, for now, use his fork
    --
    -- Reference:
    --     https://github.com/unblevable/quick-scope/issues/38
    --
    "bradford-smith94/quick-scope",

    -- A syntax highlighter for in-line comments.
    {
        "ColinKennedy/vim-better-comments",
        ft = "python",
    },

    -- TODO: Check if lazy-loading can make this load faster
    "romainl/vim-cool",

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
        dep = {
            "kyazdani42/nvim-web-devicons",
        },
    },
    -- Extra, optional icons for ``nvim-lualine/lualine.nvim``
    {
        "kyazdani42/nvim-web-devicons",
        lazy = true,
    },


    -- Auto-sets Vim ``tabstop`` and ``shiftwidth``, based on the existing file's context
    "tpope/vim-sleuth",




    {
        "tpope/vim-fugitive",
        cmd = "Gcd",
    },

    -- TODO: Consider getting this stuff to work
    -- -- Treesitter stuff
    -- {
    --     "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    -- },
    -- {
    --     "nvim-treesitter/playground",
    --     cmd = "TSPlaygroundToggle",
    -- },
})
