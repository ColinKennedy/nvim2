require("winbar").setup(
    {
        enabled = true,

        show_file_path = true,
        show_symbols = true,

        colors = {
            path = "", -- You can customize colors like #c946fd
            file_name = "",
            symbols = "",
        },

        icons = {
            file_icon_default = "",
            seperator = ">",
            editor_state = "●",
            lock_icon = "",
        },

        exclude_filetype = {
            -- Built-in windows
            "help",

            "",  -- Neovim terminals have no filetype. Disable terminals.
            "NvimTree",  -- nvim-tree/nvim-tree.lua

            -- Extras
            "Outline",
            "Trouble",
            "alpha",
            "dashboard",
            "lir",
            "neogitstatus",
            "packer",
            "spectre_panel",
            "startify",
            "toggleterm",

        }
    }
)
