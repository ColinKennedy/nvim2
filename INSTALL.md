# Fonts
https://webinstall.dev/nerdfont

Make sure to add nerd fonts to the list of installation stuff

```sh
curl -sS https://webi.sh/nerdfont | sh
```

Install "Droid Sans Mono" for Powerline Nerd Font


## Lazy.nvim
Requires a git that allows the `"--filter=blob:none"` option. Which means roughly git 2+

### CentOS 7
Reference: https://computingforgeeks.com/install-git-2-on-centos-7/#google_vignette
```sh
sudo yum -y remove git
sudo yum -y remove git-*
sudo yum -y install https://packages.endpointdev.com/rhel/7/os/x86_64/endpoint-repo.x86_64.rpm
sudo yum install git
git --version
# git version 2.41.0
```


## Tmux
Tmux 2 - https://gist.github.com/pokev25/4b9516d32f4021d945a140df09bf1fde


## Ripgrep
Ripgrep install - https://github.com/BurntSushi/ripgrep#installation


### CentOS 7
```sh
sudo yum install dnf
sudo dnf install ripgrep
```


## fzf
```sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```


## Autojump
```sh
git clone git://github.com/wting/autojump.git
cd autojump
./install.py or ./uninstall.py
```


## Tree-sitter
Requires g++ for compiling tree-sitter parsers. Ideally g++ version 8+

### C++
If you call `:TSInstall cpp` you may get this error:

```
nvim-treesitter[cpp]: Error during compilation
src/scanner.c: In function ‘scan_raw_string_delimiter’:
src/scanner.c:27:9: error: ‘for’ loop initial declarations are only allowed in C99 mode
         for (int i = 0; i < scanner->delimiter_length; ++i) {
         ^
src/scanner.c:27:9: note: use option -std=c99 or -std=gnu99 to compile your code
```

To fix:
- Install gcc-8+ / g++-8+
- Call this

```sh
CC=`which gcc` CXX=`which g++` nvim -c ":TSInstall cpp"
```


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
