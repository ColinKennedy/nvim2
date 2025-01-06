--- Show diagnostics when mousing over a line.
---
---@module 'my_custom.utilities.diagnostic_status_display'
---

---@class _LastMessage
---@field did_print boolean
---@field buffer number
---@field line number

local M = {}

-- This buffer variable + logic comes from `toggle-lsp-diagnostics.nvim`
--
-- Reference: https://github.com/ColinKennedy/toggle-lsp-diagnostics.nvim
--
local _ENABLE_DIAGNOSTICS = "_enable_buffer_diagnostics"

--- Check if diagnostics have been explicitly enabled / disabled.
---
--- If it is unset, just assume that they are enabled.
---
---@param buffer number A 0-or-more value pointing to some Vim buffer.
---@return boolean # If diagnostics are allowed, return `true`.
---
local function _allow_buffer_diagnostics(buffer)
    local status, value = pcall(function()
        return vim.api.nvim_buf_get_var(buffer, _ENABLE_DIAGNOSTICS)
    end)

    if status then
        return value
    end

    return true
end

-- Show the diagnostic message in Vim's status-line
--
-- luacheck: ignore 631
-- Reference: https://www.reddit.com/r/neovim/comments/og1cdv/neovim_lsp_how_do_you_get_diagnostic_mesages_to/h4gzvvv?utm_source=share&utm_medium=web2x&context=3
--

-- Location information about the last message printed. The format is
-- `(did print, buffer number, line number)`.
---@type _LastMessage
local _LAST_ECHO = { did_print = false, buffer = -1, line = -1 }

-- The timer used for displaying a diagnostic in the commandline.
local _ECHO_TIMER = nil
local _ECHO_TIMEOUT = 20

local _WARNING_HIGHLIGHT = "DiagnosticWarn"
local _ERROR_HIGHLIGHT = "DiagnosticError"

-- If the first diagnostic line has fewer than this many characters, also add
-- the second line to it.
--
local short_line_limit = 20

-- Show the current line's diagnostics in a floating window.
function M.show_line_diagnostics()
    vim.diagnostic.open_float({ scope = "line" })
end

-- Print the first diagnostic for the current line.
function M.echo_diagnostic()
    if _ECHO_TIMER then
        _ECHO_TIMER:stop()
    end

    _ECHO_TIMER = vim.defer_fn(function()
        if _allow_buffer_diagnostics(0) == false then
            return
        end

        local line = vim.fn.line(".") - 1
        local buffer = vim.api.nvim_win_get_buf(0)

        if _LAST_ECHO.did_print and _LAST_ECHO.buffer == buffer and _LAST_ECHO.line == line then
            return
        end

        local diagnostics = vim.diagnostic.get(buffer, { lnum = line, severity = vim.diagnostic.severity.WARN })

        if #diagnostics == 0 then
            -- If we previously echo'd a message, clear it out by echoing an empty
            -- message.
            if _LAST_ECHO.did_print then
                _LAST_ECHO = { did_print = false, buffer = -1, line = -1 }

                vim.api.nvim_command('echo ""')
            end

            return
        end

        _LAST_ECHO = { did_print = true, buffer = buffer, line = line }

        local diagnostic = diagnostics[1]
        local width = vim.o.columns - 15
        local lines = vim.split(diagnostic.message, "\n")
        local message = lines[1]

        if #lines > 1 and #message <= short_line_limit then
            message = message .. " " .. lines[2]
        end

        if width > 0 and #message >= width then
            message = message:sub(1, width) .. "..."
        end

        local kind = "warning"
        local hlgroup = _WARNING_HIGHLIGHT

        if diagnostic.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
            kind = "error"
            hlgroup = _ERROR_HIGHLIGHT
        end

        local chunks = {
            { kind .. ": ", hlgroup },
            { message },
        }

        vim.api.nvim_echo(chunks, false, {})
    end, _ECHO_TIMEOUT)
end

return M
