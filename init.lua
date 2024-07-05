require("my_custom.start.speed_up")

-- TODO: Remove this line after updating Neovim to (fb3e2bf7b1fc26fef4d168fd2eb2d8eaba1d9390) (a.k.a vim-patch:9.0.1549)
--
-- Reference: https://github.com/neovim/neovim/pull/23608
--
vim.cmd[[au BufNewFile,BufRead *.cppobjdump,*.objdump setf objdump]]


-- Important: According to lazy.nvim, the leader key must be set before lazy.nvim is
-- called or else it will break various things.
--
vim.g.mapleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        }
    )
end

vim.opt.rtp:prepend(lazypath)

local _CURRENT_DIRECTORY = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand("<sfile>:p")), ":h")

-- Add extra autocommands before lazy.nvim is called so that they can be used for plug-ins
require("my_custom.start.auto_commands_pre")

local filer = require("my_custom.utilities.filer")
local tabler = require("my_custom.utilities.tabler")
local extend = tabler.extend
local plugins = {}


function _startswith(str, start)
  return str:sub(1, #start) == start
end


local function _is_comment_or_docstring(buffer, row, column)
    for _, capture in pairs(vim.treesitter.get_captures_at_pos(buffer, row, column)) do
        local text = capture.capture

        if (
            text == "string.documentation"
            or text == "comment" or _startswith(text, "comment")
        )
        then
            return true
        end

    end

    return false
end


local function _is_important(node, buffer)
    if node:type() == "comment" then
        return false
    end

    local start_row, start_column, _, _ = node:range()

    if _is_comment_or_docstring(buffer, start_row, start_column) then
        return false
    end

    return true
end


local function _has_leading_newline(line)
    local previous = line - 1
    local text = vim.fn.getline(previous)

    return text:match("^%s*$") ~= nil
end


local function _add_newline(node, buffer)
    buffer = buffer or 0
    local sibling = node:prev_named_sibling()

    if not sibling or not _is_important(sibling, buffer) then
        return
    end

    local buffer = 0
    local treesitter_line = node:start()
    local vim_line = treesitter_line + 1

    if _has_leading_newline(vim_line) then
        return
    end

    vim.api.nvim_buf_set_lines(buffer, vim_line - 1, vim_line - 1, false, {""})
end


local action = { { _add_newline, name = "add_newline" } }

table.insert(
    plugins,
    {
        "CKolkey/ts-node-action",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            python = {
                ["break_statement"] = action,
                ["continue_statement"] = action,
                ["for_statement"] = action,
                ["if_statement"] = action,
                ["return_statement"] = action,
                ["try_statement"] = action,
                ["while_statement"] = action,
                ["with_statement"] = action,
                ["yield"] = action,
            },
        },
    }
)

vim.g.vim_home = filer.get_current_directory()

extend(plugins, require("my_custom.plugins.manifest.appearance"))
extend(plugins, require("my_custom.plugins.manifest.debugging"))
extend(plugins, require("my_custom.plugins.manifest.lsp"))
extend(plugins, require("my_custom.plugins.manifest.movement"))
extend(plugins, require("my_custom.plugins.manifest.quick_fix"))
extend(plugins, require("my_custom.plugins.manifest.text_object"))
extend(plugins, require("my_custom.plugins.manifest.workflow"))
extend(plugins, require("my_custom.plugins.manifest.workflow_usd"))

table.insert(
    plugins,
    {
        "ColinKennedy/timeline.nvim",
        branch = "first_pass",
        dir = "/home/selecaoone/repositories/personal/.config/nvim/bundle/timeline.nvim",
        config = function()
            require("timeline").setup()
        end,
        -- cmd = {"TimelineOpenCurrent", "TimelineOpenWindow"}
    }
)

-- ``root`` e.g. ~/personal/.config/nvim/bundle"
local configuration = { root = vim.g.vim_home .. "/bundle" }

require("lazy").setup(plugins, configuration)

require("my_custom.start.auto_commands")
require("my_custom.start.command")
require("my_custom.start.global_confirm")
require("my_custom.start.initialization")
require("my_custom.start.remap")
require("my_custom.start.setting")
require("my_custom.start.lsp_diagnostics")
require("my_custom.start.saver").initialize()
require("my_custom.utilities.quick_fix_selection_fix").initialize()
vim.cmd("source " .. vim.g.vim_home .. "/plugin/miscellaneous_commands.vim")


-- TODO: Remove all of this later
-- vim.lsp.set_log_level("TRACE")
--
-- local client = vim.lsp.start_client{
--     name = "usd_lsp",
--     cmd = { "/home/selecaoone/repositories/usd_lsp/build/src/usd_lsp" },
-- }
--
-- if not client then
--     vim.notify("No usd_lsp client could be created.")
-- end
--
-- vim.api.nvim_create_autocmd(
--     "FileType",
--     {
--         -- pattern = "usd",
--         callback = function()
--             vim.lsp.buf_attach_client(0, client)
--
--             vim.keymap.set(
--                 "n",
--                 "gd",
--                 vim.lsp.buf.definition,
--                 {
--                     buffer=buffer,
--                     desc="[g]o to [d]efinition of the function / class.",
--                 }
--             )
--         end
--     }
-- )

-- vim.api.nvim_create_autocmd(
--     "FileType",
--     {
--         pattern = "usd",
--         callback = function()
--             vim.lsp.set_log_level("TRACE")
--
--             local client = vim.lsp.start_client{
--                 name = "usd_lsp",
--                 cmd = { "/home/selecaoone/repositories/usd_lsp/build/src/usd_lsp" },
--             }
--
--             if not client then
--                 vim.notify("No usd_lsp client could be created.")
--             end
--
--             vim.keymap.set(
--                 "n",
--                 "gd",
--                 vim.lsp.buf.definition,
--                 {
--                     buffer=buffer,
--                     desc="[g]o to [d]efinition of the function / class.",
--                 }
--             )
--
--             vim.lsp.buf_attach_client(0, client)
--
--             vim.keymap.set(
--                 "n",
--                 "gd",
--                 vim.lsp.buf.definition,
--                 {
--                     buffer=buffer,
--                     desc="[g]o to [d]efinition of the function / class.",
--                 }
--             )
--         end
--     }
-- )

-- vim.api.nvim_create_autocmd(
--     "FileType",
--     {
--         pattern = "usd",
--         callback = function()
--             vim.lsp.set_log_level("TRACE")
--
--             local client = vim.lsp.start_client{
--                 name = "usd_lsp",
--                 cmd = { "/home/selecaoone/repositories/usd_lsp/build/src/usd_lsp" },
--             }
--
--             if not client then
--                 vim.notify("No usd_lsp client could be created.")
--             end
--
--             vim.keymap.set(
--                 "n",
--                 "gd",
--                 vim.lsp.buf.definition,
--                 {
--                     buffer=buffer,
--                     desc="[g]o to [d]efinition of the function / class.",
--                 }
--             )
--
--             vim.lsp.buf_attach_client(0, client)
--         end
--     }
-- )
