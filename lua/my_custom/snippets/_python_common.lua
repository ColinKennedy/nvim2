local snippet_helper = require("my_custom.utilities.snippet_helper")
local is_line_beginning = snippet_helper.is_line_beginning
local is_source_beginning = snippet_helper.is_source_beginning
local or_ = snippet_helper.or_
local line_end = require("luasnip.extras.conditions.show").line_end
local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local index = luasnip.i
local snippet = luasnip.s
local text = luasnip.t

return {
    snippet(
        {
            docstring="Get the current directory",
            trig="_CURRENT_DIRECTORY",
        },
        text("_CURRENT_DIRECTORY = os.path.dirname(os.path.realpath(__file__))"),
        { show_condition = is_source_beginning("_CURRENT_DIRECTORY") }
    ),

    snippet(
        {
            docstring="Get a vanilla Python logger.",
            trig="_LOGGER",
        },
        format("_LOGGER = logging.getLogger({})", { index(1, "__name__") }),
        { show_condition = is_source_beginning("_LOGGER") }
    ),

    snippet(
        {
            docstring="dirgrep the currnt selection",
            trig="dirgrep",
        },
        format(
            'print(sorted(item for item in dir({}) if "{}" in item.lower()))',
            { index(1, "sequence"), index(2, "") }
        ),
        { show_condition = is_source_beginning("dirgrep") }
    ),

    snippet(
        {
            docstring="Add a TODO note",
            trig="td",
        },
        format('# TODO : {}', { index(1, "") }),
        { show_condition = or_(is_source_beginning("td"), line_end) }

    ),

    snippet(
        {
            docstring="Create a triple-quote docstring",
            trig="D",
        },
        format('"""{}."""', { index(1, "") }),
        { show_condition = is_source_beginning('D"') }
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

    snippet(
        {
            docstring="def main()",
            trig="main",
        },
        format([[
            def main():
                """Run the main execution of the script."""
                {}
            ]],
            { index(1, "pass") }
        ),
        { show_condition = is_line_beginning }
    ),

    snippet(
        -- TODO: This show_condition is not working. And probably neither is any of the others
        {
            docstring="def main()",
            trig="ifm",
        },
        format([[
            if __name__ == "__main__":
                {}
            ]],
            { index(1, "main()") }
        ),
        { show_condition = is_line_beginning }
    ),

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
            { index(1, "__name__") }
        ),
        { show_condition = is_source_beginning("_LOGGER_STREAM") }
    ),

    snippet(
        {
            docstring="Delete a file but only after Python exits.",
            trig="atexit_file",
        },
        format(
            [[
                atexit.register(functools.partial(os.remove, {}))
            ]],
            { index(1, "path") }
        )
    ),

    snippet(
        {
            docstring="Delete a folder but only after Python exits.",
            trig="atexit_folder",
        },
        format(
            [[
                atexit.register(functools.partial(shutil.rmtree, {}))
            ]],
            { index(1, "directory") }
        )
    ),
}
