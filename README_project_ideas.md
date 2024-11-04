- ninja feet
- async parser
- lua-busted profiler

https://stackoverflow.com/questions/15725744/easy-lua-profiling
http://lua-users.org/wiki/ProfilingLuaCode
https://thejacklawson.com/2013/06/lua-unit-testing-with-busted/index.html




## Profiler Stuff
https://www.reddit.com/r/neovim/comments/1ge6rty/comment/luhshnp/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
https://www.speedscope.app/
https://github.com/nvim-lua/plenary.nvim/blob/2d9b06177a975543726ce5c73fca176cedbffe9d/lua/plenary/profile.lua#L5




Starting point - https://github.com/lunarmodules/busted/blob/master/busted/runner.lua

it seems tests are ran though this? - https://github.com/lunarmodules/busted/blob/master/busted/block.lua#L134-L161

I wonder if this is useful? Or maybe the whole file? https://github.com/lunarmodules/busted/blob/master/busted/core.lua#L209-L224

Maybe timing information can be included via subscription? https://github.com/lunarmodules/busted/blob/94d008108b028817534047b44fdb1f7f7ca0dcc3/spec/export_spec.lua#L63

there's a ticktime / duration in busted, already
https://github.com/lunarmodules/busted/blob/94d008108b028817534047b44fdb1f7f7ca0dcc3/busted/core.lua#L209-L224
https://github.com/search?q=repo%3Alunarmodules%2Fbusted%20duration%20&type=code



Possibly useful - subscribing - https://github.com/lunarmodules/busted/blob/94d008108b028817534047b44fdb1f7f7ca0dcc3/spec/export_spec.lua#L63

describe block definition - https://github.com/lunarmodules/busted/blob/94d008108b028817534047b44fdb1f7f7ca0dcc3/busted/init.lua#L12


Possibly the information is accessible via an output handler?
https://github.com/lunarmodules/busted/blob/94d008108b028817534047b44fdb1f7f7ca0dcc3/busted/outputHandlers/base.lua#L80

The backend for busted? https://github.com/Olivine-Labs/mediator_lua/blob/master/src/mediator.lua

Use this as reference! - https://github.com/hishamhm/busted-htest/blob/master/src/busted/outputHandlers/htest.lua
 - base - https://github.com/lunarmodules/busted/blob/94d008108b028817534047b44fdb1f7f7ca0dcc3/busted/outputHandlers/base.lua

Apparently one is able to specify an output handler using
https://github.com/lunarmodules/busted/blob/94d008108b028817534047b44fdb1f7f7ca0dcc3/spec/cl_spec.lua#L265
    local success, errcnt = executeBusted('--pattern=cl_success.lua$ --output=busted.outputHandlers.TAP')

Possibly related - https://github.com/lunarmodules/busted/blob/94d008108b028817534047b44fdb1f7f7ca0dcc3/busted-scm-1.rockspec#L87

https://github.com/leinlin/Miku-LuaProfiler


https://www.speedscope.app/


https://github.com/geoffleyland/luatrace
 - no flame
https://github.com/ImagicTheCat/ELProfiler
 - no flame


https://github.com/leinlin/Miku-LuaProfiler


information on profiling LuaJIT - https://luajit.org/ext_profiler.html


http://lua-users.org/wiki/ProfilingLuaCode


## Profilers With Flamegraphs
https://github.com/stevearc/profile.nvim
https://github.com/nvim-lua/plenary.nvim#plenaryprofile



## Flame Graphs
https://github.com/brendangregg/FlameGraph
https://ui.perfetto.dev

