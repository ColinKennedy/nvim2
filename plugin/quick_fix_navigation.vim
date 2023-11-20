" Go to the previous entry, relative to the current cursor.
"
" If at the first entry, cycle to the last entry.
"
function! CAbove() abort
    try
        cabove
    catch /:E.*:/
        try
            cprevious
        catch /.*/
            clast
        endtry
    endtry
endfunction

command! CAbove call CAbove()


" Go to the next entry, relative to the current cursor.
"
" If at the last entry, cycle to the first entry.
"
function! CBelow() abort
    try
        cbelow
    catch /:E.*:/
        try
            cnext
        catch /.*/
            cfirst
        endtry
    endtry
endfunction


command! CBelow call CBelow()
