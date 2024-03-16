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
            symbols = {
                -- Reference: www.nerdfonts.com/cheat-sheet
                error = " ",
                warn = "⚠ ",
                info = " ",
                hint = " ",
            },
        },
        "progress",
    },
    lualine_z = {"location"}
  },
}
