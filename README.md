- vim config clean-up
 - change manifest / data code to just "plugins" / "configs" - Use NvChad as an example

- yi` doesn't work. Fix!!!

- Auto completion work
 --- Python LSPs
 - C++ LSPs
  --- Jumpy (CMake enabled projects)
  --- General
  - USD
   - Maybe clangd is better? ccls keeps reporting incorrect information
    - it's better if I use explicit types. But ``auto`` is great. Need it.
    - maybe I can compile clangd with mason, but with an older version so that GLIBC works

- See if I can adapt NvChad for my purposes
 - Objectives
  --- auto complete tab behavior is good. Use their config
   --- Make tab complete based on tab. And snippets auto-expand with tab. But still allow ctrl+n / ctrl+p to cycle through snippets
    --- like NvChad
  --- Auto complete cycling is fast. Emulate it

















- Figure out a way to lazy-load nvim-cmp
- lazy window stylesheet is gross. Fix
- Disable trailing whitespace from lazy's pop-up window
- What is NvChad's "base64" cache about?

- neogen has some issues
 - when docstring is single-lined, it has as prefix space that it shouldn't
 - raises is parsed incorrectly, in Python

- command line completion should have icons and other fun stuff

- Add ``did`` support. See ``require("nvim-treesitter.configs").setup``

- disable trailing whitespace from mason-style GUIs
- neogen raises docstring stuff doesn't work as expected
 - https://github.com/danymat/neogen/issues/139

- Change af / if to match preceding comment lines. For God's sake

- Remove after/ files, maybe. They probably aren't needed
- try installing this on a fresh machine

- It'd be nice if the cursor centering doesn't break
 - Possible solution? https://stackoverflow.com/questions/64280931/keep-cursor-line-vertically-centered-in-vim 
- Ask treesitter people about module highlighting
- Is it possible to add devicons / LSP information into Command mode?



















- Add lua auto-complete?

https://github.com/jackguo380/vim-lsp-cxx-highlight

- Port block-party to treesitter
 - https://github.com/RRethy/nvim-treesitter-textsubjects
  - Maybe someone else already did it?


Apparently my stylesheet is able to have a colored number AND cursorline at the same time. How? Find out.
cursorline does not need to be set

https://www.reddit.com/r/neovim/comments/12hnn66/fyi_your_vim_help_docs_looking_a_little_bland/
Neovim statuscolumn? Highlighting?

Disable editorconfig
- https://www.youtube.com/watch?v=3TRouzuWOuQ&ab_channel=ElijahManor

- return snippet - try to use treesitter to delete the left-hand assignment (if one exists)
Try NvChad again

• Added preliminary support for the `workspace/didChangeWatchedFiles` capability
  to the LSP client to notify servers of file changes on disk. The feature is
  disabled by default and can be enabled by setting the
  `workspace.didChangeWatchedFiles.dynamicRegistration=true` capability.

https://www.reddit.com/r/neovim/comments/12h6fc7/am_i_doing_wrong_with_lazynvim/


- Consider - https://github.com/kevinhwang91/nvim-bqf


- need terminal send / etc code
 - Change my terminal set-up to have the terminal below, not above
  - SendRecent! - sends to tmux if both are there
   - config to switch the priority


- Check that the lazy-load logic is actually fast


https://www.reddit.com/r/neovim/comments/10zgrn1/hightlight_treesitter_node_under_cursor_thing/
https://github.com/dharmx/nvim/blob/e79ac39e3c9aff7e4e99ce889caea45c5fc65bc4/lua/scratch/node.lua

- Consider
 - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#gitsigns
 - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#refactoring
 - https://github.com/pylint-dev/pylint#advised-linters-alongside-pylint
 - https://github.com/DanielNoord/pydocstringformatter
 - https://github.com/jendrikseipp/vulture
 - https://github.com/ThePrimeagen/refactoring.nvim

https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-cht.sh

https://youtu.be/hJzqEAf2U4I?t=392

https://www.reddit.com/r/neovim/comments/ug2s4s/disable_diagnostic_while_expanding_luasnip/

- jedi_language_server's autocomplete is way better than pylsp. Remove pylsp from completion sources

- https://github.com/hrsh7th/nvim-cmp/wiki/Advanced-techniques#disabling-completion-in-certain-contexts-such-as-comments
- https://github.com/hrsh7th/nvim-cmp/wiki/Advanced-techniques#add-parentheses-after-selecting-function-or-method-item
- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping

- Configure settings for pydocstyle / pylint (they seem to not report every issue)

- Look into what LSP / linter / formatter stuff can be done. Can I do refactoring / auto
fixes and stuff now? I probably will need to add the mappings.

- Where do treesitter parsers install to? Can I bundle it / control their path?


- autocomplete
 - Keep an eye out for my current mappings. Do they feel good? Do they need adjusting?


- add LSP for C++, Python, and C++ USD, and C++ Qt
 - LSP auto-complete
 - Python
  - USD?
 - C++
  - CMake compile_commands.json
  - USD
  - General
 - add deferred event call so that the plugins aren't loaded by default
  - NvChad uses ``event = "InsertEnter"``

- wtf is this thing?
 - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#code-actions
 - https://github.com/streetsidesoftware/cspell
 - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md


- holding w in the terminal should scroll up
- On-load speed-up?
- Check out 
 - after/plugin/more_keymaps.vim:vnoremap <silent> <leader>pe :<C-U>call traceback_parser_python#parse_visual_traceback()<CR>
- Try this out - /home/selecaoone/repositories/NvChad/lua/plugins/init.lua
 - example gitsigns.nvim. Might be good?

- language server stuff
 - auto-refactors
 - renames
 - project cd
 - auto-completion
 - other settings?

- Consider these completion sources
 - https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources#miscellaneous
 - https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
 - https://github.com/lukas-reineke/cmp-rg

- Make sure to add plugins as git submodules, later

- Where do treesitter parses install to? Can I localize them to my single folder?
- Add treesitter parsers for other languages

- Implement HLNext?


https://github.com/williamboman/mason.nvim/blob/b54d4e3171cc9735de915dbb97e987fb1f05dad9/lua/mason/mappings/language.lua#L22


https://github.com/mfussenegger/nvim-dap
Doesn’t appear to need Python 3
Apparently it can also do remote debugging??
https://github.com/rcarriga/nvim-dap-ui
https://www.youtube.com/watch?v=5KQK2id3JtI
https://www.youtube.com/watch?v=ga3Cas7vNCk



https://alpha2phi.medium.com/neovim-for-beginners-lua-autocmd-and-keymap-functions-3bdfe0bebe42

https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/autocmds.lua

https://www.youtube.com/watch?v=stqUbv-5u2s

https://www.youtube.com/watch?v=w7i4amO_zaE&t=1464s

https://www.youtube.com/watch?v=kdP4ZHE4Bx4

https://www.youtube.com/watch?v=HR1dKKrOmDs&t=29s


- Go through checkhealth stuff
- Do the rest of the TODO notes
