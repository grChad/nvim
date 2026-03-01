local hl = require('custom.statusbar.constants').hl_groups.user
local utils = require('custom.statusbar.utils')
local user_icon = grvim.statusbar.icons.others.user

--------------------------------- [ btn onclick function ] ---------------------------
vim.cmd([[
   function! ShowUser(a,b,c,d)
      lua require('custom.statusbar.function_btn').showUser()
   endfunction
]])

------------------------------------ [ functions ] ------------------------------------
---@param confUser GrConfigUser
return function(confUser)
   local config = confUser or {}
   local name = utils.selectStr(config.name, 'Patroclo')
   local icon = utils.selectIcon(config.icon, user_icon)
   local color_icon = config.color_icon

   if utils.isHex(color_icon) then utils.update_hl('S_UserIcon', { fg = color_icon }) end

   local icon_os = utils.texthl(hl.userIcon, icon)
   local user_name = utils.texthl(hl.text, name)

   ---@type string
   local str
   if vim.g.s_show_user then
      str = icon_os .. user_name
   else
      str = icon_os
   end

   return utils.on_click(str, 'ShowUser') .. ' '
end
