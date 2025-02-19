return {
   {
      'grChad/statusbar.nvim',
      dev = true,
      lazy = false,
      config = function()
         require('grbar').setup({
            user = { name = 'Gabriel' },
            ia = {
               supermaven = { enabled = true, icon = ' ' },
            },
         })
      end,
   },

   {
      'akinsho/bufferline.nvim',
      version = '*',
      lazy = false,
      cmd = { 'BufferLinePick', 'BufferLineCycleNext', 'BufferLineCyclePrev' },
      keys = require('core.key_plugins').bufferline,
      config = function()
         ---@type ColorsTheme
         local color = require('theme-nvim').pallete

         require('bufferline').setup({
            options = {
               offsets = {
                  {
                     filetype = 'NvimTree',
                     text = 'Explorador de Archivos',
                     text_align = 'center', -- 'left' | 'center' | 'right',
                     separator = false,
                  },
               },
               hover = { enabled = true, delay = 200, reveal = { 'close' } },
            },
            highlights = {
               buffer_visible = { fg = color.whiteSmoke },
               buffer_selected = { fg = color.white, bold = false, italic = false },
               close_button = { fg = color.red_1 },
               close_button_visible = { fg = color.red_1 },
               close_button_selected = { fg = color.red_1 },
               pick_selected = { fg = color.orange_1, bold = true, italic = false },
               pick_visible = { fg = color.orange_1, bold = true, italic = false },
               pick = { fg = color.orange_1, bold = true, italic = false },
               modified = { fg = color.yellow, bg = color.dark },
               modified_visible = { fg = color.yellow },
               modified_selected = { fg = color.yellow },
            },
         })
      end,
   },

   {
      'b0o/incline.nvim',
      event = 'BufReadPre',
      priority = 1200,
      config = function()
         require('incline').setup({
            highlight = {
               groups = {
                  InclineNormal = { guibg = '#000000', guifg = '#EEFFFF' },
                  InclineNormalNC = { guibg = '#000000', guifg = '#EEFFFF' },
               },
            },
            window = { margin = { vertical = 1, horizontal = 1 } },
            hide = { cursorline = true, focused_win = true },
            render = function(props)
               local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')

               local icon, color = require('nvim-web-devicons').get_icon_color(filename)
               return { { icon, guifg = color }, { ' ' }, { filename } }
            end,
         })
      end,
   },

   {
      'lukas-reineke/indent-blankline.nvim',
      lazy = false,
      main = 'ibl',
      config = function()
         -- NOTE: los highlight groups se crean en el theme [ 'grChad/theme-custom' ]
         -- stylua: ignore
         local Indent_hightlight = {
            'Ibl_RainbowRed', 'Ibl_RainbowYellow', 'Ibl_RainbowBlue', 'Ibl_RainbowOrange',
            'Ibl_RainbowGreen', 'Ibl_RainbowViolet', 'Ibl_RainbowCyan',
         }

         -- stylua: ignore
         local scope_highlights = {
            'Ibl_RainbowRedScope', 'Ibl_RainbowYellowScope', 'Ibl_RainbowBlueScope',
            'Ibl_RainbowOrangeScope', 'Ibl_RainbowGreenScope', 'Ibl_RainbowVioletScope',
            'Ibl_RainbowCyanScope',
         }

         require('ibl').setup({
            indent = { highlight = Indent_hightlight, char = '▏', tab_char = '▏' },
            scope = { highlight = scope_highlights },
         })
      end,
   },

   { -- Para ver los simbolos y la posicion de las variables y funciones en una barra lateral
      'hedyhli/outline.nvim',
      lazy = true,
      cmd = { 'Outline', 'OutlineOpen' },
      keys = require('core.key_plugins').outline,
      opts = {
         -- Your setup opts here
      },
   },
}
