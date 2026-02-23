local texthl = require('custom.statusbar.utils').texthl
local button = require('custom.statusbar.utils').button
local format_fize = require('custom.statusbar.utils').format_fize
local hl = require('custom.statusbar.constants').hl_groups.file_name
local icons = grvim.statusbar.icons

--------------------------------- [ btn onclick function ] ---------------------------
vim.cmd([[
   function! ToggleFileName(a,b,c,d)
      lua require('custom.statusbar.function_btn').toggle_file_name()
   endfunction
]])

------------------------------------ [ functions ] ------------------------------------
local file_size = function()
   local icon = icons.separator.arrow.right

   local fname = vim.api.nvim_buf_get_name(0)
   local fsize = vim.fn.getfsize(fname)
   local str = string.format('%s', format_fize(fsize))

   if fsize > 0 then return texthl(hl.subText, icon .. str) end

   return ''
end

local file_icon = function()
   local fileIcon = icons.others.empty
   local fileIconColor = '#A6D189'
   local filename = (vim.fn.expand('%') == '' and 'Empty ') or vim.fn.expand('%:t')
   local extension = vim.fn.expand('%:e')

   if filename ~= 'Empty ' then
      local ok_devicons, devicons = pcall(require, 'nvim-web-devicons')

      if ok_devicons then
         local deviIcon, deviColor = devicons.get_icon_color(filename, extension)

         fileIcon = (deviIcon ~= nil and deviIcon) or ''
         fileIconColor = deviColor
      end
   end

   vim.api.nvim_set_hl(0, hl.iconFtColor, { fg = fileIconColor })

   return texthl(hl.iconFtColor, ' ' .. fileIcon .. ' ')
end

return function()
   local fileName = (vim.fn.expand('%') == '' and 'Empty ') or vim.fn.expand('%:t')

   local str = texthl(hl.text, fileName)

   ---@type string
   local finalStr

   if vim.g.s_filename_is_active then
      finalStr = file_icon() .. str .. file_size()
   else
      finalStr = file_icon() .. str
   end

   return button(finalStr, 'ToggleFileName')
end
