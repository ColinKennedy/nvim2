local is_ignoring_syntax_events = function()
    for _, value in pairs(vim.opt.eventignore)
    do
        if value == "Syntax"
        then
            return true
        end
    end

    return false
end

-- Remove the column-highlight on QuickFix & LocationList buffers
vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = "qf",
        command = "setlocal nonumber colorcolumn=",
    }
)

vim.api.nvim_create_autocmd(
    "FileType",
    {
        callback = function()
            vim.keymap.set(
                "n",
                "<leader>ct",
                function()
                    local current_name = vim.fn.getqflist({title=true, winid=true}).title
                    local name = vim.fn.input("New Name: ", current_name)

                    if name == ""
                    then
                        return
                    end

                    vim.fn.setqflist({}, "r", {title=name, winid=true})

                    local success, winbar = pcall(require, "winbar")

                    if success
                    then
                        winbar.run_on_current_buffer()
                    end
                end,
                {
                    buffer = true,
                    desc = "[c]hange Quickfix [t]itle.",
                }
            )
        end,
        pattern = "qf",
    }
)

-- Reference: https://stackoverflow.com/questions/12485981
--
-- Enable syntax highlighting when buffers are displayed in a window through
-- :argdo and :bufdo, which disable the Syntax autocmd event to speed up
-- processing.
--
local group = vim.api.nvim_create_augroup("EnableSyntaxHighlighting", { clear = true})

vim.api.nvim_create_autocmd(
    {"BufWinEnter", "WinEnter"},
    {
        callback = function()
            if not vim.fn.exists("syntax_on")
            then
                return
            end

            if vim.fn.exists("b:current_syntax")
            then
                return
            end

            if not vim.bo.filetype
            then
                return
            end

            if is_ignoring_syntax_events()
            then
                return
            end

            vim.cmd[[syntax enable]]
        end,
        nested = true,
        pattern = "*",
        group=group,
    }
)

-- The above does not handle reloading via :bufdo edit!, because the
-- b:current_syntax variable is not cleared by that. During the :bufdo,
-- 'eventignore' contains "Syntax", so this can be used to detect this
-- situation when the file is re-read into the buffer. Due to the
-- 'eventignore', an immediate :syntax enable is ignored, but by clearing
-- b:current_syntax, the above handler will do this when the reloaded buffer
-- is displayed in a window again.
--
vim.api.nvim_create_autocmd(
    "BufRead",
    {
        callback = function()
            if not vim.fn.exists("b:current_syntax")
            then
                return
            end

            -- TODO: Check if this is needed
            if not vim.fn.exists("syntax_on")
            then
                return
            end

            -- TODO: Check if this is needed
            if vim.bo.filetype
            then
                return
            end

            -- TODO: Check if this is needed
            if not is_ignoring_syntax_events()
            then
                return
            end

            vim.cmd[[unlet! b:current_syntax]]
        end,
        pattern = "*",
    }
)

-- Whenever you edit a local .vimrc file, immediately re-source it
-- See the ``vim-addon-local-vimrc`` plug-in for details.
--
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = ".vimrc",
        callback = function()
            local current_vimrc_path = vim.api.nvim_buf_get_name(0)

            if current_vimrc_path == os.getenv("MYVIMRC")
            then
                -- Don't auto-reload a top-level .vimrc. We do this because
                -- that .vimrc usually has plug-in specifics that can only be
                -- reliably loaded once per Vim session.
                --
                -- All other .vimrc files are okay to reload though. e.g.
                -- .vimrc files from the ``vim-addon-local-vimrc`` plug-in.
                --
                return
            end

            vim.cmd[[source %]]
        end,
    }
)

vim.api.nvim_create_autocmd(
    {"BufRead", "BufNewFile"},
    {
        command = ":set filetype=usd",
        pattern = "*.usd*",
    }
)


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


local function _enable_winfixbuf_if_supported()
    if vim.fn.exists("&winfixbuf") == 1 then
        vim.cmd[[set winfixbuf]]
    end
end


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

                vim.keymap.set(
                    "t",
                    "<ESC><ESC>",
                    "<C-\\><C-n>",
                    {
                        buffer=true,
                        desc="Exit the terminal by pressing <ESC> twice in a row.",
                        noremap=true,
                    }
                )
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

    -- Make sure a terminal buffer can never be switched away
    vim.api.nvim_create_autocmd(
        "TermOpen",
        {
            callback = _enable_winfixbuf_if_supported,
            group = group,
            pattern = "*",
        }
    )
end

--- @boolean # If `'winfixbuf'` is enabled in this (Neo)vim version
local function _is_winfixbuf_supported()
    return vim.fn.exists("&winfixbuf") == 1
end

-- Associate certain windows with certain file types, using `'winfixbuf'`
-- e.g. If a window is created that points to a specific buffer, only allow
-- that window to show that buffer and no other.
--
-- This is a bit of a hack. Really, plugin authors should integrate support
-- `'winfixbuf'`. But this will work in the meantime while plugins update their
-- settings.
--
vim.api.nvim_create_autocmd(
    "WinNew",
    {
        callback = function()
            vim.schedule(
                function()
                    if not _is_winfixbuf_supported()
                    then
                        return
                    end

                    local type_ = vim.bo.filetype

                    if (
                        type_ == "NvimTree" -- https://github.com/nvim-tree/nvim-tree.lua

                        -- https://github.com/stevearc/aerial.nvim
                        or type_ == "aerial"
                        or type_ == "aerial-nav"

                        -- https://github.com/rcarriga/nvim-dap-ui
                        or type_ == "dapui_watches"
                        or type_ == "dapui_stacks"
                        or type_ == "dapui_breakpoints"
                        or type_ == "dapui_scopes"
                        or type_ == "dapui_console"
                        -- https://github.com/mfussenegger/nvim-dap
                        or type_ == "dap-repl"

                        or type_ == "DiffviewFiles"  -- https://github.com/sindrets/diffview.nvim
                        or type_ == "Outline"  -- https://github.com/simrat39/symbols-outline.nvim
                        or type_ == "TelescopePrompt"  -- https://github.com/nvim-telescope/telescope.nvim
                        or type_ == "fzf"  -- https://github.com/ibhagwan/fzf-lua
                        or type_ == "mason"  -- https://github.com/williamboman/mason.nvim
                        or type_ == "neotest-summary"  -- https://github.com/nvim-neotest/neotest
                        or type_ == "qf"
                        or type_ == "undotree"  -- https://github.com/mbbill/undotree
                    )
                    then
                        vim.wo.winfixbuf = true
                    end
                end
            )
        end,
    }
)

-- Keep track of the current layout, on-close. Create a Vim Session.vim file.
local function _save_session()
    if vim.v.this_session ~= "" then
        vim.cmd("mksession! " .. vim.v.this_session)
    end
end
vim.api.nvim_create_autocmd("VimLeave", { callback = _save_session })
