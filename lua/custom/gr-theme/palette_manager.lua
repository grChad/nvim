---@class Palette
---@field rosewater string
---@field flamingo string
---@field pink string
---@field mauve string
---@field red string
---@field tomato string
---@field maroon string
---@field peach string
---@field yellow string
---@field gold string
---@field orange string
---@field green string
---@field teal string
---@field sky string
---@field sapphire string
---@field blue string
---@field lavender string
---@field text string
---@field textvar string
---@field textparam string
---@field subtext1 string
---@field subtext0 string
---@field overlay2 string
---@field overlay1 string
---@field overlay0 string
---@field surface2 string
---@field surface1 string
---@field surface0 string
---@field base string
---@field mantle string
---@field crust string
---@field selected string

local M = {}

---@return Palette
function M.get_palette()
   local mode = vim.g.gr_theme_mode or 'dark'

   return require('custom.gr-theme.themes.' .. mode)
end

return M
