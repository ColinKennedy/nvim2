local is_source_beginning = require("my_custom.utilities.snippet_helper").is_source_beginning
local events = require("luasnip.util.events")
local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local snippet = luasnip.s
local text = luasnip.t


local add_ending_parenthesis = function(snippet, event_arguments)
    -- TODO: Finish this later
    -- https://github.com/aikow/dotfiles/blob/c9558f7b71be366f8dd4bfb9062434fb64b38ddd/config/nvim/lua/aiko/luasnip/callbacks.lua
    -- https://github.com/aikow/dotfiles/blob/c9558f7b71be366f8dd4bfb9062434fb64b38ddd/config/nvim/lua/aiko/luasnip/snips/markdown.lua#L6
    -- https://github.com/felix-u/dotfiles/blob/4abd001054552a167672c3f074307f2113cb6fe2/.config/nvim/lua/luasnip.lua#L10
    -- local position = event_arguments.expand_pos
    -- local current_row = position[1]
    -- local current_line = vim.fn.getline(current_row + 1)  -- Off-by-one adjustment
    --
    -- local last_column = vim.fn.col("$") - 1  -- We ``- 1`` because ``col("$")`` returns a count. We need an index
    -- local new_line = current_line .. ")"  -- We add the ``)`` suffix here
    --
    -- vim.api.nvim_buf_set_text(
    --     0,
    --     current_row,
    --     0, -- start column
    --     current_row,
    --     new_line:len() - 1,
    --     { new_line }
    -- )
    -- local r,c = unpack(vim.api.nvim_win_get_cursor(0))
    -- print("row " .. r .. " column " .. c)
    -- -- print("Adding the autocmd" .. event_arguments)
    -- -- vim.api.nvim_create_autocmd("User", {
    -- --     pattern = "LuasnipInsertNodeEnter",
    -- --     callback = function()
    -- --         print("DOING CALLBACK")
    -- --         local node = require("luasnip").session.event_node
    -- --         print(table.concat(node:get_text(), "\n"))
    -- --     end
    -- -- })
    -- -- vim.api.nvim_create_autocmd(
    -- --     "InsertCharPre",
    -- --     {
    -- --         buffer = 0,
    -- --         once = true,
    -- --         callback = function()
    -- --             print("character " .. vim.v.char)
    -- --             -- if string.find(vim.v.char, "%a") then
    -- --             --     vim.v.char = " " .. vim.v.char
    -- --             -- end
    -- --         end,
    -- --     }
    -- -- )
end


-- TODO: Get this working
local post_expand_add_parenthesis_callback = function(trigger)
    return {}
    -- return {
    --     -- index ``-1`` means the callback is on the snippet as a whole
    --     -- callbacks = { [-1] = { [events.pre_expand] = add_ending_parenthesis } },
    --     callbacks = { [-1] = { [events.leave] = function()
    --         vim.api.nvim_create_autocmd(
    --             "InsertCharPre",
    --             {
    --                 buffer = 0,
    --                 once = true,
    --                 callback = function()
    --                     print("YO ASLDKJASD:LKJ")
    --                     if string.find(vim.v.char, "%a") then
    --                         vim.v.char = vim.v.char .. ")"
    --                     end
    --                 end,
    --             }
    --         )
    --     end,
    --     }
    --     },
    --     show_condition = is_source_beginning("raise " .. trigger)
    -- }
end


return {
    snippet(
        {
            docstring="raise AttributeError",
            trig="A",
        },
        text("AttributeError("),
        post_expand_add_parenthesis_callback("A")
    ),

    snippet(
        {
            docstring="raise EnvironmentError",
            trig="E",
        },
        text("EnvironmentError("),
        post_expand_add_parenthesis_callback("E")
    ),

    snippet(
        {
            docstring="raise IndexError",
            trig="I",
        },
        text("IndexError("),
        post_expand_add_parenthesis_callback("I")
    ),

    snippet(
        {
            docstring="raise KeyError",
            trig="K",
        },
        text("KeyError("),
        post_expand_add_parenthesis_callback("K")
    ),

    snippet(
        {
            docstring="raise NotImplementedError",
            trig="N",
        },
        text("NotImplementedError("),
        post_expand_add_parenthesis_callback("N")
    ),

    snippet(
        {
            docstring="raise RuntimeError",
            trig="R",
        },
        text("RuntimeError("),
        post_expand_add_parenthesis_callback("R")
    ),

    snippet(
        {
            docstring="raise TypeError",
            trig="T",
        },
        text("TypeError("),
        post_expand_add_parenthesis_callback("T")
    ),

    snippet(
        {
            docstring="raise ValueError",
            trig="V",
        },
        text("ValueError("),
        post_expand_add_parenthesis_callback("V")
    ),

}

-- TODO: Add this, later
-- snippet p "print() py3-style" b
-- snippet print "print()"
-- snippet r "return statement"
