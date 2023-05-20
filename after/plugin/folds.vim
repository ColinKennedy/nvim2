function! CustomFoldText()
    return luaeval(printf('require("my_custom.utilities.fold_text").get_summary(%d, %d)', v:foldstart, v:foldend))
endfunction


set foldtext=CustomFoldText()
