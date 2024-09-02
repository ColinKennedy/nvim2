-- Copyright (c) 2020-2021 shadmansaleh
-- MIT license, see LICENSE for more details.
local M = {}

-- Note for now only works for termguicolors scope can be bg or fg or any other
-- attr parameter like bold/italic/reverse
---@param color_group string hl_group name
---@param scope       string bg | fg | sp
---@return table|string returns #rrggbb formatted color when scope is specified
----                       or complete color table when scope isn't specified
function M.extract_highlight_colors(color_group, scope)
  local color = require('lualine.highlight').get_lualine_hl(color_group)
  if not color then
    if vim.fn.hlexists(color_group) == 0 then
      return nil
    end
    color = vim.api.nvim_get_hl_by_name(color_group, true)
    if color.background ~= nil then
      color.bg = string.format('#%06x', color.background)
      color.background = nil
    end
    if color.foreground ~= nil then
      color.fg = string.format('#%06x', color.foreground)
      color.foreground = nil
    end
    if color.special ~= nil then
      color.sp = string.format('#%06x', color.special)
      color.special = nil
    end
  end
  if scope then
    return color[scope]
  end
  return color
end

--- retrieves color value from highlight group name in syntax_list
--- first present highlight is returned
---@param scope string|table
---@param syntaxlist table
---@param default string
---@return string|nil
function M.extract_color_from_hllist(scope, syntaxlist, default)
  scope = type(scope) == 'string' and { scope } or scope
  for _, highlight_name in ipairs(syntaxlist) do
    if vim.fn.hlexists(highlight_name) ~= 0 then
      local color = M.extract_highlight_colors(highlight_name)
      for _, sc in ipairs(scope) do
        if color.reverse then
          if sc == 'bg' then
            sc = 'fg'
          else
            sc = 'bg'
          end
        end
        if color[sc] then
          return color[sc]
        end
      end
    end
  end
  return default
end

return M
