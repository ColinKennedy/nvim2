local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local index = luasnip.i
local snippet = luasnip.s

return {
    snippet(
        {
            docstring="Print the current stage",
            trig="ExportToString",
        },
        format(
            [[
                snippet ExportToString "Print the current stage"
                auto* result = new std::string();
                {}->GetRootLayer()->ExportToString(result);
                std::cout << *result << std::endl;
                delete result;
                result = nullptr;
                endsnippet
            ]],
            { index(1, "stage") }
        )
    )
}
