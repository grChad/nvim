local hl = require('custom.statusbar.constants').hl_groups.user
local texthl = require('custom.statusbar.utils').texthl
local button = require('custom.statusbar.utils').button
local trimAndPad = require('custom.statusbar.utils').trimAndPad
local user_icon = grvim.statusbar.icons.others.user

--------------------------------- [ btn onclick function ] ---------------------------
vim.cmd([[
   function! ShowUser(a,b,c,d)
      lua require('custom.statusbar.function_btn').showUser()
   endfunction
]])

------------------------------------ [ functions ] ------------------------------------
return function()
   local icon = user_icon
   local name = 'Patricio'

   local icon_os = texthl(hl.userIcon, trimAndPad(icon, 2))
   local user_name = texthl(hl.text, name)

   ---@type string
   local str
   if vim.g.s_show_user then
      str = icon_os .. user_name
   else
      str = icon_os
   end

   return button(str, 'ShowUser') .. ' '
end
