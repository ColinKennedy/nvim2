--- Create and manage Neovim terminals.
---
--- It's assumed in this file that you want 1 terminal per tab. Support for more
--- could be added but not needed right now.
---
--- @module 'my_custom.utilities.toggle_terminal'
---

-- TODO: Do this module actually get used? Maybe remove?

-- TODO: Add Background shade color

--- @class ToggleTerminal
---     An simplified description of a terminal that can be shown / hidden.
--- @field buffer number
---     A 1-or-more index pointing to Vim buffer data.
--- @field mode "insert" | "normal"
---     The mode to prefer whenever the cursor moves into a `buffer` window.

local colormate = require("my_custom.utilities.colormate")

local _COMMAND = os.getenv("NEOVIM_PREFERRED_TERMINAL_COMMAND")

if not _COMMAND then
    if vim.fn.has("win32") then
        _COMMAND = "pwsh"
    else
        _COMMAND = "bash"
    end
end
_COMMAND = "pwsh"

local M = {}

local _TAB_TERMINALS = {}
local _BUFFER_TO_TERMINAL = {}

local _Mode = {
    insert = "insert",
    normal = "normal",
    unknown = "?",
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

--- Check if `buffer` is a `toggleterminal`.
---
--- @param buffer number A 0-or-more index pointing to some Vim data.
--- @return boolean # If it is a `toggleterminal`, return `true`.
---
local function _is_toggle_terminal(buffer)
    if vim.api.nvim_get_option_value("buftype", { buf = buffer }) ~= "terminal" then
        return false
    end

    return vim.b[buffer]._toggle_terminal_buffer ~= nil
end

--- @return number[]
---     Find all current `toggleterminal` buffers. This array includes shown or
---     hidden buffers.
---
local function _get_all_toggle_terminals()
    ---@type number[]
    local output = {}

    for tab = 1, vim.fn.tabpagenr("$") do
        for _, buffer in ipairs(vim.fn.tabpagebuflist(tab)) do
            if _is_toggle_terminal(buffer) then
                table.insert(output, buffer)
            end
        end
    end

    return output
end

--- Find all tab IDs that have `buffer`.
---
--- @param buffer number A 0-or-more index pointing to some Vim data.
--- @return number[] # All of the tabs found, if any.
---
local function _get_buffer_tabs(buffer)
    ---@type number[]
    local output = {}

    for tab = 1, vim.fn.tabpagenr("$") do
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
    ---@type number[]
    local output = {}

    for _, window in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_buf(window) == buffer then
            table.insert(output, window)
        end
    end

    return output
end

--- Get the next UUID so we can use if for terminal buffer names.
local function _increment_terminal_uuid()
    _NEXT_NUMBER = _NEXT_NUMBER + 1
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
        _increment_terminal_uuid()
        current = name .. ";::toggleterminal::" .. _NEXT_NUMBER
    end

    -- We add another one so that, if `_suggest_name` is called again, we save
    -- 1 extra call to `vim.fn.bufexists`.
    --
    _increment_terminal_uuid()

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

--- Set colors onto `window`.
---
--- @param window number A 1-or-more value of some `toggleterminal` buffer.
---
local function _apply_highlights(window)
    local namespace = "Normal"
    local hex = colormate.get_hex(namespace, "bg")
    local darker = colormate.shade_color(hex, -20)
    local window_namespace = "ToggleTerminalNormal"
    vim.api.nvim_set_hl(0, window_namespace, { bg = darker })

    vim.api.nvim_set_option_value(
        "winhighlight",
        string.format("%s:%s", namespace, window_namespace),
        { scope = "local", win = window }
    )
end

--- @return ToggleTerminal # Create a buffer from scratch.
local function _create_terminal()
    vim.cmd("edit! " .. _suggest_name("term://bash"))

    local buffer = vim.fn.bufnr()
    _initialize_terminal_buffer(buffer)

    return { buffer = buffer, mode = _STARTING_MODE }
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
    elseif mode == _Mode.unknown then
        if _STARTING_MODE == _Mode.insert then
            vim.cmd.startinsert()
        end
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
    local mode = _Mode.unknown

    if raw_mode:match("nt") then -- nt is normal mode in the terminal
        mode = _Mode.normal
    elseif raw_mode:match("t") then -- t is insert mode in the terminal
        mode = _Mode.insert
    end

    local terminal = _BUFFER_TO_TERMINAL[buffer]

    if mode then
        terminal.mode = mode
    end
end

--- Make a window (non-terminal) so we can assign a terminal into it later.
local function _prepare_terminal_window()
    vim.cmd [[set nosplitbelow]]
    vim.cmd [[split]]
    vim.cmd [[set splitbelow&]] -- Restore the previous split setting
    vim.cmd.wincmd("J") -- Move the split to the bottom of the tab
    vim.cmd.resize(10)
end

-- TODO: Maybe support this in the future
-- local function _reset_highlights()
--     print("RESETING")
-- end

--- Convert the `toggleterminal` to vimscript so it can be saved to a Session file.
local function _serialize_terminals()
    ---@type string[]
    local contents = {}

    for _, buffer in ipairs(_get_all_toggle_terminals()) do
        local terminal = _BUFFER_TO_TERMINAL[buffer]

        if not terminal then
            vim.notify(
                string.format('Something went wrong. Expected "%s" buffer to have a saved terminal.', buffer),
                vim.log.levels.ERROR
            )

            return nil
        end

        table.insert(
            contents,
            string.format("toggle_terminal.initialize_terminal_from_session(%s)", vim.inspect(terminal))
        )
    end

    if not contents then
        return nil
    end

    ---@type string[]
    local output = {}

    table.insert(output, "lua << EOF")
    table.insert(output, 'local toggle_terminal = require("my_custom.utilities.toggle_terminal")')

    for _, line in ipairs(contents) do
        table.insert(output, line)
    end

    table.insert(output, "EOF")

    return output
end

--- Open an existing terminal for the current tab or create one if it doesn't exist.
local function _toggle_terminal()
    local tab = vim.fn.tabpagenr()
    local existing_terminal = _TAB_TERMINALS[tab]

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

--- Write a Sessionx.vim file to-disk.
local function _write_sessionx_file()
    local session = vim.v.this_session
    local directory = vim.fn.fnamemodify(session, ":h")
    local sessionx = vim.fs.joinpath(directory, "Sessionx.vim")

    local data = _serialize_terminals()

    if not data then
        vim.notify("Unable to get terminal data. Cannot write Session file.", vim.log.levels.ERROR)

        return
    end

    local handler = io.open(sessionx, "w")

    if not handler then
        vim.notify(string.format('Unable to write "%s" Session file.', sessionx), vim.log.levels.ERROR)

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

    _BUFFER_TO_TERMINAL[terminal.buffer] = terminal
end

--- Add Neovim `toggleterminal`-related autocommands.
--- -- TODO: Finish the docstring
function M.setup_autocommands()
    local group = vim.api.nvim_create_augroup("ToggleTerminalCommands", { clear = true })
    local toggleterm_pattern = { "term://*::toggleterminal::*" }

    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = toggleterm_pattern,
        group = group,
        nested = true, -- This is necessary in case the buffer is the last
        callback = function()
            local buffer = vim.fn.bufnr()
            vim.schedule(function()
                _handle_term_enter(buffer)
            end)
        end,
    })

    vim.api.nvim_create_autocmd("WinLeave", {
        pattern = toggleterm_pattern,
        group = group,
        callback = function()
            local buffer = vim.fn.bufnr()

            if not vim.tbl_isempty(_BUFFER_TO_TERMINAL) then
                _handle_term_leave(buffer)
            end
        end,
    })

    -- TODO: Maybe support this in the future
    -- vim.api.nvim_create_autocmd(
    --     "ColorScheme",
    --     {
    --         group = group,
    --         callback = function()
    --             _reset_highlights()
    --
    --             for _, buffer in ipairs(_get_all_toggle_terminals()) do
    --                 for _, window in ipairs(_get_buffer_windows(buffer)) do
    --                     _apply_highlights(window)
    --                 end
    --             end
    --         end,
    --     }
    -- )

    vim.api.nvim_create_autocmd("TermOpen", {
        group = group,
        pattern = toggleterm_pattern,
        callback = function()
            local window = vim.fn.win_getid()

            vim.wo[window].relativenumber = false
            vim.wo[window].number = false
            vim.wo[window].signcolumn = "no"

            vim.schedule(function()
                _apply_highlights(window)
            end)
        end,
    })

    vim.api.nvim_create_autocmd("SessionWritePost", { group = group, callback = _write_sessionx_file })
end

--- Add command(s) for interacting with the terminals.
function M.setup_commands()
    vim.api.nvim_create_user_command(
        "ToggleTerminal",
        _toggle_terminal,
        { desc = "Open / Close a terminal at the bottom of the tab", nargs = 0 }
    )
end

--- Add keymap(s) for interacting with the terminals.
function M.setup_keymaps()
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]])
end

return M
