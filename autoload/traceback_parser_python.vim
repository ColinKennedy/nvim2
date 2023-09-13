function! s:_set_quick_fix_using_selection()
    " Reference: https://vi.stackexchange.com/questions/29288/how-do-you-prevent-a-new-window-from-opening-when-running-make/29290?noredirect=1#comment53666_29290
    let l:efm = '%A  File "%f"\, line %l\, in %o,%C    %m,%Z'
    let l:lines = visual_selection#get_lines()

    call setqflist([], " ", {"efm": l:efm, "lines": l:lines})
endfunction


" Convert selected Python tracebacks into quick-fix entries
function! traceback_parser_python#parse_visual_traceback()
    call s:_set_quick_fix_using_selection()

    if empty(getqflist())
        echoerr "No parse-able visual selection was found."

        return
    endif

    copen
endfunction
