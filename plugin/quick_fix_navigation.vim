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
            echomsg "Looped back to the end"
        endtry
    endtry
endfunction


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
            echomsg "Looped back to the start"
        endtry
    endtry
endfunction


" Go to the previous entry, relative to the current cursor.
"
" If at the first entry, cycle to the last entry.
"
function! LAbove() abort
    try
        labove
    catch /.*/
        try
            lprevious
        catch /.*/
            llast
            echomsg "Looped back to the end"
        endtry
    endtry
endfunction


" Go to the next entry, relative to the current cursor.
"
" If at the last entry, cycle to the first entry.
"
function! LBelow() abort
    try
        lbelow
    catch /:E.*:/
        try
            lnext
        catch /.*/
            lfirst
            echomsg "Looped back to the start"
        endtry
    endtry
endfunction


command! CAbove call CAbove()
command! CBelow call CBelow()
command! LAbove call LAbove()
command! LBelow call LBelow()
