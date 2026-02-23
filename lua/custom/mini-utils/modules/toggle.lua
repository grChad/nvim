local list_toggles = require('custom.mini-utils.constants').list_toggles
local toggle_map = {}

-- Función para generar pares de toggle
local function generate_toggles(loop_list)
   for i = 1, #loop_list do
      local current = loop_list[i]
      local next_val = loop_list[i + 1] or loop_list[1]

      -- Versión original
      toggle_map[current] = next_val

      -- Versión todo MAYÚSCULAS (solo si no son números)
      if not current:match('^%d') then toggle_map[current:upper()] = next_val:upper() end

      -- Versión Primera letra mayúscula (solo si tiene letras)
      if current:match('%a') then
         toggle_map[current:sub(1, 1):upper() .. current:sub(2):lower()] = next_val:sub(1, 1):upper()
            .. next_val:sub(2):lower()
      end
   end
end

-- Iterar sobre cada lista en list_toggles
for _, toggle_list in ipairs(list_toggles) do
   generate_toggles(toggle_list)
end

return function()
   local under_cursor = vim.fn.expand('<cword>')

   -- Buscar en el mapa
   local replacement = toggle_map[under_cursor]

   if replacement then
      vim.cmd('normal! ciw' .. replacement)
      return
   end
end
