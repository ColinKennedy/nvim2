require("luasnip.loaders.from_lua").lazy_load({ paths = "./snippets" })
require("luasnip").config.set_config({
    enable_autosnippets = true,
    history = false,
    updateevents = "TextChanged,TextChangedI",
})

vim.g._snippet_super_prefer_keywords = true
