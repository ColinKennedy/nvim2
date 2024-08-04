local api = vim.api
local cmd = vim.cmd
local fn = vim.fn

--- Documentation
--- Quickfix and Location list management for Neovim.
---
--- This plugin allows easier use of the builtin lists for wrapping navigation,
--following, toggling, and much more.
--
---@tag qf.nvim

---@class List
---@field auto_close boolean Close the list if empty
---@field auto_follow string|boolean Follow current entries. Possible strategies: prev,next,nearest or false to disable
---@field auto_follow_limit number limit the distance for the auto follow
---@field follow_slow boolean debounce following to `updatetime`
---@field auto_open boolean Open list on QuickFixCmdPost, e.g; grep
---@field auto_resize boolean Grow or shrink list according to items
---@field max_height number Auto resize max height
---@field min_height number Auto resize min height
---@field wide boolean Open list at the very bottom of the screen
---@field number boolean Show line numbers in window
---@field relativenumber boolean Show relative line number in window
---@field unfocus_close boolean Close list when parent window loses focus
---@field focus_open boolean Pair with `unfocus_close`, open list when parent window focuses
local list_defaults = {
  auto_close = true,
  auto_follow = "prev",
  auto_follow_limit = 8,
  follow_slow = true,
  auto_open = true,
  auto_resize = true,
  max_height = 8,
  min_height = 5,
  wide = false,
  number = false,
  relativenumber = false,
  unfocus_close = false,
  focus_open = false,
}

---@tag qf.config
---@class Config
---@field c List
---@field l List
---@field close_other boolean Close other list kind on open. If location list opens, qf closes, and vice-versa..
---@field pretty boolean Use a pretty printed format function for the quickfix lists.
local defaults = {
  c = list_defaults,
  l = list_defaults,
  close_other = true,
  pretty = true,
  -- signs = {
  --   E = { hl = "DiagnosticSignError", sign = "" },
  --   W = { hl = "DiagnosticSignWarn", sign = "" },
  --   I = { hl = "DiagnosticSignInfo", sign = "" },
  --   N = { hl = "DiagnosticSignHint", sign = "" },
  --   T = { hl = "DiagnosticSignHint", sign = "" },
  -- },
}

local qf = { config = defaults }

local util = require("my_custom.utilities.quick_fix_movement_utilities")

local fix_list = util.fix_list
local list_items = util.list_items
local get_height = util.get_height

local function istrue(val)
  return val == true or val == "1"
end

local function message_verbose(verbose, msg, level)
  if istrue(verbose) ~= false then
    vim.notify(msg, level)
  end
end

local function check_empty(list, num_items, verbose)
  if num_items == 0 then
    if list == "c" then
      message_verbose(verbose, "Quickfix list empty", vim.log.levels.ERROR)
    else
      message_verbose(verbose, "Location list empty", vim.log.levels.ERROR)
    end

    return false
  end
  return true
end

local get_list = util.get_list
qf.get_list_win = util.get_list_win

--- Open the `quickfix` or `location` list
--- If stay == true, the list will not be focused
--- If auto_close is true, the list will be closed if empty, similar to cwindow
---@param list string
---@param stay boolean|nil
---@tag qf.open() Qopen Lopen
function qf.open(list, stay, silent)
  list = fix_list(list)

  local opts = qf.config[list]
  local num_items = get_list(list, { size = 1 }).size

  -- Auto close
  if not check_empty(list, num_items, not silent) then
    if opts and opts.auto_close then
      cmd(list .. "close")
      return
    end
    return
  end

  if qf.config.close_other then
    if list == "c" then
      local wininfo = fn.getwininfo()
      for _, win in ipairs(wininfo) do
        if win.loclist == 1 then
          api.nvim_win_close(win.winid, false)
        end
      end
    elseif list == "l" then
      cmd("cclose")
    end
  end

  local win = util.get_list_win(list)
  if win ~= 0 then
    if not istrue(stay) then
      api.nvim_set_current_win(win)
    end
    return
  end
  cmd(list .. "open " .. get_height(list, qf.config))

  if istrue(stay) then
    cmd("wincmd p")
  end
end

local function linelen(bufnr, lnum)
  if not api.nvim_buf_is_valid(bufnr) then
    return 0
  end
  return #(api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)[1] or "")
end

local is_valid = util.is_valid

-- Returns the list entry currently previous to the cursor
---@param list string
---@param include_current boolean
---@return Item|nil
local function follow_prev(list, include_current)
  local pos = util.get_pos()
  local items = util.sorted_list_items(list)
  if #items == 0 then
    return nil
  end

  local compare_pos = util.compare_pos
  local found_buf = false

  for i = 1, #items do
    local j = #items - i + 1
    local item = items[j]
    local ord = compare_pos(item, pos)

    -- We overshot the current buffer
    if item.bufnr == pos.bufnr then
      found_buf = true
    end
    -- If the current entry is past cursor, of the entry of the cursor has been
    -- passed
    item.col = math.min(item.col, linelen(item.bufnr, item.lnum))
    if found_buf and (ord == -1 or (include_current and ord == 0)) then
      return item
    end
  end

  return nil
end

-- Returns the first entry after the cursor in buf or the first entry in the
-- buffer
---@param list string
---@param include_current boolean
---@return Item|nil
local function follow_next(list, include_current)
  local pos = util.get_pos()
  local items = util.sorted_list_items(list)
  if #items == 0 then
    return nil
  end

  local compare_pos = util.compare_pos
  for _, item in ipairs(items) do
    local ord = compare_pos(item, pos)
    -- We overshot the current buffer
    -- If the current entry is past cursor, of the entry of the cursor has been
    -- passed
    item.col = math.min(item.col, linelen(item.bufnr, item.lnum))
    if ord == 1 or (include_current and ord == 0) then
      return item
    end
  end

  return nil
end

local function goto_entry(list, index)
  local silent = qf.config.silent and "silent" or ""
  local command = list == "c" and "cc" or "ll"

  cmd(string.format("%s %s %d", silent, command, index))
end

---comment
---@param items Item[]
---@param start number
---@param direction number
---@param func fun(item: Item): boolean
---@param wrap boolean
---@return Item|nil
local function seek_entry(items, start, direction, func, wrap)
  --- Find next valid
  if direction == 1 then
    for i = start, #items do
      local item = items[i]
      if func(item) then
        return item
      end
    end

    if wrap then
      local items = vim.tbl_filter(func, items)
      local first = items[1]

      return first
    end
  elseif direction == -1 then
    -- for i = #items - start + 1, #items do
    --   local j = #items - i + 1
    for i = start, 1, -1 do
      local item = items[i]
      assert(item)
      if func(item) then
        return item
      end
    end

    if wrap then
      local items = vim.tbl_filter(func, items)
      local last = items[#items]

      return last
    end
  else
    error("Invalid direction " .. direction)
  end
end

--- Wrapping version of [lc]next. Also takes into account valid entries.
--- If wrap is nil or true, it will wrap around the list
---@tag qf.next() Qnext Lnext
---@tag qf.prev() Qnext Lnext
function qf.nav(list, wrap, verbose, dir)
  if wrap == nil then
    wrap = true
  end
  list = fix_list(list)

  local info = get_list(list, { items = 1, idx = 0 })

  local item = seek_entry(info.items, info.idx + dir, dir, is_valid, wrap)
  if item then
    goto_entry(list, item.idx)
  elseif verbose then
    api.nvim_err_writeln("No valid entry found")
  end
end

--- Wrapping version of [lc]above
--- Will switch buffer
---@tag qf.above() Qabove Labove Vabove
function qf.above(list, wrap, verbose)
  if wrap == nil then
    wrap = true
  end

  list = fix_list(list)

  local item = follow_prev(list, false)

  if not item then
    check_empty(list, 0, verbose)
    return
  end

  goto_entry(list, item.idx)
end

--- Wrapping version of [lc]below
--- Will switch buffer
---@tag qf.below() Qbelow Lbelow Vbelow
function qf.below(list, wrap, verbose)
  if wrap == nil then
    wrap = true
  end
  list = fix_list(list)

  local item = follow_next(list, false)

  if not item then
    check_empty(list, 0, verbose)
    return
  end

  goto_entry(list, item.idx)
end

---@class SetOpts
---@field items table
---@field lines table
---@field cwd string
---@field compiler string|nil
---@field winid number|nil
---@field title string|nil
---@field tally boolean|nil
---@field open boolean|string|nil if "auto", open if there are errors
---@field save boolean|nil saves the previous list

--- Set location or quickfix list items
--- If a compiler is given, the items will be parsed from it
--- Invalidates follow cache
---@param list string
---@param opts SetOpts
function qf.set(list, opts)
  list = fix_list(list)

  if opts.save then
    qf.save(list, nil)
  end

  local old_c = vim.b.current_compiler

  local old_efm = vim.opt.efm

  local old_makeprg = vim.o.makeprg
  local old_cwd = fn.getcwd()

  if opts.cwd then
    api.nvim_set_current_dir(opts.cwd)
  end

  if opts.compiler ~= nil then
    vim.cmd("compiler! " .. opts.compiler)
  else
  end
  if opts.lines == nil and opts.items == nil then
    vim.notify("Missing either opts.lines or opts.items in qf.set()", vim.log.levels.ERROR)
  end

  if list == "c" then
    vim.fn.setqflist({}, "r", {
      title = opts.title,
      items = opts.items,
      lines = opts.lines,
    })
  else
    vim.fn.setloclist(opts.winid or 0, {}, "r", {
      title = opts.title,
      items = opts.items,
      lines = opts.lines,
    })
  end

  vim.b.current_compiler = old_c
  vim.opt.efm = old_efm
  vim.o.makeprg = old_makeprg
  if old_c ~= nil then
    vim.cmd("compiler " .. old_c)
  end

  qf.config[list].last_line = nil

  if opts.cwd then
    api.nvim_set_current_dir(old_cwd)
  end

  if
    opts.open == true
    or (opts.open == "auto" and util.tally(util.get_list(list, { items = 1 }, opts.winid).items).error > 0)
  then
    qf.open(list, true, true)
  end
end

--- Sort the items according to file -> line -> column
---@tag qf.sort() Qsort Lsort Vsort
function qf.sort(list)
  list = fix_list(list)
  local items = list_items(list, true)
  table.sort(items, function(a, b)
    a.fname = a.fname or fn.bufname(a.bufnr)
    b.fname = b.fname or fn.bufname(b.bufnr)

    if not is_valid(a) then
      a.text = "invalid"
    end
    if not is_valid(b) then
      b.text = "invalid"
    end

    if a.fname == b.fname then
      if a.lnum == b.lnum then
        return a.col < b.col
      else
        return a.lnum < b.lnum
      end
    else
      return a.fname < b.fname
    end
  end)

  qf.set(list, { items = items })
end

return qf
