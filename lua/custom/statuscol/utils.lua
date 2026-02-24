local M = {}

---@param hl string
---@param str string
---@return string
M.texthl = function(hl, str)
   str = str or ''
   local a = '%#' .. hl .. '#' .. str .. '%*'
   return a
end

---@param str string
---@return string
M.trim = function(str) return str:match('^%s*(.-)%s*$') or '' end

---@param str string
---@param len? 2 | 3
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

---@param tbl1 table
---@param tbl2 table
---@return table<string>
M.combineTable = function(tbl1, tbl2)
   local unique_set = {}

   -- Agregar elementos de la primera tabla
   if tbl1 and type(tbl1) == 'table' then
      for _, value in ipairs(tbl1) do
         if type(value) == 'string' then unique_set[value] = true end
      end
   end

   -- Agregar elementos de la segunda tabla
   if tbl2 and type(tbl2) == 'table' then
      for _, value in ipairs(tbl2) do
         if type(value) == 'string' then unique_set[value] = true end
      end
   end

   -- Crear una tabla de resultados a partir del conjunto
   local result = {}
   for value in pairs(unique_set) do
      table.insert(result, value)
   end

   return result
end

return M
