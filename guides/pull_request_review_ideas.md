vim git diff command, replaced by a command line tool
 - https://github.com/oguzbilgic/vim-gdiff
 
 
This will make you setup effectively diff the PR
```
gh pr checkout <unmber here>
git jump diff master
```


But if you have [octo.nvim](https://github.com/pwntester/octo.nvim) you can do much more
```
octo pr edit 12345
octo review
```

```
comment with <leader>ca / suggest with <leader>sa
Or `:Octo comment add`
```


## Misc
```
How do you highlight a git diff between two branches in a single buffer?


I do a lot of PRs and would like to do them in Neovim. I typically use \`:!gh pr checkout 12345` to checkout the PR number and then `:Git difftool master` to get the changes in the quickfix, if I'm already in Neovim. Or if outside of Neovim, just this one-liner:

    gh pr checkout 31186; nvim -c ":Git difftool `gh pr view 31186 --json baseRefName --jq .baseRefName`"

+ a bash function so I can input just the number. It works pretty well.

The problem is the above isn't a great PR review experience. I want to be able to see the lines removed / added, like how GitHub does it. In one Neovim buffer. Highlights and all. I figured this exists already but searching about this has been hard so far.

Most posts I see point to [diffview.nvim](https://github.com/sindrets/diffview.nvim) and other plugins like it (like octo). I think the plugin looks cool and useful for other people / purposes. But even the 2-split buffer view - I just don't enjoy using it. The 3-split workflow (local, remote, base) I often see is also pain on the eyes IMO and outside of resolving git merge conflicts, I find the extra info unnecessary.

So anyway, I'd really like a single-buffer-with-diff highlights experience. Ideally I'd like to just append to my command earlier like

    base=`gh pr view 31186 --json baseRefName --jq .baseRefName`
    gh pr checkout 31186; nvim -c ":GitToggleHighlights diff `gh pr view 31186 --json baseRefName --jq .baseRefName`"

And then it just checks out the PR, finds the base branch, and applies colors based on the diff.
```


## The Diff Cookbook
https://www.naseraleisa.com/posts/diff#file-1
