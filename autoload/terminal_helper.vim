" Change the current buffer to a terminal buffer.
"
" If it's already a terminal buffer, do nothing but enter insert mode.
"
function! terminal_helper#enter_terminal()
    if mode() != "t"
        normal i
    endif
endfunction


function! terminal_helper#enter_terminal_buffer(buffer)
    let l:current_buffer = bufnr()

    call win_gotoid(win_findbuf(a:buffer)[0])
    call terminal_helper#enter_terminal()
    call win_gotoid(win_findbuf(l:current_buffer)[0])
endfunction
