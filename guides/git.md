During merge conflicts, rebases, and other "diff-related" events, you can use
vim-fugitive to call `:Gdiffsplit`


TODO finish this information

aliases for "give me the remote / local" during a git merge conflict session
diffget REM
diffget LOC

https://www.reddit.com/r/vim/comments/199bkgk/using_vimdiff/
https://jeancharles.quillet.org/posts/2022-03-02-Practical-introduction-to-fugitive.html
/home/selecaoone/temp/merge_conflict_test/some_file.txt
https://www.youtube.com/watch?v=vpwJ7fqD1CE
https://www.rosipov.com/blog/use-vimdiff-as-git-mergetool/


## Extra Plugins
A plugin that can open up github repo + branch + commit + lines directly in Neovim
https://github.com/trevorhauter/gitportal.nvim


## Neovim As A Git Pager
In short, Neovim is not really ready to be a pager for git. There's some
partial support, which this page goes over - https://lemmy.world/post/1563173
- but really, we need support for `nvim --remote-wait` which doesn't exist yet.
