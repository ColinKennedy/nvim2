local is_ignoring_syntax_events = function()
    for _, value in pairs(vim.opt.eventignore)
    do
        if value == "Syntax"
        then
            return true
        end
    end

    return false
end

-- Reference: https://stackoverflow.com/questions/12485981
--
-- Enable syntax highlighting when buffers are displayed in a window through
-- :argdo and :bufdo, which disable the Syntax autocmd event to speed up
-- processing.
--
local group = vim.api.nvim_create_augroup("EnableSyntaxHighlighting", { clear = true})

vim.api.nvim_create_autocmd(
    {"BufWinEnter", "WinEnter"},
    {
        callback = function()
            if not vim.fn.exists("syntax_on")
            then
                return
            end

            if vim.fn.exists("b:current_syntax")
            then
                return
            end

            if not vim.bo.filetype
            then
                return
            end

            if is_ignoring_syntax_events()
            then
                return
            end

            vim.cmd[[syntax enable]]
        end,
        nested = true,
        pattern = "*",
    }
)

-- The above does not handle reloading via :bufdo edit!, because the
-- b:current_syntax variable is not cleared by that. During the :bufdo,
-- 'eventignore' contains "Syntax", so this can be used to detect this
-- situation when the file is re-read into the buffer. Due to the
-- 'eventignore', an immediate :syntax enable is ignored, but by clearing
-- b:current_syntax, the above handler will do this when the reloaded buffer
-- is displayed in a window again.
--
vim.api.nvim_create_autocmd(
    "BufRead",
    {
        callback = function()
            if not vim.fn.exists("b:current_syntax")
            then
                return
            end

            -- TODO: Check if this is needed
            if not vim.fn.exists("syntax_on")
            then
                return
            end

            -- TODO: Check if this is needed
            if vim.bo.filetype
            then
                return
            end

            -- TODO: Check if this is needed
            if not is_ignoring_syntax_events()
            then
                return
            end

            vim.cmd[[unlet! b:current_syntax]]
        end,
        pattern = "*",
    }
)

-- TODO: Consider lazy-loading this
vim.cmd[[
function! GetDocumentationFold(line)
    return luaeval(printf('require("my_custom.utilities.fold").get_fold_level(%d)', a:line - 1))
endfunction


set foldmethod=expr
set foldexpr=GetDocumentationFold(v:lnum)
]]

-- Force Vim's cursor to stay in the center of the screen, always
vim.api.nvim_create_autocmd(
    {"BufEnter", "WinEnter", "WinNew", "VimResized"},
    {
        group = group,
        pattern = {"*", "*.*"},
        command = ":set scrolloff=999",
    }
)
