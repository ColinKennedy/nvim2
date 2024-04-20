require("smart-splits").setup(
    {
        resize_mode = {
            hooks = {
                on_leave = require('bufresize').register,
            },
        },
    }
)

-- Reference: https://www.reddit.com/r/neovim/comments/ohdptb/how_do_you_switch_terminal_buffers_but_keep_the/
-- Reference: https://github.com/mrjones2014/smart-splits.nvim
--
-- Allow movement between splits using Ctrl+h/j/k/l
-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
--
vim.keymap.set(
    "n",
    "<A-h>",
    require("smart-splits").resize_left,
    {desc="Make the window on the right bigger (by resizing it to the left)."}
)
vim.keymap.set(
    "n",
    "<A-j>",
    require("smart-splits").resize_down,
    {desc="Make the window on the left bigger (by resizing it to the right)."}
)
vim.keymap.set(
    "n",
    "<A-k>",
    require("smart-splits").resize_up,
    {desc="Make the window on the bottom bigger (by resizing it up)."}
)
vim.keymap.set(
    "n",
    "<A-l>",
    require("smart-splits").resize_right,
    {desc="Make the window on the top bigger (by resizing it down)."}
)
-- moving between splits
vim.keymap.set(
    "n",
    "<C-h>",
    require("smart-splits").move_cursor_left,
    {desc="Jump to the window (or tmux pane) to the left."}
)
vim.keymap.set(
    "n",
    "<C-j>",
    require("smart-splits").move_cursor_down,
    {desc="Jump to the window (or tmux pane) below."}
)
vim.keymap.set(
    "n",
    "<C-k>",
    require("smart-splits").move_cursor_up,
    {desc="Jump to the window (or tmux pane) above."}
)
vim.keymap.set(
    "n",
    "<C-l>",
    require("smart-splits").move_cursor_right,
    {desc="Jump to the window (or tmux pane) to the right."}
)

vim.keymap.set(
    "t",
    "<C-h>",
    "<C-\\><C-n><C-w>h",
    {
        desc="Jump to the window (or tmux pane) to the left.",
    }
)
vim.keymap.set(
    "t",
    "<C-j>",
    "<C-\\><C-n><C-w>j",
    {
        desc="Jump to the window (or tmux pane) below.",
    }
)
vim.keymap.set(
    "t",
    "<C-k>",
    "<C-\\><C-n><C-w>k",
    {
        desc="Jump to the window (or tmux pane) above.",
    }
)
vim.keymap.set(
    "t",
    "<C-l>",
    "<C-\\><C-n><C-w>l",
    {
        desc="Jump to the window (or tmux pane) to the right.",
    }
)
