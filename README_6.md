Fix - Critical
- While in terminal mode, the `git rebase -i master` doesn't work. I cannot <ESC> properly

Add
- Complete my "auto-add = sign" plugin for Python
- Vim cutlass plugin - Test it out first though




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
