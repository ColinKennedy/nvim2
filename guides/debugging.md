## Debugging
### Set And View Trace Logs
Need help figuring out why debugging isn't working?

:help dap.set_log_level

```
lua require("dap").set_log_level("TRACE")
lua print(vim.fn.stdpath('cache') .. "/dap.log")  -- ~/.cache/nvim/dap.log
```

Use this to show verbose messages on why the debugger doesn't start.


### Debugging Remotely - Houdini
#### Setup
- Create a houdini environment that includes the code that you want to debug
  remotely + [debugpy](https://github.com/microsoft/debugpy)
    - Install debugpy as a PyPI package: https://pypi.org/project/debugpy
- Load houdini
- In Houdini's python shell, call this:
```python
import debugpy;debugpy.listen(("127.0.0.1", 5678))
# or
import debugpy;debugpy.listen(5678)
```

("127.0.0.1", 5678) is a standard address + port pair. Remember that, you'll need it later


##### Debugging Remotely - Houdini - nvim-dap handshake
- Load nvim-dap in as an "attach" request with the same host + port number
    - References
        - Using https://github.com/mfussenegger/nvim-dap-python
        - From scratch - https://github.com/microsoft/debugpy/wiki/Command-Line-Reference#example-2-working-with-remote-code-or-code-running-in-docker-container
- Set a breakpoint on the code that you want to debug. This code is pressumably also available for import, in Houdini
- In houdini, run the code that, when executed, would trigger that breakpoint
```python
import sys;sys.path.append("/home/selecaoone/temp");import debug_test_houdini;debug_test_houdini.main()
```

If it all worked as expected, nvim-dap should have stopped Houdini's execution
at the breakpoint and dropped you into a point where you can debug from within
neovim.


#### Debugging Remotely - Best Practices
When working with a remote process, you may find that you cannot restart / stop
the debugger without calling the debugee. To be honest there might be a better
way to do this but I figured out a way to be able to re-run debugging without
accidentally killing the debugee. Here's how:

- Do the debug session as you normall would
- After you `:DapContinue` past the point where the code you were attempting to
  run executes ... DO NOT attempt to stop or restart the debugger
- Instead, run `:lua require("dap").restart({terminateDebugee=false})` or `<leader>d=`
  - This does do things
    1. It releases the "hold" that the debugger has on the debugee, allowing
       the debugee to go back to normal and exist the debug session without
       getting killed.
    2. The debugger now needs to "re-attach" to the debugee again, which we do in the next step
- Re-enter the debugger (using `:DapContinue`)
- Now go back to the debugee (e.g. Houdini)
- Re-run the script that you want to debug again
- Voila, you've done it


### Debugging References
- Useful Microsoft launch / attach information - https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
- More Microsoft documentation, very beginner friendly - https://github.com/microsoft/debugpy/wiki/Command-Line-Reference#example-2-working-with-remote-code-or-code-running-in-docker-container
- "out of the box" remote server attach, for Python - https://github.com/mfussenegger/nvim-dap-python
- Remote server attach documentation - https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
- Manual setup and bindings - https://github.com/mfussenegger/nvim-dap/wiki/Cookbook


- Possibly useful (didn't need to read it since the other links worked)
    - https://marioyepes.com/setup-debug-php-docker-visual-studio-code/#start-a-debugging-session
    - https://github.com/mfussenegger/nvim-dap/wiki/Local-and-Remote-Debugging-with-Docker#Python
    - https://alpha2phi.medium.com/neovim-for-beginners-python-remote-debugging-7dac13e2a469
