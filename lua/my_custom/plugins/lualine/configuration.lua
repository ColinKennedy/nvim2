local utils = require("lualine.utils.utils")

require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = "onedark",
        section_separators = { left = "", right = ""},
        component_separators = { left = '', right = ''},
    },
    sections = {
        lualine_b = {"branch"},
        lualine_c = { "grapple" },
        lualine_x = {},
        lualine_y = {
            {
                "diagnostics",
                diagnostics_color = {
                    -- TODO: These values go good with hybrid2. Maybe add lualine to the theme?
                    -- warn = 'DiagnosticWarning',
                    warn = {
                        fg = utils.extract_color_from_hllist(
                          { "fg", "sp" }, { "DiagnosticWarning" }, "#ffcc00"
                        ),
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
        },
        lualine_z = {"location"}
    },
}
