local texthl = require('custom.statusbar.utils').texthl
local button = require('custom.statusbar.utils').button
local space = require('custom.statusbar.utils').space()
local trimAndPad = require('custom.statusbar.utils').trimAndPad
local hl = require('custom.statusbar.constants').hl_groups.ia
local icon_ia = grvim.statusbar.icons.ia_icon

--------------------------------- [ btn onclick function ] ---------------------------
vim.cmd([[
   function! ToggleIaAssistant(a,b,c,d)
      lua require('custom.statusbar.function_btn').assistant()
   endfunction
]])

------------------------------------ [ functions ] ------------------------------------
return function()
   local status_ok, api = pcall(require, 'supermaven-nvim.api')
   if not status_ok then return '' end

   local showIcon

   if api.is_running() then
      showIcon = texthl(hl.assistant, trimAndPad(icon_ia, 2))
   else
      showIcon = texthl(hl.subText, trimAndPad(icon_ia, 2))
   end

   return space .. button(showIcon, 'ToggleIaAssistant')
end
