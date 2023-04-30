- Add lua auto-complete?

https://github.com/jackguo380/vim-lsp-cxx-highlight

- Port block-party to treesitter
 - https://github.com/RRethy/nvim-treesitter-textsubjects
  - Maybe someone else already did it?

- Customize fold text to ignore leading whitespace

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

https://github.com/nvim-treesitter/completion-treesitter
 - Is it possible to get treesitter keywords in auto-completion, as a completion source?

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

This doesn't split into newlines, properly
- vim.keymap.set("n", "[q", ":cprevious<CR>")
- vim.keymap.set("n", "<leader>dil", '^v$hd"_dd', {desc="Delete the current line, without the ending newline character, but still delete the line."})
