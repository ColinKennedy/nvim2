Complete my "auto-add = sign" plugin for Python

Check if `dad` still accidentally deletes the line below it. E.g. `__init__` functions

Python super() snippet is somehow missing on my laptop?

- Terminal is really slow at typing, sometimes
- https://www.reddit.com/r/neovim/comments/1373fzz/weird_indentation_on_python/


- Add Hunspell - To improve spell checking word variants

- need terminal send / etc code
  - Add tmux support
  - SendRecent! - sends to tmux if both are there
   - config to switch the priority



- Follow-up
 - Typing "D" for a docstring in a real file is frustrating because cmp takes control away when new  LSP entries are added
  - https://github.com/hrsh7th/nvim-cmp/issues/1597


- return snippet - try to use treesitter to delete the left-hand assignment (if one exists)


- Port block-party to treesitter
 - https://github.com/RRethy/nvim-treesitter-textsubjects
  - Maybe someone else already did it?


• Added preliminary support for the `workspace/didChangeWatchedFiles` capability
  to the LSP client to notify servers of file changes on disk. The feature is
  disabled by default and can be enabled by setting the
  `workspace.didChangeWatchedFiles.dynamicRegistration=true` capability.

https://www.reddit.com/r/neovim/comments/12h6fc7/am_i_doing_wrong_with_lazynvim/


https://www.reddit.com/r/neovim/comments/10zgrn1/hightlight_treesitter_node_under_cursor_thing/
https://github.com/dharmx/nvim/blob/e79ac39e3c9aff7e4e99ce889caea45c5fc65bc4/lua/scratch/node.lua

- Consider
 - https://github.com/pylint-dev/pylint#advised-linters-alongside-pylint

- Configure settings for pydocstyle / pylint (they seem to not report every issue)

- Look into what LSP / linter / formatter stuff can be done. Can I do refactoring / auto
fixes and stuff now? I probably will need to add the mappings.








- Do this + set conceallevel=1 to conceal stuff
; (
;    (
;       (list) @capture
;       (#offset! @capture 0 1 0 -1)
;    )
;    (#set! conceal "…")
; )

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
  - https://github.com/rcarriga/cmp-dap
  - https://github.com/JMarkin/cmp-diag-codes
  - https://github.com/paopaol/cmp-doxygen
  - https://github.com/hrsh7th/cmp-nvim-lua
  - https://github.com/KadoBOT/cmp-pluginsA - Maybe???
  - https://github.com/ray-x/cmp-treesitter
  - https://github.com/uga-rosa/cmp-dynamic
 - https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
 - https://github.com/lukas-reineke/cmp-rg

- Make sure to add plugins as git submodules, later

- Where do treesitter parses install to? Can I localize them to my single folder?
- Add treesitter parsers for other languages

- Implement HLNext?

- Add ``did`` support. See ``require("nvim-treesitter.configs").setup``


https://github.com/williamboman/mason.nvim/blob/b54d4e3171cc9735de915dbb97e987fb1f05dad9/lua/mason/mappings/language.lua#L22


https://github.com/mfussenegger/nvim-dap
Doesn’t appear to need Python 3
Apparently it can also do remote debugging??
https://github.com/rcarriga/nvim-dap-ui
https://www.youtube.com/watch?v=5KQK2id3JtI
https://www.youtube.com/watch?v=ga3Cas7vNCk

This doesn't split into newlines, properly
- vim.keymap.set("n", "[q", ":cprevious<CR>")
- vim.keymap.set("n", "<leader>dil", '^v$hd"_dd', {desc="Delete the current line, without the ending newline character, but still delete the line."})


