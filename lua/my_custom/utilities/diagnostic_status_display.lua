-- TODO: Move this somewhere to nvim-lspconfig?

-- This buffer variable + logic comes from `toggle-lsp-diagnostics.nvim`
--
-- Reference: https://github.com/ColinKennedy/toggle-lsp-diagnostics.nvim
--
_ENABLE_DIAGNOSTICS = "_enable_buffer_diagnostics"

local _allow_buffer_diagnostics = function(buffer_number, client_id)
  status, value = pcall(function()
      return vim.api.nvim_buf_get_var(buffer_number, _ENABLE_DIAGNOSTICS)
  end)

  if status
  then
    return value
  end

  return true
end

-- Make the in-line diagnostic display to be a bit cleaner
--
-- Reference: https://github.com/neovim/nvim-lspconfig/issues/662#issuecomment-759442828
--
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = true,
        -- Enable virtual text only on Warning or above, override spacing to 2
        virtual_text = {
            spacing = 2,
            min = { severity = vim.diagnostic.severity.WARN },
        },
    }
)


-- Show the diagnostic message in Vim's status-line
--
-- Reference: https://www.reddit.com/r/neovim/comments/og1cdv/neovim_lsp_how_do_you_get_diagnostic_mesages_to/h4gzvvv?utm_source=share&utm_medium=web2x&context=3
--

-- Location information about the last message printed. The format is
-- `(did print, buffer number, line number)`.
local last_echo = { false, -1, -1 }

-- The timer used for displaying a diagnostic in the commandline.
local echo_timer = nil

-- The timer after which to display a diagnostic in the commandline.
local echo_timeout = 20

-- The highlight group to use for warning messages.
local warning_hlgroup = "DiagnosticWarn"

-- The highlight group to use for error messages.
local error_hlgroup = "DiagnosticError"

-- If the first diagnostic line has fewer than this many characters, also add
-- the second line to it.
local short_line_limit = 20

-- Shows the current line's diagnostics in a floating window.
local show_line_diagnostics = function()
    vim.diagnostic.open_float({scope="line"})
end

-- Prints the first diagnostic for the current line.
local echo_diagnostic = function()
    if echo_timer then
        echo_timer:stop()
    end

    echo_timer = vim.defer_fn(
        function()
            if _allow_buffer_diagnostics(0) == false then
                return
            end

            local line = vim.fn.line('.') - 1
            local bufnr = vim.api.nvim_win_get_buf(0)

            if last_echo[1] and last_echo[2] == bufnr and last_echo[3] == line then
                return
            end

            local diags = vim
                .diagnostic
                .get(bufnr, { lnum=line, severity = vim.diagnostic.severity.WARN })

            if #diags == 0 then
                -- If we previously echo'd a message, clear it out by echoing an empty
                -- message.
                if last_echo[1] then
                  last_echo = { false, -1, -1 }

                  vim.api.nvim_command('echo ""')
                end

                return
            end

            last_echo = { true, bufnr, line }

            local diag = diags[1]
            local width = vim.api.nvim_get_option('columns') - 15
            local lines = vim.split(diag.message, "\n")
            local message = lines[1]

            if #lines > 1 and #message <= short_line_limit then
                message = message .. ' ' .. lines[2]
            end

            if width > 0 and #message >= width then
                message = message:sub(1, width) .. '...'
            end

            local kind = 'warning'
            local hlgroup = warning_hlgroup

            if diag.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
                kind = 'error'
                hlgroup = error_hlgroup
            end

            local chunks = {
                { kind .. ': ', hlgroup },
                { message }
            }

            vim.api.nvim_echo(chunks, false, {})
        end,
        echo_timeout
    )
end


local module = {}

module.echo_diagnostic = echo_diagnostic
module.show_line_diagnostics = show_line_diagnostics

return module
