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
        function()
            local fixer = require("my_custom.utilities.quick_fix_selection_fix")

            fixer.choose_last_window()
            fixer.safe_run([[CAbove]])
        end,
        desc="Move up the [q]uickfix window.",
    },
    {
        "]q",
        function()
            local fixer = require("my_custom.utilities.quick_fix_selection_fix")

            fixer.choose_last_window()
            fixer.safe_run([[CBelow]])
        end,
        desc="Move down the [q]uickfix window.",
    },
    {
        "[l",
        function()
            local fixer = require("my_custom.utilities.quick_fix_selection_fix")
            fixer.safe_run([[LAbove]])
        end,
        desc="Move up the [l]ocation list window.",
    },
    {
        "]l",
        function()
            local fixer = require("my_custom.utilities.quick_fix_selection_fix")
            fixer.safe_run([[LBelow]])
        end,
        desc="Move down the [l]ocation list window.",
    },
}
