local _suggest_a_color = function(highlight_group)
    local data = vim.api.nvim_get_hl_by_name(highlight_group, true)
    local foreground = data["foreground"]

    if foreground ~= nil
    then
        return foreground
    end

    return data["background"] or ""
end

local get_best_hex = function(highlight_group)
    local color = _suggest_a_color(highlight_group)

    if color ~= ""
    then
        return string.format("#%06x", color)
    end

    return "#428850"
end

require("nvim-web-devicons").set_icon {
    dapui_breakpoints = {
        icon = "",
        color = get_best_hex("Question"),
        -- cterm_color = "65",
        name = "dapui_breakpoints",
    },
    dapui_console = {
        icon = "",
        color = get_best_hex("Comment"),
        -- cterm_color = "65",
        name = "dapui_console",
    },
    ["dap-repl"] = {  -- By default, it is shown as bright white
        icon = "󱜽",
        -- cterm_color = "65",
        name = "dap_repl",
    },
    dapui_scopes = {
        icon = "󰓾",
        color = get_best_hex("Function"),
        -- cterm_color = "40",
        name = "dapui_scopes",
    },
    dapui_stacks = {
        icon = "",
        color = get_best_hex("Directory"),
        -- cterm_color = "65",
        name = "dapui_stacks",
    },
    dapui_watches = {
        icon = "󰂥",
        color = get_best_hex("Constant"),
        -- cterm_color = "65",
        name = "dapui_watches",
    },
}