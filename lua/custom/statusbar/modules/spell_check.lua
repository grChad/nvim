local hl = require('custom.statusbar.constants').hl_groups.spell_check
local texthl = require('custom.statusbar.utils').texthl
local button = require('custom.statusbar.utils').on_click

--------------------------------- [ btn onclick function ] ---------------------------
vim.cmd([[
   function! ToggleSpellCheck(a,b,c,d)
      lua require('custom.statusbar.function_btn').toggle_spell()
   endfunction
]])

------------------------------------ [ functions ] ------------------------------------
return function()
   local icon_spell = '  '

   ---@type string
   local str
   if vim.g.s_show_spell then
      vim.opt.spelllang = { 'en', 'es', 'cjk' } -- Establecer idiomas en ese orden
      vim.opt.spellsuggest = 'best,9' -- Muestra las 9 mejores opciones de correccion.
      vim.opt.spelloptions = 'camel' -- Para que no muestre error ortografico en los CamelCase

      str = texthl(hl.spell, icon_spell)
   else
      str = texthl(hl.subText, icon_spell)
   end
   return button(str, 'ToggleSpellCheck')
end
