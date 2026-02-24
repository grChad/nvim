return function(win)
   local is_num = vim.wo[win].number
   local is_relnum = vim.wo[win].relativenumber

   if is_num and is_relnum then
      return '%=%{v:relnum?(v:virtnum>0?"":v:relnum):(v:virtnum>0?"":v:lnum)} '
   elseif is_num and not is_relnum then
      return '%=%{v:virtnum>0?"":v:lnum} '
   elseif is_relnum and not is_num then
      return '%=%{v:virtnum>0?"":v:relnum} '
   end
   return ''
end
