return {
    -- Change the [p]ut key to now be a text object, like yy!
    {
        "p",
        "<Plug>(operator-replace)",
        desc = "Change `p` to act more like `y`.",
    },
    -- Change the [pp]ut key to now be a text object, like yy!
    {
        "pp",
        "p",
        desc = "Change `p` to act more like `y`.",
    },
    -- Set P to <NOP> so that it's not possible to accidentally put text
    -- twice, using the P key.
    --
    {
        "P",
        "<NOP>",
        desc = "Prevent text from being put, twice.",
    },
    {
        "PP",
        "P",
        desc = "Put text, like you normally would in Vim, but how [Y]ank does it.",
    },
}
