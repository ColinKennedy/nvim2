## Compile
```sh
rez-env gcc-8
# Release
CC=`which gcc` CXX=`which g++` make CMAKE_BUILD_TYPE=Release -j 56
# Debugging
CC=`which gcc` CXX=`which g++` make CMAKE_BUILD_TYPE=RelWithDebInfo -j 56

cmake -B build -D CMAKE_BUILD_TYPE=Debug -D CMAKE_C_COMPILER=clang -D ENABLE_ASAN_UBSAN=1 && cmake --build build -- -j 56
```


msg_puts_attr("Is visual mode, actually", 0);
// emsg(_("Is visual mode, actually"));
// snprintf(errmsg, sizeof(errmsg), "is a visual print");
// fprintf(stderr, "Is visual, actually");


## Debugging
### Configuration
- Make sure you compile with debug symbols enabled
- Add a .vimrc with a configuration for nvim-dap (see below)
- Get out of tmux if you're inside of it (from experience, it causes problems during debugging)
- Set a breakpoint somewhere
- Use <leader>dd to start the debugging process

### Configuration
```vim
" Reference: https://stackoverflow.com/a/18734557
let g:_project_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" Reference: https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)#configuration
lua << EOF
local dap = require("dap")

dap.configurations.c = {
    -- Reference: https://zignar.net/2023/02/17/debugging-neovim-with-neovim-and-nvim-dap/
    setmetatable(
        {
            name = "Launch Neovim",
            type = "cppdbg",
            request = "launch",
            program = function()
                return vim.g._project_home .. "/build/bin/nvim"
            end,
            args = {"-u", "NONE"},
            cwd = vim.g._project_home,
            externalConsole = true,
        },
        {
            __call = function(config)
                -- Compile Neovim before running the debugger
                -- vim.fn.system("CMAKE_BUILD_TYPE=RelWithDebInfo make")

                -- ⬇️ listeners are indexed by a key.
                -- This is like a namespace and must not conflict with what plugins
                -- like nvim-dap-ui or nvim-dap itself uses.
                -- It's best to not use anything starting with `dap`
                local key = "a-unique-arbitrary-key"

                -- ⬇️ `dap.listeners.<before | after>.<event_or_command>.<plugin_key>`
                -- We listen to the `initialize` response. It indicates a new session got initialized
                dap.listeners.after.initialize[key] = function(session)
                    -- ⬇️ immediately clear the listener, we don't want to run this logic for additional sessions
                    dap.listeners.after.initialize[key] = nil

                    -- The first argument to a event or response is always the session
                    -- A session contains a `on_close` table that allows us to register functions
                    -- that get called when the session closes.
                    -- We use this to ensure the listeners get cleaned up
                    session.on_close[key] = function()
                        for _, handler in pairs(dap.listeners.after) do
                            handler[key] = nil
                        end
                    end
                end

                -- We listen to `event_process` to get the pid:
                dap.listeners.after.event_process[key] = function(_, body)
                    -- ⬇️ immediately clear the listener, we don't want to run this logic for additional sessions
                    dap.listeners.after.event_process[key] = nil

                    local ppid = body.systemProcessId
                    -- The pid is the parent pid, we need to attach to the child. This uses the `ps` tool to get it
                    -- It takes a bit for the child to arrive. This uses the `vim.wait` function to wait up to a second
                    -- to get the child pid.
                    vim.wait(1000, function()
                        return tonumber(vim.fn.system("ps -o pid= --ppid " .. tostring(ppid))) ~= nil
                    end)
                    local pid = tonumber(vim.fn.system("ps -o pid= --ppid " .. tostring(ppid)))

                    -- If we found it, spawn another debug session that attaches to the pid.
                    if pid then
                        dap.run({
                            name = "Neovim embedded",
                            type = "cppdbg",
                            request = "attach",
                            processId = pid,
                            -- ⬇️ Change paths as needed
                            program = vim.g._project_home .. "/build/bin/nvim",
                            args = {"-u", "NONE"},
                            cwd = vim.g._project_home,
                            externalConsole = false,
                        })
                    end
                end

                return config
            end
        }
    )
}

-- dap.configurations.c = {
--     {
--         name = "Launch Neovim",
--         type = "cppdbg",
--         request = "launch",
--         program = function()
--             return vim.g._project_home .. "/build/bin/nvim"
--         end,
--         cwd = vim.g._project_home,
--         externalConsole = true,
--     }
-- }



-- Reference: https://zignar.net/2023/02/17/debugging-neovim-with-neovim-and-nvim-dap/
local dap = require("dap")
dap.defaults.fallback.external_terminal = {
    command = "/bin/konsole";
    args = {"-e"},
}
EOF

" " Reference: https://stackoverflow.com/a/18734557
" let g:_project_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
"
" lua << EOF
" local dap = require("dap")
"
" dap.configurations.c = {
"   {
"     name = "Neovim",
"
"     -- ⬇️ References the `cppdbg` in the `dap.adapters.cppdbg` definition
"     type = "cppdbg",
"
"     -- ⬇️ Used to indicate that this should launch a process
"     request = "launch",
"
"     -- ⬇️ The program we want to debug, the path to the `nvim` binary in this case
"     -- Make sure it's built with debug symbols
"     program = "/full/path/to/neovim/build/bin/nvim",
"     program = function()
"         return vim.g._project_home .. "/build/bin/nvim"
"     end,
"
"     -- ⬇️ Requires `external_terminal` configuration
"     externalConsole = true,
"   },
" }
" EOF
```
