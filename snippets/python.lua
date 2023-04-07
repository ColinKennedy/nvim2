local luasnip = require("luasnip")

local builtins = require("my_custom.snippets._python_builtins")
local common = require("my_custom.snippets._python_common")
local dunders = require("my_custom.snippets._python_dunders")
local qt = require("my_custom.snippets._python_qt")
local usd = require("my_custom.snippets._python_usd")

luasnip.add_snippets("python", builtins)
luasnip.add_snippets("python", common)
luasnip.add_snippets("python", dunders)
luasnip.add_snippets("python", qt)
luasnip.add_snippets("python", usd)
