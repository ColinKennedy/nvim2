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
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", {noremap=true})
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", {noremap=true})
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", {noremap=true})
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", {noremap=true})
