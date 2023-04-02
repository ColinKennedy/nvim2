return {
    packages = {
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

        -- TODO: Use a better lazy-load than this
        -- Use <leader>pd to get the Python dot-separated import path at the current cursor
        {
            "ColinKennedy/vim-python-dot-path",
            keys = "<leader>pd",
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

        -- REPEAT LAST (USER) COMMAND and makes the '.' command even cooler
        {
            "tpope/vim-repeat",
            keys = {"."},
        },

        -- A tool which automatically backs up modified files to a git repository
        {
            "ColinKennedy/vim-git-backup",
        },

        -- Useful git commands. Such as :Gcd
        {
            "tpope/vim-fugitive",
            cmd = "Gcd",
        },

        -- Auto-sets Vim ``tabstop`` and ``shiftwidth``, based on the existing file's context
        "tpope/vim-sleuth",

        -- Show all file edits as an tree
        {
            "mbbill/undotree",
            cmd = "UndotreeToggle",
        },

        -- Removes whitespace only on the lines you've changed. Pretty cool!
        {
            "ColinKennedy/vim-strip-trailing-whitespace",
            cmd = "StripTrailingWhitespace",
        },
    }
}
