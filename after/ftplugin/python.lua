-- Force Python files to auto-fold their docstrings
--
-- Note: Requires some syntax rules, in ``{root}/after/syntax/python.vim``.
--
-- Reference: https://chrisdown.name/2015/02/26/folding-python-docstrings-in-vim.html
--
-- vim.api.nvim_create_autocmd(
--     "FileType",
--     {
--         pattern = ".py",
-- 	command = "setlocal foldenable foldmethod=syntax",
--     }
-- )
vim.cmd("autocmd FileType python setlocal foldenable foldmethod=syntax")

-- An advanced formatter that makes text look really pretty
if vim.fn.executable("par")
then
    -- vim.opt.formatprg = 'par rTbqR B=.,\\?_A_a_0 Q=_s\\>\\|w88'
    vim.opt.formatprg = 'par rTbqR s0w88'
end
