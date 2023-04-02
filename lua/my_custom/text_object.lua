return {
    packages = {
        -- Adds `al/il` text objects for the current line
        {
            "kana/vim-textobj-line",
            dependencies = { "kana/vim-textobj-user" }
        },

        -- Surround plugin. Lets you change stuff would words really easily
        {
            "tpope/vim-surround",
            keys = { "cs", "ds", "ys" },
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
            "tomtom/tcomment_vim",
        },
        {
            "kana/vim-textobj-user",
            lazy = true,
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


        -- Adds "aC" and "iC" to delete comment blocks. Awesome!
        {
            "ColinKennedy/vim-textobj-comment",
            dependencies = { "kana/vim-textobj-user" },
            keys = {"gc"},
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
        {
            "tpope/vim-unimpaired",
            keys = {
                "[A",
                "[B",
                "[L",
                "[Q",
                "[T",
                "[a",
                "[b",
                "[l",
                "[q",
                "[t",
                "]A",
                "]B",
                "]L",
                "]Q",
                "]T",
                "]a",
                "]b",
                "]l",
                "]q",
                "]t",
            },
        },

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

        -- Exchange any two text objects with a new text-motion, `cx`
        {"tommcdo/vim-exchange", keys = {"cx"}},
    },
}
