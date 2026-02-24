local icons = grvim.statuscol.icons

return function()
   if vim.fn.eval('foldlevel(v:lnum) > foldlevel(v:lnum - 1)') == 1 then
      if vim.fn.eval('foldclosed(v:lnum) == -1') == 1 then
         return '%#FoldSignsClosed#' .. icons.caret_right .. '%T'
      else
         return '%#FoldSignsOpen#' .. icons.caret_down .. '%T'
      end
   end

   local space_void = ' '
   return space_void .. '%T'
end
