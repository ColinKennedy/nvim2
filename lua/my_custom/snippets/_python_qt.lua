local luasnip = require("luasnip")
local snippet = luasnip.s
local text = luasnip.t

return {
    snippet(
        {
            docstring="A docstring auto-fill for a common Qt parameter",
            trig="widgetparent",
        },
        text(
            {
                "parent (Qt.QtCore.QObject, optional):",
                "    An object which, if provided, holds a reference to this instance."
            }
        )
    )
}
