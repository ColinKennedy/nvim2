local common_snippet = require("my_custom.snippets._common_snippet")
local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local repeat_ = require("luasnip.extras").rep
local index = luasnip.i
local snippet = luasnip.s


luasnip.add_snippets(
    "lua",
    {
        common_snippet.print_snippet,

        snippet(
            {
                docstring="-- TODO",
                trig="td",
            },
            format([[-- TODO: {}]], { index(1, "")})
        ),

        snippet(
            {
                docstring="Read from a file on-disk.",
                trig="read_from_file",
            },
            format(
                [[
                    local {} = io.open({}, "r")
                    local {} = {{}}

                    if {}
                    then
                        for line in {}:lines()
                        do
                            table.insert({}, line)
                        end

                        {}:close()
                    end
                ]],
                {
                    index(1, "file"),
                    index(2, '"/path/to/file.txt"'),
                    index(3, "lines"),
                    repeat_(1),
                    repeat_(1),
                    repeat_(3),
                    repeat_(1),
                }
            )
        ),

        snippet(
            {
                docstring="Write to a file path on-disk.",
                trig="write_to_file",
            },
            format(
                [[
                    local {} = io.open("{}", "w")

                    if {}
                    then
                        {}:write({})
                        {}:close()
                    end
                ]],
                {
                    index(1, "file"),
                    index(2, "/path/to/file.txt"),
                    repeat_(1),
                    repeat_(1),
                    index(3, '"some_text"'),
                    repeat_(1),
                }
            )
        )
    }
)
