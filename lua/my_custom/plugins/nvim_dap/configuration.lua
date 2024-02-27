-- Important: We must define ``require("dap")`` at least once.
-- Otherwise the ``DapBreakpoint`` sign won't be available for
-- another plug-in, ``Weissle/persistent-breakpoints.nvim``, to
-- refer to + use.
--
local dap = require("dap")

local command = os.getenv("HOME") .. "/sources/cpptools-linux-1.13.9/extension/debugAdapters/bin/OpenDebugAD7"

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
