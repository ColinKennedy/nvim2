-- Important: We must define ``require("dap")`` at least once.
-- Otherwise the ``DapBreakpoint`` sign won't be available for
-- another plug-in, ``Weissle/persistent-breakpoints.nvim``, to
-- refer to + use.
--
local dap = require("dap")

local command = os.getenv("HOME") .. "/sources/cpptools-linux-1.19.9/extension/debugAdapters/bin/OpenDebugAD7"

-- luacheck: ignore 631
-- Reference: https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)#ccrust-gdb-via--vscode-cpptools
if vim.fn.has("win32") == 1
then
    -- Note: Not tested. Just copied from the guide above
    dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = command,
        options = {
            detached = false,
        },
    }
else
    dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = command,
    }
end

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fs.joinpath(vim.fn.getcwd(), 'a.out'))
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fs.joinpath(vim.fn.getcwd(), 'a.out'))
    end,
  },
}

-- Reference: https://zignar.net/2023/02/17/debugging-neovim-with-neovim-and-nvim-dap/
dap.defaults.fallback.external_terminal = {
    command = "/bin/konsole";
    args = {"-e"},
}
