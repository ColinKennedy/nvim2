if vim.fn.exists("*win_getid") ~= 0
then
    vim.cmd('silent !echo "Cursor position logic cannot be ran. Vim is too old."')

    return
end

-- Reference: http://vim.wikia.com/wiki/Keep_your_cursor_centered_vertically_on_the_screen
local group = vim.api.nvim_create_augroup("VCenterCursor", { clear = true })

vim.api.nvim_create_autocmd(
    {"BufEnter", "WinEnter", "WinNew", "VimResized"},
    {
        group = group,
        pattern = {"*", "*.*"},
        command = "let &scrolloff=(winheight(win_getid())/2) + 1",
    }
)
