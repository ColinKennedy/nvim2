- Add initialize_timeout_sec as a Houdini configuration example setting
options?: {
initialize_timeout_sec?: number  -- How many seconds the client waits for a




[null-ls] failed to run generator: ...1/colin-k/nvim2/bundle/null-ls.nvim/lua/null-ls/loop.lua:237: failed to create temp file: EROFS: read-only file system: /path/to/read/only/site-packages/pyblish_lite/.null-ls_559820_window.py


Big diff (1.7 Mb) unloadable?







## Requires
- lazy.nvim requires git 2.27+ so that it can used the --filter=blob:none
    - Reference: https://stackoverflow.com/a/51411174
    - Install on CentOS 7 with: https://computingforgeeks.com/install-git-2-on-centos-7/
- Requires jedi-language-server to be installed (for null-ls)
- For debugging [debugpy](https://pypi.org/project/debugpy)


## Mappings
### Workspace switching
1 - mode
2 - mapping
3 - description
+-+---------+-----------------------------------------------------------------------------------------+
|1|    2    |                                        3                                                |
+-+---------+-----------------------------------------------------------------------------------------+
|n|<space>T |Create a [T]erminal on the bottom of the current window.                                 |
+-+---------+-----------------------------------------------------------------------------------------+
|n|<space>W |Open NvimTree starting from the `:pwd`.                                                  |
+-+---------+-----------------------------------------------------------------------------------------+
|n|<space>SS|[S]witch [S]idebar - Open a sidebar that shows the code file's classes, functions, etc.  |
+-+---------+-----------------------------------------------------------------------------------------+
|n|<space>SN|[S]witch [N]avigation inside / outside of classes and functions.                         |
+-+---------+-----------------------------------------------------------------------------------------+
|n|<space>E |[E]dit a new file, searching first from the project's root directory.                    |
+-+---------+-----------------------------------------------------------------------------------------+
|n|<space>e |[e]dit a new file from the `:pwd` for the current window.                                |
+-+---------+-----------------------------------------------------------------------------------------+
|n|<space>A |Select a new [A]rgs file from the `:args` list.                                          |
+-+---------+-----------------------------------------------------------------------------------------+
|n|<space>B |Search existing [B]uffers and select + view it.                                          |
+-+---------+-----------------------------------------------------------------------------------------+
|n|<space>L |Search [l]ines in the current window for text.                                           |
+-+---------+-----------------------------------------------------------------------------------------+


### Utility / Movement Related
1 - mode
2 - mapping
3 - description
+-+----------+----------------------------------------------------------------------------------------------+
|1|    2     |                                        3                                                     |
+-+----------+----------------------------------------------------------------------------------------------+
|n|<leader>cc|[c]opy the [c]urrent file in the current window to the system clipboard. Assuming +clipboard. |
+-+----------+----------------------------------------------------------------------------------------------+
|n|<leader>cd|[c]hange the [d]irectory (`:pwd`) to the directory of the current open window.                |
+-+----------+----------------------------------------------------------------------------------------------+
|n|<leader>e |[e]xpand to the current file's folder.                                                        |
+-+----------+----------------------------------------------------------------------------------------------+
|n|<leader>f |[f]ind text using hop-mode.                                                                   |
+-+----------+----------------------------------------------------------------------------------------------+
|n|[+        |Go to the previous line of greater indentation.                                               |
+-+----------+----------------------------------------------------------------------------------------------+
|n|[-        |Go to the previous line of lesser indentation.                                                |
+-+----------+----------------------------------------------------------------------------------------------+
|n|[=        |Go to the previous line of equal indentation.                                                 |
+-+----------+----------------------------------------------------------------------------------------------+
|n|[d        |Search upwards for diagnostic messages and go to it, if one is found.                         |
+-+----------+----------------------------------------------------------------------------------------------+
|n|[p        |[p]ut text on the line above, at the same level of indentation.                               |
+-+----------+----------------------------------------------------------------------------------------------+
|n|[q        |Move up the QuickFix window.                                                                  |
+-+----------+----------------------------------------------------------------------------------------------+
|n|]+        |Go to the next line of greater indentation.                                                   |
+-+----------+----------------------------------------------------------------------------------------------+
|n|]-        |Go to the next line of lesser indentation.                                                    |
+-+----------+----------------------------------------------------------------------------------------------+
|n|]=        |Go to the next line of equal indentation.                                                     |
+-+----------+----------------------------------------------------------------------------------------------+
|n|]d        |Search downwards for diagnostic messages and go to it, if one is found.                       |
+-+----------+----------------------------------------------------------------------------------------------+
|n|]p        |[p]ut text on the line below, at the same level of indentation.                               |
+-+----------+----------------------------------------------------------------------------------------------+
|n|]q        |Move down the QuickFix window.                                                                |
+-+----------+----------------------------------------------------------------------------------------------+


### Terminal / Tmux Communication
1 - mode
2 - mapping
3 - description
+-+----------+-----------------------------------------------------------------------+
|1|    2     |                                        3                              |
+-+----------+-----------------------------------------------------------------------+
|n|<leader>rr|[r]e-[r]un the last terminal command (The !! syntax is UNIX-specific)  |
+-+----------+-----------------------------------------------------------------------+
|n|<leader>st|[s]end to the nearest [t]erminal your system clipboard text.           |
+-+----------+-----------------------------------------------------------------------+


### Formatting And Editting
1 - mode
2 - mapping
3 - description
+-+-----------+----------------------------------------------------------------------------------+
|1|    2      |                                        3                                         |
+-+-----------+----------------------------------------------------------------------------------+
|n|<leader>sa |[s]plit [a]rgs - Split a line with arguments into multiple lines.                 |
+-+-----------+----------------------------------------------------------------------------------+
|n|<leader>dil|[d]elete [i]nside the current [l]ine, without the ending newline character.       |
+-+-----------+----------------------------------------------------------------------------------+
|n|<leader>j  |[j]oin the line below without adding an extra space                               |
+-+-----------+----------------------------------------------------------------------------------+
|n|<leader>ss |[s]ubstitute [s]election (in-file search/replace) for the word under your cursor. |
+-+-----------+----------------------------------------------------------------------------------+
|n|J          |Keep the cursor in the same position while pressing ``J``.                        |
+-+-----------+----------------------------------------------------------------------------------+


### Debugging
1 - mode
2 - mapping
3 - description
+-+-----------+------------------------------------------------------------------+
|1|     2     |                                        3                         |
+-+-----------+------------------------------------------------------------------+
|n|<F1>       |Move out of the current function call.                            |
+-+-----------+------------------------------------------------------------------+
|n|<F2>       |Skip over the current line.                                       |
+-+-----------+------------------------------------------------------------------+
|n|<F3>       |Move into a function call.                                        |
+-+-----------+------------------------------------------------------------------+
|n|<F5>       |Start a debugging session.                                        |
+-+-----------+------------------------------------------------------------------+
|n|<leader>d  |Continue through the debugger to the next breakpoint.             |
+-+-----------+------------------------------------------------------------------+
|n|<leader>d- |Restart the current debug session.                                |
+-+-----------+------------------------------------------------------------------+
|n|<leader>d= |Disconect from a remote DAP session.                              |
+-+-----------+------------------------------------------------------------------+
|n|<leader>d_ |Kill the current debug session.                                   |
+-+-----------+------------------------------------------------------------------+
|n|<leader>db |Set a breakpoint (and remember it even when we re-open the file). |
+-+-----------+------------------------------------------------------------------+
|n|<leader>dd |[d]o [d]ebugger. Start a debugging session.                       |
+-+-----------+------------------------------------------------------------------+
|n|<leader>dge|Open the [d]ebu[g] [e]dit file.                                   |
+-+-----------+------------------------------------------------------------------+
|n|<leader>dgt|Set [d]ebu[g] to [t]race level logging.                           |
+-+-----------+------------------------------------------------------------------+
|n|<leader>dh |Move out of the current function call.                            |
+-+-----------+------------------------------------------------------------------+
|n|<leader>dj |Skip over the current line.                                       |
+-+-----------+------------------------------------------------------------------+
|n|<leader>dl |Move into a function call.                                        |
+-+-----------+------------------------------------------------------------------+
|n|<leader>dz |[d]ebugger [z]oom toggle (full-screen or minimize the window).    |
+-+-----------+------------------------------------------------------------------+


### Miscellaneous
1 - mode
2 - mapping
3 - description
+-+-----------+---------------------------------------------------------+
|1|     2     |                                        3                |
+-+-----------+---------------------------------------------------------+
|c|%s/        |Make Vim's search more "magic", by default.              |
+-+-----------+---------------------------------------------------------+
|c|>s/        |Make Vim's search more "magic", by default.              |
+-+-----------+---------------------------------------------------------+
|n|/          |Make Vim's search more "magic", by default.              |
+-+-----------+---------------------------------------------------------+
|n|<C-w><C-o> |Toggle full-screen or minimize a window.                 |
+-+-----------+---------------------------------------------------------+
|n|<C-w>o     |Toggle full-screen or minimize a window.                 |
+-+-----------+---------------------------------------------------------+
|n|<F12>      |Totally useless ROT13 encyption (for fun!)               |
+-+-----------+---------------------------------------------------------+
|n|QQ         |Exit Vim without saving.                                 |
+-+-----------+---------------------------------------------------------+
|v|/          |Make Vim's search more "magic", by default.              |
+-+-----------+---------------------------------------------------------+
|v|<leader>pe |Load the selected [p]ython [e]rror as a quickfix window. |
+-+-----------+---------------------------------------------------------+


### Text-Object / Text-Object-like
1 - mode
2 - mapping
3 - description
+-+----+--------------------------------------------------------------------------+
|1| 2  |                                           3                              |
+-+----+--------------------------------------------------------------------------+
|n|P   |Prevent text from being put, twice.                                       |
+-+----+--------------------------------------------------------------------------+
|n|PP  |Put text, like you normally would in Vim, but how [Y]ank does it.         |
+-+----+--------------------------------------------------------------------------+
|n|Y   |Make capital-y work like capital-d and other commands. See :help Y        |
+-+----+--------------------------------------------------------------------------+
|n|gUiw|[g]o [U]PPERCASE the current word.                                        |
+-+----+--------------------------------------------------------------------------+
|n|gb  |Comment toggle blockwise                                                  |
+-+----+--------------------------------------------------------------------------+
|n|gbc |Comment toggle current block                                              |
+-+----+--------------------------------------------------------------------------+
|n|gc  |Comment toggle linewise                                                   |
+-+----+--------------------------------------------------------------------------+
|n|gcA |Comment insert end of line                                                |
+-+----+--------------------------------------------------------------------------+
|n|gcO |Comment insert above                                                      |
+-+----+--------------------------------------------------------------------------+
|n|gcW |Capitalize the current letter.                                            |
+-+----+--------------------------------------------------------------------------+
|n|gcc |Comment toggle current line                                               |
+-+----+--------------------------------------------------------------------------+
|n|gciW|Capitalize the current WORD.                                              |
+-+----+--------------------------------------------------------------------------+
|n|gciw|under_case the current WORD.                                              |
+-+----+--------------------------------------------------------------------------+
|n|gco |Comment insert below                                                      |
+-+----+--------------------------------------------------------------------------+
|n|gcw |Capitalize the current letter.                                            |
+-+----+--------------------------------------------------------------------------+
|n|gp  |Select the most recent text change you've made.                           |
+-+----+--------------------------------------------------------------------------+
|n|guiw|[g]o [u]nder_case the current word.                                       |
+-+----+--------------------------------------------------------------------------+
|n|gx  |Change `gx` to be more useful.                                            |
+-+----+--------------------------------------------------------------------------+
|n|p   |Change [p]ut so that it behaves like the `y`ank key.                      |
+-+----+--------------------------------------------------------------------------+
|v|.   |Make `.` work with visually selected lines.                               |
+-+----+--------------------------------------------------------------------------+
|v|aI  |Select [a]round lines of same + outer [I]ndentation, spanning whitespace. |
+-+----+--------------------------------------------------------------------------+
|v|iI  |Select [i]nside lines of same [I]ndentation, spanning whitespace.         |
+-+----+--------------------------------------------------------------------------+
|x|ac  |Select [a]round a [c]lass. (including the class definition line).         |
+-+----+--------------------------------------------------------------------------+
|x|ai  |Select [a]round [i]ndent + outer indent. Stop at whitespace.              |
+-+----+--------------------------------------------------------------------------+
|x|al  |Select [a]round a [l]ine (including the `$` character).                   |
+-+----+--------------------------------------------------------------------------+
|x|av  |Select [a]round a [v]ariable e.g. `foo_`bar                               |
+-+----+--------------------------------------------------------------------------+
|x|gb  |Comment toggle blockwise (visual)                                         |
+-+----+--------------------------------------------------------------------------+
|x|gc  |Comment toggle linewise (visual)                                          |
+-+----+--------------------------------------------------------------------------+
|x|ic  |Select [i]nside a [c]lass. (but not the class definition line)            |
+-+----+--------------------------------------------------------------------------+
|x|ii  |Select [i]nside all [i]ndent lines. Stop at whitespace.                   |
+-+----+--------------------------------------------------------------------------+
|x|il  |Select [i]nside a [l]ine (but not the `$` character).                     |
+-+----+--------------------------------------------------------------------------+
|x|iv  |Select [i]nside of a [v]ariable e.g. `foo`_bar                            |
+-+----+--------------------------------------------------------------------------+
