- Change snippets to not exit whenever I go into Normal mode


- vim-git-backup - make into lua, maybe
- searcher / navigation mode ( project, c = class, f = function, m = method, etc)


Fix - Critical
- While in terminal mode, the `git rebase -i master` doesn't work. I cannot <ESC> properly

- Add print() snippets for each languages
 - c
 - c++
 - lua
 - print


- Look into Neovim development





- Possibly not needed anymore? - Terminal is really slow at typing, sometimes



- need terminal send / etc code
  - Add tmux support
  - SendRecent! - sends to tmux if both are there
   - config to switch the priority






- Helptags doesn't work anymore. perl error!
 - https://github.com/junegunn/fzf.vim/issues/1506
  - 5d87ac1fe8d729f116bda2f90a7211ad309ddf5a, before perl was introduced as a dependency in 1dcdb21db618055134cd611f4f5918f6d00a5df0. I've locked my version for now to the lower commit but any advice would be appreciated.




https://github.com/dharmx/nvim/blob/e79ac39e3c9aff7e4e99ce889caea45c5fc65bc4/lua/scratch/node.lua

- Look into what LSP / linter / formatter stuff can be done. Can I do refactoring / auto
fixes and stuff now? I probably will need to add the mappings.
