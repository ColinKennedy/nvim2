local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local index = luasnip.i
local snippet = luasnip.s


luasnip.add_snippets(
    "cmake",
    {
        -- TODO: Make beginning
        snippet(
            {
                docstring="Add a TODO note",
                trig="td",
            },
            format([[# TODO: {}]], { index(1, "") })
        ),

        -- TODO: Make beginning
        snippet(
            {
                docstring="Add a line that tells CMake to build compile_commands.json",
                trig="compile_commands",
            },
            format(
                [[
                    # Make compile_commands.json in the build directory (useful for linter tools)
                    set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
                ]],
                {}
            )
        ),

        -- TODO: Make beginning
        snippet(
            {
                docstring="Set the C++ standard of this project",
                trig="cxx",
            },
            format(
                [[
                    set(CMAKE_CXX_STANDARD {})
                    set(CMAKE_CXX_STANDARD_REQUIRED ON)
                ]],
                { index(1, "14" )}
            )
        ),

        -- TODO: Make beginning
        snippet(
            {
                docstring="Make a fatal error message",
                trig="error",
            },
            format([[message(FATAL_ERROR {}]], { index(1, "")})
        ),

        -- TODO: Make beginning
        snippet(
            {
                docstring="Prints every known CMake variable",
                trig="print_all_variables",
            },
            format(
                [[
                    # Reference: https://stackoverflow.com/a/9328525
                    get_cmake_property(_variableNames VARIABLES)
                    list (SORT _variableNames)
                    foreach (_variableName ${{_variableNames}})
                            message(STATUS "${{_variableName}}=${{${{_variableName}}}}")
                    endforeach()
                ]],
                {}
            )
        )
    }
)
