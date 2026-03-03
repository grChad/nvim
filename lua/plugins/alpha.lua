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

-- local logo_futuro = {
--    '                  ████████                       ██',
--    '                 █████ ███                       ███ ',
--    '                  ███      ███                          ',
--    '██████    ███ ███     ███                       ███ ',
--    '██████  ███ ███    █████ ████████████████ ',
--    '  █████ ███ ███      ███   ███  ████  ████ ',
--    '      ██ ███  █████ ███   ███ ████ ████ ',
--    ' ███████████ ███████  ███████████████',
-- }

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

--- @return string
local get_date = function()
   local capitalized = function(my_string) return string.upper(string.sub(my_string, 1, 1)) .. string.sub(my_string, 2) end

   local day = capitalized(tostring(os.date('%A')))
   local month = capitalized(tostring(os.date('%B')))

   return ' ' .. day .. os.date(' %d de ') .. month .. os.date('  -    %R')
end

local function footer()
   local v = vim.version()
   local plugins_lazy = require('lazy').plugins()
   local value_str = 'NeoVim v%d.%d.%d -  %d Plugins'

   return string.format(value_str, v.major, v.minor, v.patch, #plugins_lazy) .. ' | by · @grchad 󰊤'
end

local header_logo = {
   type = 'text',
   val = Logo,
   opts = { position = 'center', hl = 'AlphaHeaderLogo' },
}

local fecha_actual = group_custom(get_date(), {
   { 'AlphaHeaderCalendary', 0, 4 },
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
   { 'AlphaFooterLetterNeo', 0, 3 },
   { 'AlphaFooterLetterVim', 3, 6 },
   { 'Text', 7, 60 },
})

-- Manejador de altura para elementos del Alpha
local ol = {
   logo_height = #header_logo.val + 1, -- número de líneas del header mas un padding_botton
   calendary_height = #fecha_actual.val + 1, -- Altura del calendario mas un padding_botton
   buttons_height = #buttons.val * 2, -- Altura de los botones y ya deja un padding_botton
   footer_height = #the_footer.val, -- padding inferior
}

local TOTAL_CONTENT_HEIGHT = ol.logo_height + ol.calendary_height + ol.buttons_height + ol.footer_height
local CONTENT_LIGHT = TOTAL_CONTENT_HEIGHT - ol.logo_height

-- ┌─────────────────────────┐
-- │      showtabline        │ ← 0 líneas -> Deshabilitado
-- ├─────────────────────────┤
-- │------ top_padding ------│ ← Espacio calculado
-- ├─────────────────────────┤
-- │         LOGO            │ ← ol.logoHeight (8 líneas)
-- ├─────────────────────────┤
-- │------ padding: 1 -------│
-- ├─────────────────────────┤
-- │        FECHA            │ ← 1 línea
-- ├─────────────────────────┤
-- │------ padding: 1 -------│
-- ├─────────────────────────┤
-- │       BOTONES           │ ← ol.buttonsHeight (11 líneas)
-- ├─────────────────────────┤
-- │------ padding: 1 -------│
-- ├─────────────────────────┤
-- │        FOOTER           │ ← ol.message (1 línea)
-- ├─────────────────────────┤
-- │---- bottom_padding -----│ ← Espacio calculado por defecto
-- ├─────────────────────────┤
-- │      statusline         │ ← 0 líneas -> Deshabilitado
-- │       cmdline           │
-- └─────────────────────────┘

local LayoutScreen = function(height)
   local available_space_full = height - TOTAL_CONTENT_HEIGHT
   local available_space_light = height - CONTENT_LIGHT
   local top_padding_full = math.floor(available_space_full / 2 + 1)
   local top_padding_light = math.floor(available_space_light / 2 + 1)

   if available_space_full >= 0 then
      return {
         { type = 'padding', val = top_padding_full },
         header_logo,
         { type = 'padding', val = 1 },
         fecha_actual,
         { type = 'padding', val = 1 },
         buttons,
         -- buttons ya incluye el padding bottons.opts.spacing
         the_footer,
      }
   else
      if top_padding_light > 0 then
         return {
            { type = 'padding', val = top_padding_light },
            fecha_actual,
            { type = 'padding', val = 1 },
            buttons,
            the_footer,
         }
      end
      -- Si no hay espacio, configuración mínima
      return {
         { type = 'padding', val = 1 },
         buttons,
      }
   end
end

local function get_alpha_window()
   for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == 'alpha' then return win end
   end
   return nil
end

return {
   'goolord/alpha-nvim',
   event = 'VimEnter',
   dependencies = { 'nvim-tree/nvim-web-devicons' },
   config = function()
      local status_ok, alpha = pcall(require, 'alpha')
      local argc = vim.fn.argc()

      -- Salir si: 1) Alpha falla al cargar, O 2) hay archivos al abrir
      if not status_ok or argc ~= 0 then return end

      local function refresh_alpha()
         local alpha_win = get_alpha_window()
         local height = alpha_win and vim.api.nvim_win_get_height(alpha_win) or vim.fn.winheight(0)

         alpha.setup({
            layout = LayoutScreen(height),
            opts = { margin = 0, redraw_on_resize = true },
         })

         alpha.redraw()
      end

      refresh_alpha() -- Inicializar

      vim.api.nvim_create_augroup('alpha_custom', { clear = true })

      -- Al entrar a Alpha: ocultar barra de estado y tabline y columna de signos
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

      vim.api.nvim_create_autocmd({ 'VimResized', 'WinResized', 'WinNew', 'WinClosed' }, {
         group = 'alpha_custom',
         callback = function()
            -- Verificar si Alpha está abierto en alguna ventana
            local has_alpha_open = false
            for _, win in ipairs(vim.api.nvim_list_wins()) do
               local buf = vim.api.nvim_win_get_buf(win)
               if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == 'alpha' then
                  has_alpha_open = true
                  break
               end
            end

            -- También check si el buffer actual es Alpha
            local current_is_alpha = vim.bo.filetype == 'alpha'

            if has_alpha_open or current_is_alpha then
               vim.defer_fn(function() refresh_alpha() end, 30) -- Delay para estabilización del layout
            end
         end,
      })

      -- Al salir de Alpha: restaurar barra de estado y tabline y columna de signos
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
