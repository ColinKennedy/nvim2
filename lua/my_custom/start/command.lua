--- Create basic, useful Neovim user commands.
---
---@module 'my_custom.start.command'
---

local _TAB_TERMINALS = {}

vim.api.nvim_create_user_command("StripTrailingWhitespace", "%s/\\s\\+$//e", {
    desc = "Strip whitespace from the end of each lines in the current file.",
    nargs = 0,
})

vim.api.nvim_create_user_command("LspClients", function()
    local lsp_helper = require("my_custom.utilities.lsp_helper")

    lsp_helper.print_attached_clients()
end, {
    desc = "Print the active, buffer LSP clients (including nvim-lint / null-ls / etc)",
    nargs = 0,
})

vim.api.nvim_create_user_command("Messages", function()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_call(bufnr, function()
        vim.cmd([[put= execute('messages')]])
    end)
    vim.bo[bufnr].modifiable = false
    vim.cmd.split()
    local winnr = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(winnr, bufnr)
end, { desc = "Dump all (Neo)vim messages to a read-only buffer", nargs = 0 })

local focus_terminal_if_needed = function()
    local is_fzf_terminal = function()
        local name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
        local ending = ";#FZF"

        return name:sub(-#ending) == ending
    end

    if is_fzf_terminal() then
        return
    end

    local buffer = vim.fn.bufnr()

    if vim.bo[buffer].buftype ~= "terminal" then
        return
    end

    local tab = vim.api.nvim_tabpage_get_number(vim.api.nvim_get_current_tabpage())

    local replaced = false

    for existing_tab, _ in pairs(_TAB_TERMINALS) do
        if existing_tab == tab then
            _TAB_TERMINALS[existing_tab] = buffer
            replaced = true
        end
    end

    if not replaced then
        table.insert(_TAB_TERMINALS, tab, buffer)
    end
end

local terminal_sender = vim.api.nvim_create_augroup("terminal_sender", { clear = true })

vim.api.nvim_create_autocmd("WinEnter", {
    pattern = "*",
    callback = focus_terminal_if_needed,
    group = terminal_sender,
})

-- TODO: Only add within terminal buffers
vim.api.nvim_create_user_command("FocusCurrentTerminal", focus_terminal_if_needed, {})

-- TODO: Defer this to another file
vim.api.nvim_create_user_command("SendToRecentTerminal", function(options)
    local _is_buffer_hidden = function(buffer)
        return vim.fn.getbufinfo(buffer)[1].hidden == 1
    end

    local _include_newline = function(text)
        return text .. vim.api.nvim_replace_termcodes("<CR>", true, true, true)
    end

    local tab = vim.api.nvim_tabpage_get_number(vim.api.nvim_get_current_tabpage())
    local found = false
    local terminal_buffer = -1

    for existing_tab, existing_terminal_buffer in pairs(_TAB_TERMINALS) do
        if existing_tab == tab then
            terminal_buffer = existing_terminal_buffer
            found = true

            break
        end
    end

    if not found then
        print("Could not send to a terminal. No valid terminal was found.")

        return
    end

    if options["bang"] then
        print("Sending to tmux")

        return

        -- local mux = require("smart-splits.mux")
        -- local multiplexer = mux.get()
        --
        -- if not multiplexer or not multiplexer.is_in_session()
        -- then
        --     vim.api.nvim_err_writeln("Could not find a (t)mux session to send to.")
        --
        --     return
        -- end
        --
        -- local pane = _get_nearest_tmux_pane()
        -- local tmux_expr = string.format('#{pane_id}:#{pane_%s}:#{?pane_active,_active_,_no_}', edge)
        -- panes = tmux_exec({ 'list-panes', '-F', tmux_expr }, true)
    end

    local job_id = vim.fn.getbufvar(terminal_buffer, "terminal_job_id")

    if job_id == nil or _is_buffer_hidden(terminal_buffer) then
        -- TODO: Need to add this
        print("Sending to tmux")

        return
    end

    local command = _include_newline(options.args)

    vim.api.nvim_chan_send(job_id, command)
end, { bang = true, nargs = "*" })

vim.api.nvim_create_user_command("CloseAllFloatingWindows", function()
    require("my_custom.utilities.window_helper").close_all_floating_windows()
end, { nargs = 0 })

vim.opt.spelllang = "en_us,cjk"

vim.api.nvim_create_user_command("ObsidianAliases", function()
    require("my_custom.utilities.obsidian_utility").main()
end, { nargs = 0, desc = "Load obsidian.nvim notes in using their alias name." })

vim.api.nvim_create_user_command("CEdit", function(opts)
    require("my_custom.utilities.cedit").open_relative(opts.args)
end, {
    complete = function(text)
        return require("my_custom.utilities.cedit").complete_relative(text)
    end,
    nargs = 1,
    desc = "Open a file using a relative file path.",
})

vim.api.nvim_create_user_command("Cedit", function(opts)
    require("my_custom.utilities.cedit").open_relative(opts.args)
end, {
    complete = function(text)
        return require("my_custom.utilities.cedit").complete_relative(text)
    end,
    nargs = 1,
    desc = "Open a file using a relative file path.",
})

vim.api.nvim_create_user_command("LogWorkoutToday", function()
    -- local obsidian = require("obsidian")
    --
    -- local workspace = obsidian.get_client().current_workspace

    vim.cmd [[ObsidianWorkspace workout]]
    vim.cmd [[ObsidianToday]]

    -- TODO: For some reason Obsidian is bugged. Upgrade obsidian later
    -- if workspace then
    --     vim.cmd(string.format("ObsidianWorkspace %s", workspace))
    -- end
end, {
    desc = "Write about today's workout",
    nargs = 0,
})
