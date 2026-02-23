vim.cmd.highlight('clear')
vim.g.colors_name = 'gr-theme'

-- Obtener la hora actual (formato 24h)
local current_hour = tonumber(os.date('%H'))
-- Determinar el modo según la hora
local default_mode
if current_hour >= 7 and current_hour < 18 then
   default_mode = 'light' -- De 7:00 a 17:59
else
   default_mode = 'dark' -- De 18:00 a 6:59
end

-- SOLO establecer si NO existe (valor por defecto)
vim.g.gr_theme_mode = vim.g.gr_theme_mode or default_mode
--------------------------------------------------------------------------------

---@param name string Nombre del módulo (ej: 'editor', 'syntax')
---@param type? 'default' | 'integration'
local load_highlight = function(name, type)
   local groups
   local path = 'custom.gr-theme.modules.'

   if type == 'default' then
      groups = require(path .. name)
   else
      groups = require(path .. 'integrations.' .. name)
   end

   -- -- HACK: descomponer todo groups y armarlo en colors_styles
   for group_name, values in pairs(groups) do
      local colors_styles = {}

      for key, val in pairs(values) do
         -- si existe 'fg', o 'bg' o 'sp' se agrega a la tabla
         if key == 'fg' or key == 'bg' or key == 'sp' then
            colors_styles[key] = val
         elseif key == 'style' then
            for _, style in ipairs(values.style) do
               -- se agregan todos los estilos a la tabla 'colores_styles' como ' = true'
               -- evalua si el estilo comienza con '!' para negar el estilo
               local is_positive = style:sub(1, 1) ~= '!'
               local style_name = is_positive and style or style:sub(2) -- Quitar '!' si es negativo
               -- colors_styles[style_name] = is_positive
               if is_positive then
                  colors_styles[style_name] = true -- Añadir estilo
               else
                  colors_styles[style_name] = nil -- Eliminar completamente el estilo
               end
            end
         end
      end

      vim.api.nvim_set_hl(0, group_name, colors_styles)
   end
end

local load = function()
   load_highlight('editor', 'default')
   load_highlight('syntax', 'default')
   load_highlight('treesitter', 'default')
   load_highlight('lsp', 'default')
   load_highlight('statusbar', 'default')

   load_highlight('gitsigns')
   load_highlight('bufferline')
   -- load_highlight('cmp')
   load_highlight('blink_cmp')
   load_highlight('nvimtree')
   load_highlight('indent_blankline')
   load_highlight('mason')
   load_highlight('lazy')
   load_highlight('headlines') -- markdown
   load_highlight('noice')
   load_highlight('others')
end

local function reload()
   -- 1. Limpiar TODOS los módulos del theme de la caché
   for module in pairs(package.loaded) do
      if type(module) == 'string' and module:match('^custom%.gr%-theme') then package.loaded[module] = nil end
   end

   -- 2. Forzar recarga
   vim.cmd.highlight('clear')
   require('custom.gr-theme').load()

   -- 3. Avisar a otros plugins de que el tema ha cambiado
   vim.cmd('doautocmd ColorScheme')
   vim.cmd('HighlightColors On') -- plugin  brenoprata10/nvim-highlight-colors

   -- 4. Avisar al user
   vim.notify('🎨 Tema recargado', vim.log.levels.INFO)
end

local palette = require('custom.gr-theme.palette_manager').get_palette()

return { load = load, palette = palette, reload = reload }
