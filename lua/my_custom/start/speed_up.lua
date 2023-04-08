-- Reference: https://alpha2phi.medium.com/neovim-for-beginners-performance-95687714c236
local plugins_to_disable = {
    "gzip",
    "health",
    "man",
    "matchit",
    -- "matchparen",  -- I like being able to see matching parentheses
    "netrwPlugin",
    "remote_plugins",  -- This is a name for the runtime/plugin/rplugin.vim file
    "shada_plugin",
    "spellfile_plugin",
    "tarPlugin",
    "2html_plugin",  -- This is a name for the runtime/plugin/tohtml.vim file
    "tutor_mode_plugin",  -- This is a name for the runtime/plugin/tutor.vim file
    "zipPlugin",
}

for _, name in pairs(plugins_to_disable)
do
    vim.g["loaded_" .. name] = 1
end


-- Disable some default providers
for _, provider in ipairs { "node", "perl", "ruby" } do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end


TAB_TERMINALS = {}

local focus_terminal_if_needed = function()
    local is_fzf_terminal = function()
        local name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
        local ending = ";#FZF"

        return name:sub(-#ending) == ending
    end

    if is_fzf_terminal()
    then
        return
    end

    local tab = vim.api.nvim_tabpage_get_number(vim.api.nvim_get_current_tabpage())
    local buffer = vim.fn.bufnr()

    local replaced = false

    for existing_tab, _ in pairs(TAB_TERMINALS)
    do
        if existing_tab == tab
        then
            TAB_TERMINALS[existing_tab] = buffer
            replaced = true
        end
    end

    if not replaced
    then
        table.insert(TAB_TERMINALS, tab, buffer)
    end
end

local terminal_sender = vim.api.nvim_create_augroup("terminal_sender", { clear = true })

vim.api.nvim_create_autocmd(
    "TermOpen",
    {
        pattern = "*",
        callback = focus_terminal_if_needed,
        group = terminal_sender,
    }
)

-- TODO: Only add within terminal buffers
vim.api.nvim_create_user_command(
    "FocusCurrentTerminal",
    focus_terminal_if_needed,
    {}
)

-- TODO: Defer this to another file
vim.api.nvim_create_user_command(
    "SendToRecentTerminal",
    function(options)
	local _is_buffer_hidden = function(buffer)
	    return vim.fn.getbufinfo(buffer)[1].hidden == 1
	end

        local _include_newline = function(text)
            return vim.api.nvim_replace_termcodes("<CR>", 1, 1, 1)
        end

        local tab = vim.api.nvim_tabpage_get_number(vim.api.nvim_get_current_tabpage())
        local found = false
	local terminal_buffer = -1

        for existing_tab, existing_terminal_buffer in pairs(TAB_TERMINALS)
        do
            if existing_tab == tab
            then
                terminal_buffer = existing_terminal_buffer
                found = true

                break
            end
        end

        if not found
        then
            print("Could not send to a terminal. No valid terminal was found.")

            return
        end

        if options["bang"]
        then
            print("Sending to tmux")
            -- TODO: Need to add this

	    return
        end

	local job_id = vim.fn.getbufvar(terminal_buffer, "terminal_job_id")

	if job_id == nil or _is_buffer_hidden(terminal_buffer)
	then
            print("Sending to tmux")
            -- TODO: Need to add this

	    return
	end

        local command = _include_newline(options.args)

	vim.api.nvim_chan_send(job_id, command)
    end,
    {
        bang=true,
        nargs="*",
    }
)
