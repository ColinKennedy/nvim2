local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local index = luasnip.i
local snippet = luasnip.s
local text = luasnip.t

return {
    snippet(
        "_CURRENT_DIRECTORY",
        {
            docstring="Get the current directory",
            text("_CURRENT_DIRECTORY = os.path.dirname(os.path.realpath(__file__))")
        }
    ),

    snippet(
        {
            docstring="Get a vanilla Python logger.",
            trig="_LOGGER",
        },
        format("_LOGGER = logging.getLogger({})", { index(1, "__name__") })
    ),

    -- snippet(
    --     {
    --         trig="dirgrep",
    --         dscr="dirgrep the currnt selection",
    --     },
    --     format("_LOGGER = logging.getLogger({})", { index(1, "__name__") })
    -- )

    snippet(
        {
            docstring="dirgrep the currnt selection",
            trig="dirgrep",
        },
        format(
            'print(sorted(item for item in dir({}) if "{}" in item.lower()))',
            { index(1, "sequence"), index(2, "") }
        )
    ),

    snippet(
        {
            docstring="Add a TODO note",
            trig="td",
        },
        format('# TODO : {}', { index(1, "") })
    ),

    snippet(
        {
            docstring="Create a triple-quote docstring",
            trig='D"',
        },
        format('"""{}."""', { index(1, "") })
    ),

    snippet(
        {
            docstring="Create a triple-quote docstring",
            trig="D'",
        },
        format("'''{}.'''", { index(1, "") })
    ),

    snippet(
        {
            docstring="os.path.",
            trig="osp",
        },
        format("os.path.{}", { index(1, "") })
    ),

    snippet(
        {
            docstring="os.path.join",
            trig="ospj",
        },
        format("os.path.join({})", { index(1, "") })
    ),

    -- -- TODO: Possibly slow. Check if I can say "only beginning"
    -- -- Fix this 
    -- snippet(
    --     {
    --         docstring="def main()",
    --         regTrig=true,
    --         trig="^main",
    --     },
    --     -- format([[
    --     --     def main():
    --     --         """Run the main execution of the script."""
    --     --         {}
    --     --     ]],
    --     --     { index(1, "pass") }
    --     -- )
    --     format("ASDL:KAJSD:LAKSJD", {})
    -- ),

    -- TODO: Fix this
    -- snippet "^ifm" "if __name__ == '__main__'" rb
    -- if __name__ == "__main__":
    --     ${1:main()}
    -- endsnippet

    snippet(
        {
            docstring="Create a basic StreamHandler Python logger",
            trig="_LOGGER_STREAM",
        },
        format(
            [[
                _LOGGER = logging.getLogger({})
                _HANDLER = logging.StreamHandler(sys.stdout)
                _HANDLER.setLevel(logging.INFO)
                _FORMATTER = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")
                _HANDLER.setFormatter(_FORMATTER)
                _LOGGER.addHandler(_HANDLER)
                _LOGGER.setLevel(logging.INFO)
            ]],
            { index(1, "some_logger_name") }
        )
    ),
}
