" Compiler:	cpp

if exists("current_compiler")
  finish
endif
let current_compiler = "cpp"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

" Check for ctest.h errors
"
" Example error:
"   ERR: /home/selecaoone/repositories/jumpy/engine/tests/matrix2D/rotate.cpp:13  expected 1.000000, got 2.000000
"
" Reference: https://stackoverflow.com/q/5870579
"
" Breakdown:
" - %*[\ ] - Skip all leading whitespace
" - ERR:\ - Match the beginning text
" - %f - Get the full file path
" - %l - Get the line number
" - \ %m - Get the message
" - %+G means use all string as message. It is used instead %m.
"
"
" In order:
" - ctest.h error message
" - libc assert : Reference: https://vim.fandom.com/wiki/Errorformats
" - Exact line number messages
"
CompilerSet errorformat=
\%*[\ ]ERR:\ %f:%l\ %m,
\%+GIn\ file\ included\ from\ %f:%l%*[\\,:],
\%f:%l:%*[^:]:%m


let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2:


