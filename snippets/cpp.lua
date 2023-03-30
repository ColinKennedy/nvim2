local luasnip = require("luasnip")

local builtins = require("my_custom.snippets._cpp_builtins")
local inline = require("my_custom.snippets._cpp_inline")
local usd = require("my_custom.snippets._cpp_usd")

luasnip.add_snippets("cpp", builtins)
luasnip.add_snippets("cpp", inline)
luasnip.add_snippets("cpp", usd)
