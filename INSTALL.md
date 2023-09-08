## Tree-sitter
Requires g++ for compiling tree-sitter parsers. Ideally g++ version 8+


## Python LSPs and linters
```sh
python3 -m pip install pydocstyle --user
python3 -m pip install pyright --user
python3 -m pip install jedi-language-server --user
python3 -m pip install "python-lsp-server[all]" --user
```

# Plugins
## vim-git-backup
vim-git-backup requires sed

```
Failed to source `nvim/bundle/vim-git-backup/plugin/backup_git.vim`
vim/_editor.lua:341: BufWritePre Autocommands for "*"..script nvim_exec2() called at BufWritePre Autocommands for "*":0..nvim/bundle/vim-git-backup/plugin/backup_git.vim, line 9: Vim(echoerr):vim-git-backup requires "sed" cannot continue.
```


# Troubleshooting
## Windows - nvim-treesitter error
E5108: Error executing lua: vim/_editor.lua:341: nvim_exec2(): Vim(lua):E5108: Error executing lua Failed to load parser for language 'python': uv_dlopen: python.so is not a valid Win32 application.

Reference: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support#troubleshooting
