local api = vim.api
local bit = require("bit")
-----------------------------------------------------------
-- Export
-----------------------------------------------------------
local M = {}
-----------------------------------------------------------
-- Helpers
-----------------------------------------------------------
---Convert a hex color to an rgb color
---@param color string
---@return number
---@return number
---@return number
local function to_rgb(color)
    return tonumber(color:sub(2, 3), 16), tonumber(color:sub(4, 5), 16), tonumber(color:sub(6), 16)
end

-- luacheck: ignore 631
--- Shade `color` according to `percent`.
---
--- References:
---     https://stackoverflow.com/questions/5560248/programmatically-lighten-or-darken-a-hex-color-or-rgb-and-blend-colors
---     https://stackoverflow.com/questions/37796287/convert-decimal-to-hex-in-lua-4
---
--- @param color string hex color
--- @param percent number
--- @return string
function M.shade_color(color, percent)
    local r, g, b = to_rgb(color)
    -- If any of the colors are missing return "NONE" i.e. no highlight
    if not r or not g or not b then
        return "NONE"
    end
    r = math.floor(tonumber(r * (100 + percent) / 100) or 0)
    g = math.floor(tonumber(g * (100 + percent) / 100) or 0)
    b = math.floor(tonumber(b * (100 + percent) / 100) or 0)
    r, g, b = r < 255 and r or 255, g < 255 and g or 255, b < 255 and b or 255

    return "#" .. string.format("%02x%02x%02x", r, g, b)
end

--- Determine whether to use black or white text
--- Ref:
--- 1. https://stackoverflow.com/a/1855903/837964
--- 2. https://stackoverflow.com/a/596243
function M.color_is_bright(hex)
    if not hex then
        return false
    end
    local r, g, b = to_rgb(hex)
    -- If any of the colors are missing return false
    if not r or not g or not b then
        return false
    end
    -- Counting the perceptive luminance - human eye favors green color
    local luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255
    -- If luminance is > 0.5 -> Bright colors, black font else Dark colors, white font
    return luminance > 0.5
end

function M.get_color_from_number(value)
    return "#" .. bit.tohex(value, 6)
end

--- Get hex color
---@param name string highlight group name
---@param attribute string attr name 'bg', 'fg'
---@return string
function M.get_hex(name, attribute)
    local ok, highlight = pcall(function()
        return api.nvim_get_hl(0, { name = name })
    end)
    if not ok then
        return "NONE"
    end

    local number = highlight[attribute]

    if not number then
        return "NONE"
    end

    return string.format("#%06x", number)
end

--- Check if background is bright
--- @return boolean
function M.is_bright_background()
    local bg_color = M.get_hex("Normal", "bg")
    return M.color_is_bright(bg_color)
end

-----------------------------------------------------------
-- Darken Terminal
-----------------------------------------------------------

local function convert_attributes(result, key, value)
    local target = result
    if key == "cterm" then
        result.cterm = {}
        target = result.cterm
    end
    if value:find(",") then
        for _, v in vim.split(value, ",") do
            target[v] = true
        end
    else
        target[value] = true
    end
end

local function convert_options(opts)
    local keys = {
        gui = true,
        guifg = "foreground",
        guibg = "background",
        guisp = "sp",
        cterm = "cterm",
        ctermfg = "ctermfg",
        ctermbg = "ctermbg",
        link = "link",
    }

    ---@type table<string | boolean, string>
    local result = {}

    for key, value in pairs(opts) do
        if keys[key] then
            if key == "gui" or key == "cterm" then
                if value ~= "NONE" then
                    convert_attributes(result, key, value)
                end
            else
                result[keys[key]] = value
            end
        end
    end
    return result
end

--- Find `attribute` in one of `highlights`.
---
---@param attribute string
---    The name of the attribute to check. e.g. `"fg"`, `"bg"`, etc.
---    @see vim.api.keyset.get_hl_info
---@param highlights string[]
---    All of the Neovim higlight groups to search within, recursively.
---@param namespace integer?
---    Get highlight groups for namespace ns_id `nvim_get_namespaces()`.
---    Use 0 to get global highlight groups `:highlight`.
---
function M.get_highlight_attribute_data(attribute, highlights, namespace)
    namespace = namespace or 0
    local found = true

    for _, name in ipairs(highlights) do
        local current = vim.api.nvim_get_hl(namespace, { name = name })
        local previous = current

        while true do
            if current[attribute] then
                found = true

                break
            end

            if not current.link then
                break
            end

            previous = current
            current = vim.api.nvim_get_hl(namespace, { name = current.link })
        end

        if found then
            return previous[attribute]
        end
    end

    return nil
end

function M.set_hl(name, opts)
    api.nvim_set_hl(0, name, convert_options(opts))
end

return M
