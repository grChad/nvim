local group_custom = function(valor, table_hl)
   return {
      type = 'group',
      val = {
         {
            type = 'text',
            val = valor,
            opts = { position = 'center', hl = table_hl },
         },
      },
   }
end

-- Crear botón para teclas iniciales.
--- @param key string
--- @param txt string
--- @param cmd string | (fun(): nil)
local function create_button(key, txt, cmd)
   local opts = {
      position = 'center',
      text = txt,
      shortcut = key,
      cursor = 4,
      width = 25,
      align_shortcut = 'right',
      hl_shortcut = 'AlphaButtonKey',
      hl = 'AlphaButtonHL',
   }

   if cmd then opts.keymap = { 'n', key, cmd, { noremap = true, silent = true } } end

   return {
      type = 'button',
      val = txt,
      on_press = function()
         local _key = vim.api.nvim_replace_termcodes(key, true, false, true)
         vim.api.nvim_feedkeys(_key, 'normal', false)
      end,
      opts = opts,
   }
end

local Logo = {
   '                  ████████                       ██',
   '                 █████ ███                       ███ ',
   '                  ███      ███                       ███ ',
   '██████    ███ ███      ███                       ███ ',
   '██████  ████ ███    ███████████████████████ ',
   '  █████ ███ ███      ███   ███  ████  ████ ',
   '       ██ ███  █████ ███   ███  ████  ████ ',
   ' ███████████  █████████ ███████████████',
}

-- Mandar estos colores al Theme
vim.api.nvim_set_hl(0, 'LogoHL', { fg = '#88DBDB', bold = true })

--- @return string
local get_date = function()
   local capitalized = function(my_string) return string.upper(string.sub(my_string, 1, 1)) .. string.sub(my_string, 2) end

   local day = capitalized(tostring(os.date('%A')))
   local month = capitalized(tostring(os.date('%B')))

   return ' ' .. day .. os.date(' %d de ') .. month .. os.date('  -   %R')
end

local function footer()
   local v = vim.version()
   local plugins_lazy = require('lazy').plugins()
   local value_str = 'NeoVim v%d.%d.%d -  %d Plugins'

   return string.format(value_str, v.major, v.minor, v.patch, #plugins_lazy) .. ' | by · @grchad 󰊤'
end

local layout = {}

-- Solo ejecutar si Alpha carga -- solo si no hay archivos para leer
local argc = vim.fn.argc()
if argc == 0 then
   local header = {
      type = 'text',
      val = Logo,
      opts = { position = 'center', hl = 'LogoHL' },
   }

   local fecha_actual = group_custom(get_date(), {
      { 'CalendaryColor', 0, 4 },
      { 'Text', 4, 50 },
   })

   local buttons = {
      type = 'group',
      val = {
         create_button('w', '󰈭  Find Word', function() Snacks.picker.grep({ exclude = { 'node_modules' } }) end),
         create_button(
            'f',
            '󰱼  Find File',
            function() Snacks.picker.files({ exclude = { 'node_modules' }, hidden = true, ignored = false }) end
         ),
         create_button('r', '  Recent File', function() Snacks.picker.recent() end),
         create_button('b', '  Bookmarks', function() Snacks.picker.marks() end),
         create_button('u', '  Update', '<cmd>Lazy sync<cr>'),
         -- button('s', '  Abrir session reciente', '<cmd>SessionManager load_current_dir_session<CR>'),
         create_button('q', '󰗼  Quit!', '<cmd>qall!<cr>'),
      },
      opts = {
         spacing = 1,
         position = 'center',
      },
   }

   local the_footer = group_custom(footer(), {
      { 'BlueColor', 0, 3 },
      { 'GreenColor', 3, 6 },
      { 'Text', 7, 60 },
   })

   -- Manejador de centrado para Alpha
   local ol = { -- líneas ocupadas
      icon = #header.val, -- número de líneas del header
      message = #the_footer.val, -- padding inferior
      length_buttons = #buttons.val * 2 - 1, -- botones ocuparán
      padding_between = 3, -- padding entre teclas y header
   }

   local terminal_height = vim.api.nvim_win_get_height(0)
   local left_terminal_value = terminal_height - (ol.length_buttons + ol.message + ol.padding_between + ol.icon)

   -- Si hay suficiente espacio en pantalla
   if left_terminal_value >= 0 then
      local top_padding = math.floor(left_terminal_value / 2)
      local bottom_padding = left_terminal_value - top_padding

      layout = {
         { type = 'padding', val = top_padding },
         header,
         { type = 'padding', val = 1 },
         fecha_actual,
         { type = 'padding', val = 1 },
         buttons,
         the_footer,
         { type = 'padding', val = bottom_padding },
      }
   else
      -- Si no hay espacio, configuración mínima
      layout = {
         { type = 'padding', val = 1 },
         fecha_actual,
         { type = 'padding', val = 1 },
         buttons,
         the_footer,
         { type = 'padding', val = 1 },
      }
   end
else
   -- Cuando se abre con archivos, Alpha vacío
   layout = {}
end

return {
   'goolord/alpha-nvim',
   event = 'VimEnter',
   dependencies = { 'nvim-tree/nvim-web-devicons' },
   init = function()
      local def_highlight = vim.api.nvim_set_hl

      -- Mandar estos colores al Theme
      def_highlight(0, 'CalendaryColor', { fg = '#FF875F' })
      def_highlight(0, 'BlueColor', { fg = '#0F85EF' })
      def_highlight(0, 'GreenColor', { fg = '#66AF3D' })

      def_highlight(0, 'AlphaButtonHL', { fg = '#01B2CB', italic = true })
      def_highlight(0, 'AlphaButtonKey', { fg = '#01B2CB', bold = true })
   end,
   config = function()
      local status_ok, alpha = pcall(require, 'alpha')

      if not status_ok then return end

      alpha.setup({
         layout = layout,
         opts = {
            margin = 0,
            redraw_on_resize = true,
         },
      })

      vim.api.nvim_create_augroup('alpha_custom', { clear = true })

      -- Al entrar a Alpha: ocultar barra de estado y tabline
      vim.api.nvim_create_autocmd('FileType', {
         group = 'alpha_custom',
         pattern = 'alpha',
         callback = function()
            vim.opt_local.laststatus = 0 -- Sin barra de estado
            vim.opt_local.showtabline = 0 -- Sin tabline
            vim.opt_local.number = false -- Sin números de línea
            vim.opt_local.relativenumber = false
            vim.opt_local.signcolumn = 'no' -- Sin signcolumn
         end,
      })

      -- Al salir de Alpha: restaurar barra de estado y tabline
      vim.api.nvim_create_autocmd('BufUnload', {
         group = 'alpha_custom',
         pattern = '*',
         callback = function(args)
            if vim.bo[args.buf].ft == 'alpha' then
               vim.schedule(function()
                  vim.opt.laststatus = 3 -- Restaurar barra de estado global
                  vim.opt.showtabline = 2 -- Restaurar tabline
                  vim.opt.number = true -- Restaurar números
                  vim.opt.relativenumber = true
                  vim.opt.signcolumn = 'yes' -- Restaurar signcolumn
               end)
            end
         end,
      })
   end,
}
