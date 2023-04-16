-- An advanced formatter that makes text look really pretty
if vim.fn.executable("par")
then
    -- vim.opt.formatprg = 'par rTbqR B=.,\\?_A_a_0 Q=_s\\>\\|w88'
    vim.opt.formatprg = 'par rTbqR s0w88'
end
