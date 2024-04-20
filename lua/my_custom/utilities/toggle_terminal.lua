-- TODO: Add Background shade color
-- TODO: Save and restore the mode when moving between the buffer

--- @class ToggleTerminal
---     An simplified description of a terminal that can be shown / hidden.
--- @field buffer number
---     A 1-or-more index pointing to Vim buffer data.
--- @field mode "insert" | "normal"
---     The mode to prefer whenever the cursor moves into a `buffer` window.

local M = {}

local _TAB_TERMINALS = {}
local _BUFFER_TO_TERMINAL = {}

local _Mode = {
    insert = "insert",
    normal = "normal",
}
local _NEXT_NUMBER = 0
local _STARTING_MODE = _Mode.insert -- NOTE: Start off in insert mode


--- Check if `buffer` is shown to the user.
---
--- @param buffer number A 0-or-more index pointing to some Vim data.
--- @return boolean # If at least one window contains `buffer`.
---
local function _is_buffer_visible(buffer)
    for _, window in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_buf(window) == buffer then
            return true
        end
    end

    return false
end

--- Find all tab IDs that have `buffer`.
---
--- @param buffer number A 0-or-more index pointing to some Vim data.
--- @return number[] # All of the tabs found, if any.
---
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

--- Find all windows that show `buffer`.
---
--- @param buffer number A 0-or-more index pointing to some Vim data.
--- @return number[] # All of the windows found, if any.
---
local function _get_buffer_windows(buffer)
    local output = {}

    for _, window in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_buf(window) == buffer then
            table.insert(output, window)
        end
    end

    return output
end

--- Suggest a new terminal name, starting with `name`, that is unique.
---
--- @param name string
---     Some terminal prefix. i.e. `"term://bash"`.
--- @return string
---     The full buffer path that doesn't already exist. i.e.
---     `"term://bash;::toggleterminal::1"`. It's important though to remember
---     - This won't be the final, real terminal path name because this name
---     doesn't contain a $PWD.
---
local function _suggest_name(name)
    local current = name .. ";::toggleterminal::" .. _NEXT_NUMBER

    while vim.fn.bufexists(current) == 1 do
        _NEXT_NUMBER = _NEXT_NUMBER + 1
        current = name .. ";::toggleterminal::" .. _NEXT_NUMBER
    end

    -- We add another one so that, if `_suggest_name` is called again, we save
    -- 1 extra call to `vim.fn.bufexists`.
    --
    _NEXT_NUMBER = _NEXT_NUMBER + 1

    return current
end

--- Bootstrap `toggleterminal` logic to an existing terminal `buffer`.
---
--- @param buffer number A 0-or-more index pointing to some Vim data.
---
local function _initialize_terminal_buffer(buffer)
    vim.bo[buffer].bufhidden = "hide"
    vim.b[buffer]._toggle_terminal_buffer = true
end

--- @return ToggleTerminal # Create a buffer from scratch.
local function _create_terminal()
    vim.cmd("edit! " .. _suggest_name("term://bash"))

    local buffer = vim.fn.bufnr()
    _initialize_terminal_buffer(buffer)

    return { buffer=buffer, mode=_STARTING_MODE }
end

--- Make a window (non-terminal) so we can assign a terminal into it later.
local function _prepare_terminal_window()
    vim.cmd[[set nosplitbelow]]
    vim.cmd[[10split]]
    vim.cmd[[set splitbelow&]] -- Restore the previous split setting
    vim.cmd.wincmd("J")  -- Move the split to the bottom of the tab
    vim.cmd.resize(10)
end

--- Open an existing terminal for the current tab or create one if it doesn't exist.
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

--- Change `buffer` to insert or normal mode.
---
--- @param buffer number A 1-or-more index pointing to a `toggleterm` buffer.
---
local function _handle_term_enter(buffer)
    local terminal = _BUFFER_TO_TERMINAL[buffer]
    local mode = terminal.mode

    if mode == _Mode.insert then
        vim.cmd.startinsert()
    elseif mode == _Mode.normal then
        -- TODO: Double-check this part
        return
    end
end

--- Keep track of `buffer` mode so we can restore it as needed, later.
---
--- @param buffer number A 1-or-more index pointing to a `toggleterm` buffer.
---
local function _handle_term_leave(buffer)
    local raw_mode = vim.api.nvim_get_mode().mode
    local mode = nil

    if raw_mode:match("nt") then -- nt is normal mode in the terminal
        mode = _Mode.normal
    elseif raw_mode:match("t") then -- t is insert mode in the terminal
        mode = _Mode.insert
    end

    -- print('DEBUGPRINT[2]: toggle_terminal.lua:130: mode=' .. vim.inspect(mode))
    -- print('DEBUGPRINT[3]: toggle_terminal.lua:139: buffer=' .. vim.inspect(buffer))
    -- print('DEBUGPRINT[4]: toggle_terminal.lua:140: _BUFFER_TO_TERMINAL=' .. vim.inspect(_BUFFER_TO_TERMINAL))
    local terminal = _BUFFER_TO_TERMINAL[buffer]
    terminal.mode = mode
end

-- local function on_term_open(buffer)
--     print("on open")
--     print(vim.fn.expand("#:p"))
--     local terminal = _BUFFER_TO_TERMINAL[buffer]
--     terminal.mode
--     print('DEBUGPRINT[15]: toggle_terminal.lua:196: terminal=' .. vim.inspect(terminal))
-- end

--- Check if `buffer` is a `toggleterminal`.
---
--- @param buffer number A 0-or-more index pointing to some Vim data.
--- @return boolean # If it is a `toggleterminal`, return `true`.
---
local function _is_toggle_terminal(buffer)
    if vim.api.nvim_get_option_value("buftype", {buf=buffer}) ~= "terminal" then
        return false
    end

    return vim.b[buffer]._toggle_terminal_buffer ~= nil
end

--- Convert the `toggleterminal` to vimscript so it can be saved to a Session file.
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

--- Write a Sessionx.vim file to-disk.
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

--- Create a Neovim `toggleterminal` buffer from `terminal`.
---
--- This function is used for loading from sessions. `terminal` was serialized
--- in the past and this function recreates the terminal buffer to match the
--- settings that `terminal` saved.
---
--- @param terminal ToggleTerminal Some serialized terminal data to make into a buffer.
---
function M.initialize_terminal_from_session(terminal)
    for _, tab in ipairs(_get_buffer_tabs(terminal.buffer)) do
        _TAB_TERMINALS[tab] = terminal
    end

    if vim.fn.bufexists(terminal.buffer) == 0 then
        -- TODO: Not sure if this code makes sense. Keep it in mind for a future update
        vim.cmd("edit! " .. _suggest_name("term://bash"))
        terminal.buffer = vim.fn.bufnr()
        terminal.mode = _STARTING_MODE
    end

    -- TODO: Fix
    -- _initialize_terminal_buffer(terminal.buffer)
    _BUFFER_TO_TERMINAL[terminal.buffer] = terminal
end

--- Add Neovim `toggleterminal`-related autocommands.
--- -- TODO: Finish the docstring
function M.setup_autocommands()
    local group = vim.api.nvim_create_augroup("ToggleTerminalCommands", { clear = true })
    local toggleterm_pattern = { "term://*::toggleterminal::*" }

    vim.api.nvim_create_autocmd(
        "BufEnter",
        {
            pattern = toggleterm_pattern,
            group = group,
            nested = true, -- This is necessary in case the buffer is the last
            callback = function()
                local buffer = vim.fn.bufnr()
                vim.schedule(function() _handle_term_enter(buffer) end)
            end,
        }
    )

    vim.api.nvim_create_autocmd(
        "WinLeave",
        {
            pattern = toggleterm_pattern,
            group = group,
            callback = function()
                local buffer = vim.fn.bufnr()
                vim.schedule(function() _handle_term_leave(buffer) end)
            end,
        }
    )

    -- vim.api.nvim_create_autocmd(
    --     "TermOpen",
    --     {
    --         pattern = toggleterm_pattern,
    --         group = group,
    --         callback = function()
    --             local buffer = vim.fn.bufnr()
    --             vim.schedule(function() on_term_open(buffer) end)
    --         end,
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

--- Add command(s) for interacting with the terminals.
function M.setup_commands()
    vim.api.nvim_create_user_command(
        "ToggleTerminal",
        _toggle_terminal,
        {desc="Open / Close a terminal at the bottom of the tab", nargs=0}
    )
end

--- Add keymap(s) for interacting with the terminals.
function M.setup_keymaps()
    vim.keymap.set(
        "n",
        "<Space>T",
        ":ToggleTerminal<CR>",
        {desc="Open / Close a terminal at the bottom of the tab", silent=true}
    )
end

return M
