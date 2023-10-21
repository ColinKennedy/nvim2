local function _get_quickfix_item_path(current_item)
    if current_item.bufnr >= 1 then
        return vim.api.nvim_buf_get_name(current_item.bufnr)
    end

    return current_item.module or ""
end

local function next_quickfix_entry()
    local index = vim.fn.getqflist({ idx = 0 }).idx
    local items = vim.fn.getqflist()
    local next_item = items[index + 1]

    if not next_item then
        vim.cmd.cfirst()
        print("Looped back to the start")

        return
    end

    local current_item = items[index]
    local current_path = _get_quickfix_item_path(current_item)
    local next_path = _get_quickfix_item_path(next_item)

    if current_path == next_path then
        local success, _ = pcall(vim.cmd.cbelow)

        if not success then
            vim.cmd.cnext()
        end
    else
        vim.cmd.cnext()
    end
end

local function previous_quickfix_entry()
    local index = vim.fn.getqflist({ idx = 0 }).idx
    local items = vim.fn.getqflist()
    local next_item = items[index - 1]

    if not next_item then
        vim.cmd.clast()
        print("Looped back to the end")

        return
    end

    local current_item = items[index]
    local current_path = _get_quickfix_item_path(current_item)
    local next_path = _get_quickfix_item_path(next_item)

    if current_path == next_path then
        local success, _ = pcall(vim.cmd.cabove)

        if not success then
            vim.cmd.cprevious()
        end
    else
        vim.cmd.cprevious()
    end
end

return {
    { "<P", desc = "Do [p]ut, but dedented onto the previous line." },
    { ">P", desc = "Do [p]ut, but indented onto the previous line." },
    { "<p", desc = "Do [p]ut, but dedented onto the next line." },
    { ">p", desc = "Do [p]ut, but indented onto the next line." },
    -- "=P", "=p", -- equal indentation put
    { "[<Space>", desc = "Add a newline above the current line." },
    { "]<Space>", desc = "Add a newline below the current line." },
    { "[A", desc = "Go to the first [A]rgs." },
    { "]A", desc = "Go to the last [A]rgs." },
    { "[B", desc = "Go to the first [B]uffer." },
    { "]B", desc = "Go to the last [B]uffer." },
    { "[L", desc = "Go to the first [L]ocation list entry." },
    { "]L", desc = "Go to the last [L]ocation list entry." },
    { "[Q", desc = "Go to the first [Q]uickfix entry." },
    { "]Q", desc = "Go to the last [Q]uickfix entry." },
    { "[T", desc = "Go to the first tag." },
    { "]T", desc = "Go to the last tag." },
    { "[a", desc = "Go to the previous [a]rgs." },
    { "]a", desc = "Go to the next [a]rgs." },
    { "[b", desc = "Go to the previous [b]uffer." },
    { "]b", desc = "Go to the next [b]uffer." },
    { "[p", desc = "Do [p]ut to the previous line." },
    { "]p", desc = "Do [p]ut to the next line." },
    -- "[t", "]t",  tags
    {
        "[q",
        previous_quickfix_entry,
        desc = "Move up the [q]uickfix window.",
    },
    {
        "]q",
        next_quickfix_entry,
        desc = "Move down the [q]uickfix window.",
    },
    {
        "[l",
        function()
            local fixer = require("my_custom.utilities.quick_fix_selection_fix")
            fixer.safe_run([[LAbove]])
        end,
        desc = "Move up the [l]ocation list window.",
    },
    {
        "]l",
        function()
            local fixer = require("my_custom.utilities.quick_fix_selection_fix")
            fixer.safe_run([[LBelow]])
        end,
        desc = "Move down the [l]ocation list window.",
    },
}
