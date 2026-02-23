local button = require('custom.statusbar.utils').button
local txt = require('custom.statusbar.utils').texthl
local hl = require('custom.statusbar.constants').hl_groups.cursor_position
local percent_bar = grvim.statusbar.icons.percent_bar
local separator = require('custom.statusbar.utils').separator()

--------------------------------- [ btn onclick function ] ---------------------------
vim.cmd([[
   function! TogglePosition(a,b,c,d)
      lua require('custom.statusbar.function_btn').position()
   endfunction
]])

------------------------------------ [ functions ] ------------------------------------
local positionX = function()
   local str = 'X:%2c'
   return txt(hl.textBold, str)
end

local positionY = function()
   local position = ' Y:%2l/%2L '
   return txt(hl.textBold, position)
end

local iconPercen = function()
   local icon_percent = percent_bar
   local curr_line = vim.api.nvim_win_get_cursor(0)[1]
   local lines = vim.api.nvim_buf_line_count(0)
   local i = math.floor((curr_line - 1) / lines * #icon_percent) + 1
   local str = string.rep(icon_percent[i], 2)

   return txt(hl.iconPositionBar, str)
end

return function()
   ---@type string
   local str

   if vim.g.s_position_is_active then
      str = positionX() .. positionY() .. iconPercen()
   else
      str = positionX()
   end

   return separator .. button(str, 'TogglePosition') .. ' '
end
