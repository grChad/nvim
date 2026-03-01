local M = {}

---@param hl string
---@param str string
---@return string
M.texthl = function(hl, str)
   str = str or ''
   local a = '%#' .. hl .. '#' .. str
   return a
end

---@param str_hl string
---@param func string
---@param arg? integer
---@return string
M.on_click = function(str_hl, func, arg)
   arg = arg or 0
   local arg_str = string.format('%s', arg)

   return '%' .. arg_str .. '@' .. func .. '@' .. str_hl .. '%X'
end

---@return string
M.separator = function()
   local str = grvim.statusbar.icons.separator.line
   local hl_separator = 'S_Separator'

   return M.texthl(hl_separator, str)
end

---@return string
M.space = function() return M.texthl('S_Separator', ' ') end

---@param str_user? string
---@param str_default string
---@return string
M.selectStr = function(str_user, str_default)
   if str_user == nil then
      return str_default
   elseif str_user == '' then
      return str_default
   elseif type(str_user) ~= 'string' then
      return str_default
   end
   return str_user
end

---@param icon_user? string
---@param icon_default string
M.selectIcon = function(icon_user, icon_default)
   if icon_user and type(icon_user) == 'string' then
      if #icon_user >= 1 and #icon_user <= 4 then return M.trimAndPad(icon_user, 2) end
   end

   return icon_default
end

---@param color? string
M.isHex = function(color)
   if type(color) ~= 'string' then return false end

   -- Patrón: # seguido de 3 o 6 caracteres hexadecimales
   return color:match('^#%x%x%x$') or color:match('^#%x%x%x%x%x%x$') ~= nil
end

---@param name string
---@param opts {fg?: string, bg?: string, sp?: string}  -- Solo los que quieras cambiar
M.update_hl = function(name, opts)
   local current = vim.api.nvim_get_hl(0, { name = name }) or {}

   vim.api.nvim_set_hl(0, name, vim.tbl_extend('keep', opts, current))
end

---@param table_user? table
---@param table_default table
---@return table
M.selectTable = function(table_user, table_default)
   if table_user == nil then
      return table_default
   elseif type(table_user) ~= 'table' then
      return table_default
   end
   return table_user
end

---@param bool_use? boolean
---@param bool_default boolean
---@return boolean
M.selectBool = function(bool_use, bool_default)
   if bool_use == nil then
      return bool_default
   elseif type(bool_use) ~= 'boolean' then
      return bool_default
   end
   return bool_use
end

---@param str string
---@return string
M.trim = function(str) return str:match('^%s*(.-)%s*$') or '' end

---@alias TrimAndPadOpts 2 | 3
---@param str string
---@param len TrimAndPadOpts
---@return string
M.trimAndPad = function(str, len)
   str = M.trim(str)

   if len == 2 then
      return str .. ' '
   elseif len == 3 then
      return ' ' .. str .. ' '
   else
      return str
   end
end

---@param icon string
---@param status integer
---@return string
M.gitStatusAndPad = function(icon, status)
   local blank = ''
   if status == nil then
      return blank
   elseif status == 0 then
      return blank
   end
   return M.trimAndPad(icon, 3) .. status
end

---@param fsize integer
M.format_fize = function(fsize)
   -- stackoverflow, compute human readable file size
   local suffix = grvim.statusbar.suffix_file_size

   fsize = (fsize < 0 and 0) or fsize

   if fsize < 1024 then return fsize .. suffix[1] end

   local i = math.floor((math.log(fsize) / math.log(1024)))

   return string.format('%.2g%s', fsize / math.pow(1024, i), suffix[i + 1])
end

return M
