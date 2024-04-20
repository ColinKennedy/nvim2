-- TODO: Add Background shade color
-- TODO: Save and restore the mode when moving between the buffer

local M = {}

local _TAB_TERMINALS = {}
local _BUFFER_TO_TERMINAL = {}

local _Mode = {
    insert = "insert",
    normal = "normal",
}
local _NEXT_NUMBER = 0


local function _is_buffer_visible(buffer)
    for _, window in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_buf(window) == buffer then
            return true
        end
    end

    return false
end

local function _get_buffer_tabs(buffer)
    local output = {}

    for tab = 1, vim.fn.tabpagenr('$') do
        local buffers = vim.fn.tabpagebuflist(tab)

        if vim.tbl_contains(buffers, buffer) then
            table.insert(output, tab)
        end
    end

    return output
end

local function _get_buffer_windows(buffer)
    local output = {}

    for _, window in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_buf(window) == buffer then
            table.insert(output, window)
        end
    end

    return output
end

local function _suggest_name(name)
    local current = name .. ";#toggleterminal#" .. _NEXT_NUMBER

    while vim.fn.bufexists(current) == 1 do
        _NEXT_NUMBER = _NEXT_NUMBER + 1
        current = name .. ";#toggleterminal#" .. _NEXT_NUMBER
    end

    return current
end

local function _initialize_terminal_buffer(buffer)
    vim.bo[buffer].bufhidden = "hide"
    vim.b[buffer]._toggle_terminal_buffer = true

    local terminal_name = vim.fn.expand("%:p")

    -- NOTE: We assume only one terminal per tab here. Fix that, later
    vim.api.nvim_buf_set_name(buffer, _suggest_name(terminal_name))
    _NEXT_NUMBER = _NEXT_NUMBER + 1
end

local function _create_terminal()
    vim.cmd("enew!")
    vim.cmd.terminal()

    local buffer = vim.fn.bufnr()
    _initialize_terminal_buffer(buffer)

    return {
        buffer=buffer,
        mode=_Mode.insert,  -- NOTE: Start off in insert mode
    }
end

local function _prepare_terminal_window()
    vim.cmd[[set nosplitbelow]]
    vim.cmd[[10split]]
    vim.cmd[[set splitbelow&]] -- Restore the previous split setting
    vim.cmd.wincmd("J")  -- Move the split to the bottom of the tab
    vim.cmd.resize(10)
end

local function _toggle_terminal()
    local tab = vim.fn.tabpagenr()
    local existing_terminal =  _TAB_TERMINALS[tab]

    if not existing_terminal or vim.fn.bufexists(existing_terminal.buffer) == 0 then
        _prepare_terminal_window()

        local terminal = _create_terminal()
        _TAB_TERMINALS[tab] = terminal
        _BUFFER_TO_TERMINAL[terminal.buffer] = _TAB_TERMINALS[tab]

        return
    end

    local terminal = _TAB_TERMINALS[tab]

    if _is_buffer_visible(terminal.buffer) then
        for _, window in ipairs(_get_buffer_windows(terminal.buffer)) do
            vim.api.nvim_win_close(window, false)
        end
    else
        _prepare_terminal_window()
        vim.cmd.buffer(terminal.buffer)
    end
end

-- local function _handle_term_enter(buffer)
--     print("TERM ENTER")
--     print('DEBUGPRINT[6]: toggle_terminal.lua:123: vim.fn.bufnr()=' .. vim.inspect(vim.fn.bufnr()))
--     print('DEBUGPRINT[7]: toggle_terminal.lua:124: _BUFFER_TO_TERMINAL=' .. vim.inspect(_BUFFER_TO_TERMINAL))
--     local terminal = _BUFFER_TO_TERMINAL[buffer]
--
--     local mode = terminal.mode
--
--     if mode == _Mode.insert then
--         vim.cmd.startinsert()
--     elseif mode == _Mode.normal then
--         -- TODO: Double-check this part
--         return
--     end
-- end
--
-- local function _handle_term_leave()
--     local buffer = vim.fn.bufnr()
--
--     local raw_mode = vim.api.nvim_get_mode().mode
--     local mode = nil
--
--     if raw_mode:match("nt") then -- nt is normal mode in the terminal
--         mode = _Mode.normal
--     elseif raw_mode:match("t") then -- t is insert mode in the terminal
--         mode = _Mode.insert
--     end
--
--     print('DEBUGPRINT[2]: toggle_terminal.lua:130: mode=' .. vim.inspect(mode))
--     print('DEBUGPRINT[3]: toggle_terminal.lua:139: buffer=' .. vim.inspect(buffer))
--     print('DEBUGPRINT[4]: toggle_terminal.lua:140: _BUFFER_TO_TERMINAL=' .. vim.inspect(_BUFFER_TO_TERMINAL))
--     local terminal = _BUFFER_TO_TERMINAL[buffer]
--     terminal.mode = mode
-- end
--
-- -- local function on_term_open()
-- --     local buffer = vim.fn.bufnr()
-- -- end

local function _is_toggle_terminal(buffer)
    if vim.api.nvim_get_option_value("buftype", {buf=buffer}) ~= "terminal" then
        return false
    end

    return vim.b[buffer]._toggle_terminal_buffer ~= nil
end

local function _serialize_terminals()
    local contents = {}

    for tab = 1, vim.fn.tabpagenr("$") do
        for _, buffer in ipairs(vim.fn.tabpagebuflist(tab)) do
            if _is_toggle_terminal(buffer) then
                local terminal = _BUFFER_TO_TERMINAL[buffer]

                if not terminal then
                    vim.notify(
                        string.format(
                            'Something went wrong. Expected "%s" buffer to have a saved terminal.',
                            buffer
                        ),
                        vim.log.levels.ERROR
                    )

                    return
                end

                table.insert(
                    contents,
                    string.format(
                        "toggle_terminal.initialize_terminal_from_session(%s)",
                        vim.inspect(terminal)
                    )
                )
            end
        end
    end

    if not contents then
        return nil
    end

    local output = {}

    table.insert(output, "lua << EOF")
    table.insert(
        output,
        'local toggle_terminal = require("my_custom.utilities.toggle_terminal")'
    )

    for _, line in ipairs(contents) do
        table.insert(output, line)
    end

    table.insert(output, "EOF")

    return output
end

local function _write_sessionx_file()
    local session = vim.v.this_session
    local directory = vim.fn.fnamemodify(session, ":h")
    local sessionx = vim.fs.joinpath(directory, "Sessionx.vim")

    local data = _serialize_terminals()

    if not data then
        vim.notify(
            "Unable to get terminal data. Cannot write Session file.",
            vim.log.levels.ERROR
        )

        return
    end

    local handler = io.open(sessionx, "w")

    if not handler then
        vim.notify(
            string.format('Unable to write "%s" Session file.', sessionx),
            vim.log.levels.ERROR
        )

        return
    end

    handler:write(table.concat(data, "\n"))
    handler:close()
end

function M.initialize_terminal_from_session(terminal)
    for _, tab in ipairs(_get_buffer_tabs(terminal.buffer)) do
        _TAB_TERMINALS[tab] = terminal
    end

    if vim.fn.bufexists(terminal.buffer) == 0 then
        -- TODO: Not sure if this code makes sense. Keep it in mind for a future update
        vim.cmd("enew!")
        terminal.buffer = vim.fn.bufnr()
    end

    -- TODO: Fix
    -- _initialize_terminal_buffer(terminal.buffer)
    _BUFFER_TO_TERMINAL[terminal.buffer] = terminal
    print('DEBUGPRINT[5]: toggle_terminal.lua:253: _BUFFER_TO_TERMINAL=' .. vim.inspect(_BUFFER_TO_TERMINAL))
end

function M.setup_autocommands()
    local group = vim.api.nvim_create_augroup("ToggleTerminalCommands", { clear = true })
    local toggleterm_pattern = { "term://*#toggleterminal#*" }

    -- vim.api.nvim_create_autocmd(
    --     "BufEnter",
    --     {
    --         pattern = toggleterm_pattern,
    --         group = group,
    --         nested = true, -- This is necessary in case the buffer is the last
    --         callback = _handle_term_enter,
    --     }
    -- )

    -- vim.api.nvim_create_autocmd(
    --     "WinLeave",
    --     {
    --         pattern = toggleterm_pattern,
    --         group = group,
    --         callback = _handle_term_leave,
    --     }
    -- )

    -- vim.api.nvim_create_autocmd(
    --     "TermOpen",
    --     {
    --         pattern = toggleterm_pattern,
    --         group = group,
    --         callback = on_term_open,
    --     }
    -- )

    -- api.nvim_create_autocmd("ColorScheme", {
    --   group = AUGROUP,
    --   callback = function()
    --     config.reset_highlights()
    --     for _, term in pairs(terms.get_all()) do
    --       if api.nvim_win_is_valid(term.window) then
    --         api.nvim_win_call(term.window, function() ui.hl_term(term) end)
    --       end
    --     end
    --   end,
    -- })
    --
    -- api.nvim_create_autocmd("TermOpen", {
    --   group = AUGROUP,
    --   pattern = "term://*",
    --   callback = apply_colors,
    -- })

    vim.api.nvim_create_autocmd(
        "SessionWritePost",
        { group = group, callback = _write_sessionx_file }
    )

end

function M.setup_commands()
    vim.api.nvim_create_user_command(
        "ToggleTerminal",
        _toggle_terminal,
        {desc="Open / Close a terminal at the bottom of the tab", nargs=0}
    )
end

function M.setup_keymaps()
    vim.keymap.set(
        "n",
        "<Space>T",
        ":ToggleTerminal<CR>",
        {desc="Open / Close a terminal at the bottom of the tab", silent=true}
    )
end

return M
