-- Important: According to lazy.nvim, the leader key must be set before lazy.nvim is
-- called or else it will break various things.
--
vim.g.mapleader = ","

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
    {
        "machakann/vim-highlightedyank",
        config = function()
            vim.g.highlightedyank_highlight_duration = 100
        end,
        event = "TextYankPost",
    },

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

    {
        "airblade/vim-gitgutter",
        config = function()
            vim.g.gitgutter_suppress_warnings = 1
            vim.g.gitgutter_max_signs = 2000
        end,
    },

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
    -- TODO: Check if lazy-loading can make this load faster
    --
    {
        "bradford-smith94/quick-scope",
        event = "BufFilePost",
        config = function()
            -- Stop quick-scope highlighting after 160 characters
            vim.g.qs_max_chars = 160

            vim.api.nvim_create_augroup("qs_colors", { clear = true })
            vim.api.nvim_create_autocmd(
                "ColorScheme",
                {
                    group = "qs_colors",
                    pattern = "*",
                    command = "highlight QuickScopePrimary guifg='#5fffff' gui=underline ctermfg=112 cterm=underline",
                }
            )
            vim.api.nvim_create_autocmd(
                "ColorScheme",
                {
                    group = "qs_colors",
                    pattern = "*",
                    command = "highlight QuickScopeSecondary guifg='#EAFF92' gui=underline ctermfg=140 cterm=underline",
                }
            )
        end
    },

    -- A syntax highlighter for in-line comments.
    {
        "ColinKennedy/vim-better-comments",
        ft = "python",
    },

    -- TODO: Check if lazy-loading can make this load faster
    { "romainl/vim-cool", event = "BufFilePost"},

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
        event = "BufFilePost",  -- TODO: Not sure if this actually helps
    },
    -- Extra, optional icons for ``nvim-lualine/lualine.nvim``
    {
        "kyazdani42/nvim-web-devicons",
        lazy = true,
    },


    -- Auto-sets Vim ``tabstop`` and ``shiftwidth``, based on the existing file's context
    "tpope/vim-sleuth",





    -- A tool which automatically backs up modified files to a git repository
    {
        "ColinKennedy/vim-git-backup",
    },

    -- Useful git commands. Such as :Gcd
    {
        "tpope/vim-fugitive",
        cmd = "Gcd",
    },








    -- TODO: Use a better lazy-load than this
    -- Use <leader>pd to get the Python dot-separated import path at the current cursor
    {
        "ColinKennedy/vim-python-dot-path",
        keys = "<leader>pd",
    },








    -- Quickfix helper functions
    -- TODO: Check if this works well with location lists, still
    {

        "romainl/vim-qf",
        ft = "qf",
    },
    
    -- Quickfix auto-resize. Keeps the quickfix window small
    {
        "blueyed/vim-qf_resize",
        ft = "qf",
    },










    -- Give vim some shell-like commands that it's missing
    {
        "tpope/vim-eunuch",
        cmd = {
            "Delete",
            "Mkdir",
            "Move",
            "Rename",
            "SudoEdit",
            "SudoWrite",
        }
    },

    {
        "junegunn/fzf",
        build=function()
            vim.cmd[[call fzf#install()]]
        end,
    },
    {
        "junegunn/fzf.vim",
        dependencies = { "junegunn/fzf" },
        cmd = {
            "Buffers",
            "Files",
            "GFiles",
            "History",
            "Lines",
        },
    },

    -- A more modern, faster grep engine.
    -- Requires https://github.com/BurntSushi/ripgrep to be installed
    --
    {
        "jremmen/vim-ripgrep",
        cmd = "Rg",
    },

    -- Autojump but for Vim. Use `:J` to change directories
    -- or `:Cd` as a replacement to `:cd`.
    --
    {
        "padde/jump.vim",
        cmd = {
            "J",
            "Jc",
            "Jo",
            "Jco",
        },
    },








    -- TODO: Check if I can do a delay-load (and also see if it makes loading faster)
    {
        "tomtom/tcomment_vim",
        keys = {"gc"},
    },
    
    -- REPEAT LAST (USER) COMMAND and makes the '.' command even cooler
    {
        "tpope/vim-repeat",
        keys = {"."},
    },

    -- Surround plugin. Lets you change stuff would words really easily
    {
        "tpope/vim-surround",
        keys = { "cs", "ds", "ys" },
    },

    -- Targets - A great companion to vim-surround
    {
        "wellle/targets.vim",
        config=function()
            -- TODO: Add this, later
            -- " Add `@` as a text object. di@ will delete between two @s. Useful for authoring USD!
            -- autocmd User targets#mappings#user call targets#mappings#extend({
            --     \ '@': {'quote': [{'d': '@'}]},
            --     \ })
        end,
    },

    -- Auto-insert pairs
    {
        "KaraMCC/vim-gemini",
        enabled = function()
            return vim.v.version >= 800
        end,
        config = function()
            vim.cmd("let g:gemini#match_list = {'.*': [['(', ')'], ['{', '}'], ['[', ']'], ['`', '`']], '.usda': [['@', '@']]}")
        end,
    },

    {
        "kana/vim-operator-replace",
        dependencies = { "kana/vim-operator-user" },
    },
    {
        "kana/vim-operator-user",
        dependencies = {
            "kana/vim-textobj-user",
        },
        lazy = true,
    },
    {
        "kana/vim-textobj-user",
        lazy = true,
    },

    -- Adds "aC" and "iC" to delete comment blocks. Awesome!
    {
        "ColinKennedy/vim-textobj-comment",
        dependencies = { "kana/vim-textobj-user" },
    },

    -- Lets you select inside indented blocks, using "ii"or "ai"
    -- ii = "the indented paragraph (stops at newlines)"
    -- ai = "the indented block (grabs the whole block)"
    --
    {
        "ColinKennedy/vim-indent-object",
        config=function()
            vim.g.indent_object_no_default_key_mappings = "1"
        end,
    },

    {
        "kana/vim-textobj-indent",
        config=function()
            vim.g.textobj_indent_no_default_key_mappings = "1"
        end,
        dependencies = { "kana/vim-textobj-user" },
    },


    -- Gives vim a few tools to navigate through indented blocks more easily
    {
        "jeetsukumaran/vim-indentwise",
        keys = {
            "[%",
            "[+",
            "[-",
            "[=",
            "[_",
            "]%",
            "]+",
            "]-",
            "]=",
            "]_",
        },
    },

    -- Advanced paragraph movement options - lets {}s skip folds with some
    -- minor customization.
    -- 
    {
        "justinmk/vim-ipmotion",
        config = function()
            vim.g.ip_skipfold = 1
        end,
        keys = {"{", "}"},
    },

    -- -- A text-object that helps you select Python source-code blocks
    {
        "ColinKennedy/vim-textobj-block-party",
        dependencies = { "kana/vim-textobj-user" },
    },

    -- Adds pair mappings (like ]l [l) to Vim
    "tpope/vim-unimpaired",

    -- A simple plugin that lets you grab inner parts of a variable
    --
    -- e.g. civqueez "foo_b|ar_fizz" -> foo_queez|_fizz
    -- e.g. dav "foo_b|ar_fizz" -> foo_fizz
    --
    {
        "Julian/vim-textobj-variable-segment",
        dependencies = { "kana/vim-textobj-user" },
    },

    -- Life-changing text object extension. It's hard to explain but ...
    --
    -- Use z[i} to move to the insert from the beginning of a paragraph.
    -- Use z]i} to move to the insert from the end of a paragraph.
    -- But you can do the do this with __any__ text object
    -- Also, you can use d]/d[ and c]/c[ to delete / change from other text objects
    --
    -- {"ColinKennedy/vim-ninja-feet", keys = {"d[", "d]"}},
    {
        "ColinKennedy/vim-ninja-feet",
        keys = {
            "c[",
            "c]",
            "d[",
            "d]",
            "p[",
            "p]",
            "s[",
            "s]",
            "z[",
            "z]",
        },
    },

    -- Adds `al/il` text objects for the current line
    {
        "kana/vim-textobj-line",
        dependencies = {
            "kana/vim-textobj-user",
        },
    },

    -- Exchange any two text objects with a new text-motion, `cx`
    {"tommcdo/vim-exchange", keys = {"cx"}},



















    -- TODO: Consider getting this stuff to work
    -- -- Treesitter stuff
    -- {
    --     "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    -- },
    -- {
    --     "nvim-treesitter/playground",
    --     cmd = "TSPlaygroundToggle",
    -- },
    },
    {
        root = "~/personal/.config/nvim/bundle",
    }
)

require("my_custom.remap")
require("my_custom.initialization")
require("my_custom.setting")

-- TODO: Make this a better file path, later
vim.cmd[[source ~/personal/.config/nvim/plugin/syntax_fix.vim]]
-- TODO: Make this a better file path, later
vim.cmd[[source ~/personal/.config/nvim/plugin/global_confirm.vim]]
-- TODO: Make this a better file path, later
vim.cmd[[source ~/personal/.config/nvim/plugin/miscellaneous_commands.vim]]
