local is_source_beginning = require("my_custom.utilities.snippet_helper").is_source_beginning
local events = require("luasnip.util.events")
local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local snippet = luasnip.s
local text = luasnip.t

-- local add_ending_parenthesis = function(snippet, event_arguments)
--     print("DO IT")
-- end
-- local post_expand_add_parenthesis_callback = {
--     callbacks = { [-1] = { [events.post_expand] = add_ending_parenthesis } }
-- }


-- TODO: Finish this file
-- return {
--     snippet(
--         {
--             docstring="raise AttributeError",
--             trig="raise A",
--         },
--         text("raise AttributeError(")
--         -- post_expand_add_parenthesis_callback
--         -- {
--         --     callbacks = {
--         --         [1] = {
--         --             [events.leave] = function(node)
--         --                 print("DO IT")
--         --             end,
--         --         },
--         --     },
--         -- }
--     )
-- }

return {}
