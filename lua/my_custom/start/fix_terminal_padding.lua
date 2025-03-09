--- Remove the weird padding around the terminal and the Neovim instance.
---
--- The technical details are a bit lost on me but the jist apparently is that
--- we mess with the terminal UI event to extend the colorscheme a bit further
--- than normal. But this must run *before* a colorscheme is loaded.
---
--- Reference: https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance
---
--- @module 'my_custom.start.fix_terminal_padding'
---

--- @return boolean # Check if the Neovim is running in tmux right now.
local function _in_tmux()
    return vim.fn.exists("$TMUX") == 1
end

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if not normal.bg then
            return
        end

        if _in_tmux() then
            io.write(string.format("\027Ptmux;\027\027]11;#%06x\007\027\\", normal.bg))
        else
            io.write(string.format("\027]11;#%06x\027\\", normal.bg))
        end
    end,
})

vim.api.nvim_create_autocmd("UILeave", {
    callback = function()
        if _in_tmux() then
            io.write("\027Ptmux;\027\027]111;\007\027\\")
        else
            io.write("\027]111\027\\")
        end
    end,
})
