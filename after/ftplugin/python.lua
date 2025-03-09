-- -- TODO: This is super slow on big files. Fix?
-- -- TODO: Consider lazy-loading this
-- vim.cmd[[
-- function! GetDocumentationFold(line)
--     return luaeval(printf('require("my_custom.utilities.fold").get_fold_level(%d)', a:line - 1))
-- endfunction
--
--
-- set foldmethod=expr
-- set foldexpr=GetDocumentationFold(v:lnum)
-- ]]

vim.cmd[[
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
]]
