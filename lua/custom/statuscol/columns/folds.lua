local trimPad = require('custom.statuscol.utils').trimAndPad
local icons = grvim.statuscol.icons

return function()
   local icon_right = trimPad(icons.caret_right, 2)
   local icon_down = trimPad(icons.caret_down, 2)

   if vim.fn.eval('foldlevel(v:lnum) > foldlevel(v:lnum - 1)') == 1 then
      if vim.fn.eval('foldclosed(v:lnum) == -1') == 1 then
         return '%#FoldSignsClosed#' .. icon_right .. '%T'
      else
         return '%#FoldSignsOpen#' .. icon_down .. '%T'
      end
   end

   local space_void = '  '
   return space_void .. '%T'
end
