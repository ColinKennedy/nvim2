-- Note: These colors look good with https://github.com/ColinKennedy/hybrid2.nvim
vim.api.nvim_set_hl(0, "SearchFG", {fg="#f0c674", ctermfg=222})
vim.api.nvim_set_hl(0, "DapUIDisassemblyHighlightLine", {link="SearchFG"})

require("dapui").setup()

vim.keymap.set(
    "n",
    "<F6>",
    function()
        require("dap").terminate()
        require("dapui").close()
    end,
    {desc="Close the DAP and the GUI."}
)

local _get_window_by_type = function(type_name)
    for _, data in pairs(vim.fn.getwininfo())
    do
        if vim.bo.filetype == type_name
        then
            return data
        end
    end

    return nil
end

local _zoom_by_type = function(type_name)
    local data = _get_window_by_type(type_name)

    if data == nil
    then
        print("No buffer could be found.")

        return
    end

    if vim.fn.exists("t:zoomwintab") == 1
    then
        -- The window is already zoomed in. Zoom out first
        vim.cmd[[ZoomWinTabOut]]

        if data.winnr == vim.fn.winnr()
        then
            -- Returning early effectively allows us to "toggle"
            -- the zoom mapping. e.g. Pressing ``<leader>dw`` zooms
            -- into the Watchers window. Pressing ``<leader>dw``
            -- again will "zoom out".
            --
            return
        end
    end

    vim.fn.win_gotoid(data.winid)

    vim.cmd[[ZoomWinTabToggle]]
end

local add_zoom_keymap = function(mapping, type_name)
    vim.keymap.set(
        "n",
        mapping,
        function()
            _zoom_by_type(type_name)
        end,
        {desc="Toggle-full-screen the " .. type_name .. " DAP window."}
    )
end

add_zoom_keymap("<leader>dc", "dapui_console")
add_zoom_keymap("<leader>dw", "dapui_watches")
add_zoom_keymap("<leader>ds", "dapui_scopes")
add_zoom_keymap("<leader>dt", "dapui_stacks")  -- dt as in s[t]acks
add_zoom_keymap("<leader>dr", "dap-repl")
