local texthl = require('custom.statusbar.utils').texthl
local button = require('custom.statusbar.utils').on_click

--------------------------------- [ btn onclick function ] ---------------------------
vim.cmd([[
   function! ToggleTheme(a,b,c,d)
      lua require('custom.statusbar.function_btn').toggleTheme()
   endfunction
]])

------------------------------------ [ functions ] ------------------------------------
return function()
   local icon_dark = ' 󰖨 '
   -- genera icono de luna con relleno
   local icon_light = '  '

   local mode = vim.g.gr_theme_mode or 'dark'

   ---@type string
   local str
   if mode == 'dark' then
      str = texthl('GrBarThemeDark', icon_dark)
   else
      str = texthl('GrBarThemeLight', icon_light)
   end
   return button(str, 'ToggleTheme')
end
