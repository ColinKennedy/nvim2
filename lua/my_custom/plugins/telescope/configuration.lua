local get_reasonable_bg = function(name)
    local type_colors = vim.api.nvim_get_hl(0, {name=name})

    return type_colors.bg or type_colors.fg
end

-- These colorscheme values are based on https://github.com/ColinKennedy/hybrid2.nvim
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", {bg=get_reasonable_bg("Comment"), fg="black"})
vim.api.nvim_set_hl(0, "TelescopePromptTitle", {bg=get_reasonable_bg("Search"), fg="black"})
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", {bg=get_reasonable_bg("Type"), fg="black"})

local hard_color = "#121212"
vim.api.nvim_set_hl(0, "TelescopeBorder", {bg=hard_color, fg=hard_color})
vim.api.nvim_set_hl(0, "TelescopeNormal", {bg=hard_color})

local background = "#252931"
vim.api.nvim_set_hl(0, "TelescopePromptCounter", {bg=background})
vim.api.nvim_set_hl(0, "TelescopePromptBorder", {bg=background, fg="#252931"})
vim.api.nvim_set_hl(0, "TelescopePromptNormal", {bg=background, fg="#abb2bf"})
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", {bg=background, fg="#e06c75"})

require("telescope").setup(
    { defaults={ prompt_prefix = "󰼛 ", selection_caret = "󱞩 " } }
)
