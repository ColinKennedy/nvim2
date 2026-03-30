--- Configure the languages for the "nvim-treesitter/nvim-treesitter" plugin.
---
---@module 'my_custom.plugins.nvim_treesitter.configuration'
---

-- I was getting a "not a Win32 application" error on Windows so I added this workaround.
--
-- Reference: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support#troubleshooting
--
if vim.fn.has("win32") == 1 then
    require("nvim-treesitter.install").compilers = { "clang" }
end

local install_path = vim.fs.joinpath(vim.g.vim_home, "parsers", vim.uv.os_uname().sysname)

-- If you need to change the installation directory of the parsers (see
-- "Advanced Setup" in the nvim-treesitter documentation).
--
vim.opt.runtimepath:append(install_path)

-- require("nvim-treesitter.configs").setup {
--     ensure_installed = {
--         "asm",
--         "c",
--         "cmake",
--         "cpp",
--         "diff",
--         "lua",
--         "luadoc",
--         "python",
--         "query",
--         "usd",
--         "vim",
--         "vimdoc",
--     },
--     parser_install_dir = install_path,
--     highlight = {
--         -- Reference: https://github.com/nvim-treesitter/nvim-treesitter/pull/3570
--         --
--         -- Disable slow highlights for large files. Not sure if this truly needed.
--         --
--         disable = function(_, buf)
--             local max_filesize = 120 * 1024 -- 120 KB. About 3300 lines of Python. ish.
--             local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
--
--             if ok and stats and stats.size > max_filesize then
--                 return true
--             end
--
--             return false
--         end,
--
--         enable = true,
--     },
--     indent = {
--         enable = true,
--         -- TODO: Possibly remove this "python" disable.
--         --
--         -- Very unfortunately needed because indentation via treesitter has bugs.
--         --
--         -- Reference: https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
--         --
--         disable = { "cpp", "python" },
--     },
-- }

require("nvim-treesitter").install({
    "asm",
    "c",
    "cmake",
    "cpp",
    "diff",
    "lua",
    "luadoc",
    "python",
    "query",
    "usd",
    "vim",
    "vimdoc",
})

-- NOTE: At the time of writing, tree-sitter still struggles with very large files.
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    callback = function(args)
        local _allow_treesitter = function(buffer)
            local max_filesize = 120 * 1024 -- 120 KB. About 3300 lines of Python. ish.
            local path = vim.api.nvim_buf_get_name(buffer)

            if path then
                -- NOTE: Maybe in this case we should be checking the number of
                -- characters / lines in the buffer.
                --
                return true
            end

            local ok, stats = pcall(vim.uv.fs_stat, path)

            if ok and stats and stats.size > max_filesize then
                return true
            end

            return false
        end

        if not _allow_treesitter(args.buf) then
            vim.treesitter.stop(args.buf)
        end
    end,
})
