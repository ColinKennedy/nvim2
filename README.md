- need tmux swapping code
- ctrl+hjkl not working
- Vim doesn't seem to start the line where I last had it. Annoying. Fix!
- fzf
 - It only works once. Then it breaks!
 - make fzf fill the whole screen. Its defualt view SUCKS
- luasnip?
- add LSP for C++, Python, and C++ USD, and C++ Qt
- holding w in the terminal should scroll up
- Speed-up?



- See if compiling neovim from scratch with optimizations on improves start-up time
 - Try this: https://www.reddit.com/r/neovim/comments/qn1cci/is_your_neovim_still_fast_after_adding_plugins/
 - https://github.com/ray-x/nvim/blob/master/lua/core/lazy.lua



- Make sure to add plugins as git submodules, later
- What is impatient.nvim?
    - https://github.com/lewis6991/impatient.nvim

- Where do treesitter parses install to? Can I localize them to my single folder?
- Add treesitter parsers for other languages
- Go through checkhealth stuff
- Move plugin sections to their own files

- Make sure the cursor stays in the middle
- Implement HLNext

- Either get treesitter's text objects to work or add vim-pythonsense back

- Check that autojumping works
   - Might need to do the ``latest_autojump_folder`` stuff

- Make sure mappings work as expected
- Make sure the after-load works. e.g. cursor.vim

- Python - where's the colorcolumn? It's missing


https://alpha2phi.medium.com/neovim-for-beginners-lua-autocmd-and-keymap-functions-3bdfe0bebe42

https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/autocmds.lua

https://www.youtube.com/watch?v=stqUbv-5u2s

https://www.youtube.com/watch?v=w7i4amO_zaE&t=1464s

https://www.youtube.com/watch?v=kdP4ZHE4Bx4

https://www.youtube.com/watch?v=HR1dKKrOmDs&t=29s
