local texthl = require('custom.statusbar.utils').texthl
local button = require('custom.statusbar.utils').button
local trimPad = require('custom.statusbar.utils').trimAndPad
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

---@param filename string
local file_icon = function(filename)
   local fileIcon = icons.others.empty
   local extension = vim.fn.expand('%:e')

   if filename == 'Empty' then return texthl(hl.subText, trimPad(fileIcon, 3)) end

   ---@type string
   local fg_color_icon
   local ok_devicons, devicons = pcall(require, 'nvim-web-devicons')

   if ok_devicons then
      local deviIcon, deviColor = devicons.get_icon_color(filename, extension)

      fileIcon = (deviIcon ~= nil and deviIcon) or ''
      fg_color_icon = deviColor
   end
   vim.api.nvim_set_hl(0, hl.iconFtColor, { fg = fg_color_icon })

   return texthl(hl.iconFtColor, trimPad(fileIcon, 3))
end

return function()
   local file_name = (vim.fn.expand('%') == '' and 'Empty') or vim.fn.expand('%:t') -- '' -> Empty

   local file_name_hl = texthl(hl.text, file_name)
   local file_icon_hl = file_icon(file_name)
   local file_size_hl = file_size()

   ---@type string
   local finalStr

   if vim.g.s_filename_is_active then
      finalStr = file_icon_hl .. file_name_hl .. file_size_hl
   else
      finalStr = file_icon_hl .. file_name_hl
   end

   return button(finalStr, 'ToggleFileName')
end
