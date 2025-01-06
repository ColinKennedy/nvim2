--- All Python snippets to make writing Qt easier.
---
---@module 'my_custom.snippets._python_qt'
---

local luasnip = require("luasnip")

local format = require("luasnip.extras.fmt").fmt
local index = luasnip.i
local is_line_beginning = require("my_custom.utilities.snippet_helper").is_source_beginning
local rep = require("luasnip.extras").rep
local snippet = luasnip.s
local snippet_helper = require("my_custom.utilities.snippet_helper")
local text = luasnip.t

return {
    snippet(
        {
            docstring = "A docstring auto-fill for a common Qt parameter",
            trig = "widgetparent",
        },
        text({
            "parent (Qt.QtCore.QObject, optional):",
            "    An object which, if provided, holds a reference to this instance.",
        }),
        { show_condition = snippet_helper.in_docstring }
    ),
    snippet(
        {
            docstring = "Enable tool-tips for QMenus.",
            trig = "enable_menu_tooltips",
        },
        format(
            -- luacheck: ignore 631
            [[
                if hasattr({}, "setToolTipsVisible"):
                    # Important: Requires Qt 6!
                    #
                    # Reference: https://doc.qt.io/qtforpython-6/PySide6/QtWidgets/QMenu.html#PySide6.QtWidgets.PySide6.QtWidgets.QMenu.setToolTipsVisible
                    #
                    {}.setToolTipsVisible(True)
            ]],
            {
                index(1, "menu"),
                rep(1),
            }
        ),
        { show_condition = is_line_beginning }
    ),
}
