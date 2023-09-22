Fix - Critical
- While in terminal mode, the `git rebase -i master` doesn't work. I cannot <ESC> properly

- Try vim submodes again, one more time. Probably won't work but it's worth a try

- Fix gciI broken mapping - HandleTextObjectMapping error

- Disable pycodestyle / pyflakes / anything else (it's coming from pylsp. Remove it.)

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



https://www.reddit.com/r/neovim/comments/12h6fc7/am_i_doing_wrong_with_lazynvim/


https://github.com/dharmx/nvim/blob/e79ac39e3c9aff7e4e99ce889caea45c5fc65bc4/lua/scratch/node.lua

- Look into what LSP / linter / formatter stuff can be done. Can I do refactoring / auto
fixes and stuff now? I probably will need to add the mappings.
