" Swap between the current buffer and a terminal buffer.

" Seamlessly swap between a buffer and a terminal window window making
" any splits This module + its mappings are mostly suited for only
" single projects - it isn't well suited for people who use multiple Vim
" tabs.
"
" If the current terminal buffer is not in insert mode, force it into insert mode.
function s:is_last_buffer()
    return winnr('$') == 1
endfunction


" Create a terminal for the current tab if it doesn't exist. Otherwise, make a new one.
function! s:open_or_create_terminal()
    let l:current_tab = tabpagenr()

    if !exists("g:_recent_buffer")
        let g:_recent_buffer = {}
    endif

    let g:_recent_buffer[l:current_tab] = bufnr()

    if !exists("g:_recent_terminal")
        let g:_recent_terminal = {}
    endif

    if has_key(g:_recent_terminal, l:current_tab)
        execute ":buffer " . g:_recent_terminal[l:current_tab]

        return
    endif

    if has("nvim")
        terminal
    else
        " Reference: https://vi.stackexchange.com/a/17306/16073
        terminal ++curwin
    endif

    " let g:_recent_terminal[l:current_tab] = bufnr()
endfunction


function! terminal_swapper#swap_to_terminal()
    if &buftype != "terminal"
        " We're already in the terminal so don't make a new one
        call s:open_or_create_terminal()
    endif

    " call terminal_helper#enter_terminal()
endfunction


" Change from a terminal buffer to an (assumed) previous window.
function! terminal_swapper#swap_to_previous_window()
    let l:current_tab = tabpagenr()

    if !exists("g:_recent_terminal")
        let g:_recent_terminal = {}
    endif

    let g:_recent_terminal[l:current_tab] = bufnr()

    if !exists("g:_recent_buffer")
        let g:_recent_buffer = {}
    endif

    if has_key(g:_recent_buffer, l:current_tab)
        " If the buffer number was replaced by a terminal buffer, refresh it here.
        if getbufvar(g:_recent_buffer[l:current_tab], "&buftype", "ERROR") == "terminal"
            enew

            let g:_recent_buffer[l:current_tab] = bufnr()
        else
            execute ":buffer " . g:_recent_buffer[l:current_tab]
        endif

        return
    endif

    enew

    let g:_recent_buffer[l:current_tab] = bufnr()
endfunction
