vim.cmd[[command! W :SudoWrite]]

vim.opt.ttyfast = true  -- Makes certain terminals scroll faster

-- Command-line completion, use '<Tab>' to move and '<CR>' to validate.
vim.opt.wildmenu = true

-- Ignore compiled/backup files when displaying files
vim.opt.wildignore = '*.o,*~,*.pyc,.git,.hg,.svn,*/.hg/*,*/.svn/*,*/.DS_Store'

-- Always show current position at the given line
vim.opt.ruler = true

-- Set the height of the command bar
vim.opt.cmdheight = 2

-- A buffer becomes hidden when it is abandoned, even if it has modifications
vim.opt.hidden = true

-- In many terminal emulators the mouse works just fine, thus enable it.
if vim.fn.has("mouse")
then
    vim.opt.mouse = 'a'
end

-- Ignore case when searching
vim.opt.ignorecase = true

-- When searching try to be smart about cases
vim.opt.smartcase = true

-- Makes regular characters act as they do in grep, during searches
vim.opt.magic = true

-- Show matching brackets when text indicator is over them
vim.opt.showmatch = true

-- How many tenths of a second to blink when matching brackets
vim.opt.mat = 2

-- Add a bit extra margin to the gutter
vim.opt.foldcolumn = '1'

-- Only let Vim wait for user input (characters) for 0.5 seconds. Gotta go fast!
vim.opt.timeoutlen = 500
-- Wait very little for key sequences
vim.opt.ttimeoutlen = 10

-- Return to last edit position when opening files (You want this!)
vim.api.nvim_create_autocmd(
    "BufReadPost",
    {
        callback = function()
            local line = vim.fn.line("'\"")

            if line > 0 and line <= vim.fn.line("$")
            then
                vim.cmd[[execute "normal! g`\""]]
            end
        end,
    }
)

-- Remember info about open buffers on close
vim.cmd("set viminfo^=%")

-- Always show the status line
vim.opt.laststatus = 2

-- Show relative line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Auto-save whenever you switch buffers - potentially dangerous
vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.api.nvim_create_autocmd(
    {"FocusLost", "WinLeave"},
    {
        -- Write all files before navigating away from Vim
        pattern = "*",
        command = ":silent! wa"
    }
)

-- In vimdiff mode, make diffs open as vertical buffers
-- Seriously. Why is this not the default
--
vim.opt.diffopt:append{"vertical" }

-- This makes joining lines more intelligent
--
-- Example:  without this patch - (X) is the cursor position
-- example_document.vim
-- 1
-- 2 " I am a multiline comment (X)
-- 3 " and here is more info
-- 4
--
-- press Shift+j
--
-- 1
-- 2 " I am a multiline comment (X) " and here is more info
-- 3
--
-- Nooo!! whyyyyy!
--
-- Example:
-- 1
-- 2 " I am a multiline comment (X) and here is more info
-- 3
--
-- Works with other coding languages, too, like Python!
-- Reference: kinbiko.com/vim/my-shiniest-vim-gems
--
if vim.v.version > 703
then
    vim.opt.formatoptions:append{"j"}
end

-- Change Vim to add numbered j/k  movement to the jumplist
vim.cmd[[nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k']]
vim.cmd[[nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j']]

-- If `par` is installed, add it here
-- Reference: http://www.nicemice.net/par/
--
-- s0 - disables suffixes
-- Reference: https://stackoverflow.com/q/6735996
--
if vim.fn.executable("par")
then
    vim.opt.formatprg = "par s0w88"
end

-- Disable tag completion (TAB)
--
-- Reference: https://stackoverflow.com/a/13232327/3626104
--
vim.cmd[[set complete-=t]]

-- Common typos that I want to automatically fix
vim.cmd[[abbreviate hte the]]
vim.cmd[[abbreviate het the]]
vim.cmd[[abbreviate chnage change]]

-- Add a new filetype for VEX (SideFX Houdini) files
vim.api.nvim_create_autocmd(
    {"BufNewFile", "BufRead"},
    {
        pattern = {".vex", ".vfl"},
        command = "set filetype=vex",
    }
)

-- Nvim does not have special `t_XX` options nor <t_XX> keycodes to configure
-- terminal capabilities. Instead Nvim treats the terminal as any other UI,
-- e.g. 'guicursor' sets the terminal cursor style if possible.
--
vim.opt.guicursor= "n-v-c:block-Cursor"

if vim.fn.has("nvim")
then
    local is_fzf_terminal = function()
        local name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
        local ending = ";#FZF"

        return name:sub(-#ending) == ending
    end

    local group = vim.api.nvim_create_augroup("TerminalBehavior", { clear = true })
    -- Switch from the terminal window back to other buffers quickly
    -- Reference: https://github.com/junegunn/fzf.vim/issues/544#issuecomment-457456166
    --
    vim.api.nvim_create_autocmd(
        "TermOpen",
        {
            callback = function()
                if (is_fzf_terminal())
                then
                    return
                end

                vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>", {noremap=true, buffer=true})
            end,
            group = group,
            pattern = "*",
        }
    )

    -- Neovim doesn't close the terminal immediately - this autocmd forces the
    -- terminal to close (like it does in Vim)
    --
    -- Reference: https://vi.stackexchange.com/a/17923
    --
    vim.api.nvim_create_autocmd(
        "TermClose",
        {
            command = "silent! :q",
            group = group,
            pattern = "*",
        }
    )

    -- Neovim also doesn't enter insert mode immediately when a terminal is
    -- opened. So we add it as an explicit command, here.
    --
    -- This is different from `autocmd WinEnter` because `TermOpen`
    -- executes when a Terminal is first created. And WinEnter executes
    -- when you leave a window and come back to it.
    --
    vim.api.nvim_create_autocmd(
        "TermOpen",
        {
            command = "startinsert",
            group = group,
            pattern = "*",
        }
    )
end


-- TODO: Consider defer-evaling this, since it runs off of ``TextYankPost``
--
-- Highlight the yanked text for a brief moment. Basically, blink the yanked region.
--
-- Reference: https://www.reddit.com/r/neovim/comments/gofplz/comment/hqa6xhc/?utm_source=share&utm_medium=web2x&context=3
--
vim.api.nvim_create_autocmd(
    "TextYankPost",
    {
        callback = function()
            local highlight_group = "IncSearch"
            if vim.fn.hlexists("HighlightedyankRegion") > 0
            then
                highlight_group = "HighlightedyankRegion"
            end

            vim.highlight.on_yank{ higroup=highlight_group, timeout=100 }
        end,
        pattern = "*",
    }
)
