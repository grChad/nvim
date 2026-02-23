local M = {}

local NS = vim.api.nvim_create_namespace('search')

-- Configuración
local config = {
   blink_time = 100, -- ms de parpadeo
   hl_group = 'IncSearch', -- grupo para resaltar
   virt_text_hl = 'HlSearchCustom', -- grupo para texto virtual
}

M.run = function()
   vim.api.nvim_buf_clear_namespace(0, NS, 0, -1)

   -- Obtener patrón de búsqueda actual
   local search_pattern = vim.fn.getreg('/')
   if search_pattern == '' then return end

   -- Limpiar el patrón para mostrar (quitar escapes innecesarios para visualización)
   local display_pattern = search_pattern:gsub('\\<', ''):gsub('\\>', '')

   -- Resaltar todas las ocurrencias
   local ok, match_id = pcall(vim.fn.matchadd, config.hl_group, '\\c\\%#' .. search_pattern)
   if not ok then return end

   vim.cmd('redraw')
   vim.cmd('sleep ' .. config.blink_time .. 'm') -- Breve pausa para mostrar el resaltado

   -- Obtener estadísticas de búsqueda
   local search_count = vim.fn.searchcount({ recompute = true })

   -- Solo mostrar si hay resultados
   if search_count.total and search_count.total > 0 then
      local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
      local virt_text = string.format(' %s [ %d / %d ] ', display_pattern, search_count.current, search_count.total)

      vim.api.nvim_buf_set_extmark(0, NS, current_line, 0, {
         virt_text = { { virt_text, config.virt_text_hl } },
         virt_text_pos = 'eol',
      })
   end

   -- Limpiar resaltado temporal
   pcall(vim.fn.matchdelete, match_id)
   vim.cmd('redraw')
end

M.clear = function()
   vim.api.nvim_buf_clear_namespace(0, NS, 0, -1)

   vim.cmd('nohlsearch')
end

return M
