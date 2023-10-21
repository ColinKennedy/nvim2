-- I can't be bothered to translate this to lua
vim.cmd [[
" This command / function-set adds a confirmation dialog to Vim's :g command
" Example: :g/foo/Confirm d will delete all lines matching foo but it lets you
" confirm the deletion for each match. The `C` command is just a short-hand.
"
" Reference: https://stackoverflow.com/q/42954285
"
command! -nargs=+ -complete=command Confirm execute _ConfirmGlobal(<q-args>) | match none
command! -nargs=+ -complete=command C execute _ConfirmGlobal(<q-args>) | match none

" TODO: Change this into an autoload
function! _ConfirmGlobal(cmd)
  let abort = 'match none | throw "Confirm: Abort"'
  let options = [abort, a:cmd, '', abort]
  match none
  execute 'match IncSearch /\c\%' . line('.') . 'l' . @/ . '/'
  redraw
  return get(options, confirm('Execute?', "&yes\n&no\n&abort", 2), abort)
endfunction
]]
