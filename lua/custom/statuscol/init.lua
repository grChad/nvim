local config_default = require('custom.statuscol.constants')
local selectBool = require('custom.statuscol.utils').selectBool
local combineTable = require('custom.statuscol.utils').combineTable

-- Columnas (se cargan bajo demanda)
local columns = {
   diagnostics = require('custom.statuscol.columns.diagnostics'),
   numbers = require('custom.statuscol.columns.numbers'),
   folds = require('custom.statuscol.columns.folds'),
   git = require('custom.statuscol.columns.git'),
}

local M = {}

-- Función principal que construye el statuscolumn DINÁMICAMENTE
function M.build()
   local win = vim.g.statusline_winid
   local parts = {}

   local order = { 'diagnostics', 'numbers', 'folds', 'git' }

   for _, col_name in ipairs(order) do
      local col = columns[col_name]
      if col then
         local result
         if col_name == 'numbers' then
            result = col(win) -- numbers espera win
         else
            result = col() -- otras columnas esperan ctx
         end
         if result and result ~= '' then table.insert(parts, result) end
      end
   end

   return table.concat(parts)
end

---@class GrStatusColumn
---@field disabled_ft table<string>?
---@field disabled boolean?

---@param userTable? GrStatusColumn
function M.setup(userTable)
   userTable = userTable or {}
   local is_disabled = selectBool(userTable.disabled, config_default.disabled)
   local disabled_ft = combineTable(userTable.disabled_ft, config_default.disabled_ft)

   if is_disabled then return end

   local name_group = 'GrStatusColumn'
   vim.api.nvim_create_augroup(name_group, { clear = true })

   -- Autocomando que aplica el statuscolumn a todos los filetype
   vim.api.nvim_create_autocmd('FileType', {
      group = name_group,
      pattern = '*',
      callback = function()
         -- Aqui se aplica el statuscolumn a todos los filetype
         vim.opt_local.statuscolumn = "%!v:lua.require('custom.statuscol').build()"
      end,
   })

   -- Autocomando para quitar el statuscolumn cuando el filetype este en disabled_ft
   vim.api.nvim_create_autocmd('FileType', {
      group = name_group,
      pattern = disabled_ft,
      callback = function() vim.opt_local.statuscolumn = '' end,
   })
end

return M
