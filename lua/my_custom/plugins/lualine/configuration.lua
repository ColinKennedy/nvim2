local utils = require("lualine.utils.utils")

require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = "onedark",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
    },
    sections = {
        lualine_b = {
            {
                "gitstatus",
                sections = {
                    { "branch", format = " {}" },
                    { "is_dirty", format = "*" },
                },
                sep = "",
            },
            {
                "gitstatus",
                sections = {
                    { "ahead", format = "{}", hl = "DiffAdd" },
                    { "behind", format = "{}", hl = "WarningMsg" },
                    { "conflicted", format = "{} [CONFLICT]", hl = "ErrorMsg" },
                    { "staged", format = "{}", hl = "Title" },
                    { "modified", format = "{}", hl = "Type" },
                    { "renamed", format = "{}", hl = "Search" },
                    { "deleted", format = "󰮉{}", hl = "WarningMsg" },
                    { "untracked", format = "{}", hl = "DiagnosticHint" },
                },
                sep = " ",
            },
        },
        lualine_c = { { require("grapple-line").status } },
        lualine_x = {},
        lualine_y = {
            {
                "diagnostics",
                diagnostics_color = {
                    -- TODO: These values go good with hybrid2. Maybe add lualine to the theme?
                    -- warn = 'DiagnosticWarning',
                    warn = {
                        fg = utils.extract_color_from_hllist({ "fg", "sp" }, { "DiagnosticWarning" }, "#ffcc00"),
                    },
                },
                symbols = {
                    -- Reference: www.nerdfonts.com/cheat-sheet
                    error = " ",
                    warn = " ",
                    info = " ",
                    hint = " ",
                },
            },
            "progress",
            {
                "spellbound",
                fallback_profile = { text = "none" },
                profiles = {
                    strict = {
                        color = {
                            fg = utils.extract_color_from_hllist({ "fg", "sp" }, { "Title" }, "#ffcc00"),
                        },
                    },
                },
            },
        },
        lualine_z = { "location" },
    },
}
