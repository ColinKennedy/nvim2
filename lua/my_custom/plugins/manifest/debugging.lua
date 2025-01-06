return {
    -- Debug adapter plug-in. Debug anything in Neovim
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("my_custom.plugins.nvim_dap.configuration")
        end,
        cmd = "DapContinue",
        keys = require("my_custom.plugins.nvim_dap.keys"),
        version = "0.*",
    },

    -- A default "GUI" front-end for nvim-dap
    {
        "ColinKennedy/nvim-dap-ui",
        config = function()
            require("my_custom.plugins.nvim_dap_ui.configuration")
        end,
        dependencies = {
            "mfussenegger/nvim-dap",
            "ColinKennedy/nvim-dap-virtual-text", -- Optional dependency for virtual text
            "mfussenegger/nvim-dap-python", -- Optional adapter for Python
        },
        keys = require("my_custom.plugins.nvim_dap_ui.keys"),
    },

    -- Adds the current value(s) of variables as you step through the code. Super handy!
    {
        -- TODO: Remove this fork once the missing parser bug is fixed
        --
        -- Reference: https://github.com/theHamsta/nvim-dap-virtual-text/issues/71
        --
        "theHamsta/nvim-dap-virtual-text",
        opts = { virt_text_pos = "eol" },
        dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
        lazy = true,
    },

    -- TODO: Defer-load this plug-in
    -- TODO: Make sure that debugpy is installed. Otherwise, disable
    -- Reference: https://github.com/mfussenegger/nvim-dap-python#installation
    --
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap-python").setup(
                vim.fs.joinpath(
                    vim.g.vim_home,
                    "mason_packages",
                    vim.loop.os_uname().sysname,
                    "packages",
                    "debugpy",
                    "venv",
                    "bin",
                    "python"
                )
            )
            -- An example configuration to launch any Python file, via Houdini
            -- table.insert(
            --     require("dap").configurations.python,
            --     {
            --         type = "python",
            --         request = "launch",
            --         name = "Launch Via hython",
            --         program = "${file}",
            --         python = "/opt/hfs19.5.569/bin/hython"
            --         -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
            --     }
            -- )
        end,
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = true,
    },
}
