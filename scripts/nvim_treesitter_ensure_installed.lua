--- Make sure that tree-sitter parsers are up-to-date and installed.

--- Setup lazy.nvim so we can install plugins with it later.
local function _initialize_plugin_manager()
    vim.env.LAZY_STDPATH = ".repro"
    load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()
end

---@return string # The directory on-disk where parsers will be compiled.
local function _get_parser_directory()
    local caller_frame = debug.getinfo(2)
    local current_file = caller_frame.source:match("@?(.*)")
    local current_directory = vim.fs.dirname(current_file)

    return vim.fs.normalize(vim.fs.joinpath(current_directory, "..", "parsers", vim.uv.os_uname().sysname))
end

--- Run the script.
local function _main()
    _initialize_plugin_manager()

    local directory = _get_parser_directory()
    local parsers = { "cpp", "python" }

    require("lazy.minit").repro({
        spec = {
            {
                "nvim-treesitter/nvim-treesitter",
                build = ":TSUpdate",
                config = function()
                    require("nvim-treesitter.configs").setup {
                        parser_install_dir = directory,
                        ensure_installed = parsers,
                        auto_install = true,
                        highlight = {
                            enable = false, -- disable highlight in headless mode
                        },
                    }
                end,
                version = "*",
            },
        },
    })
end

_main()
