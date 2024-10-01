return {
   {
      'grChad/statusbar.nvim',
      dev = true,
      lazy = false,
      config = function()
         require('grbar').setup({
            -- background = '#07196F',
            -- foreground = '#DFDFDF',
            -- sub_foreground = '#838383',
            -- separator_color = '#FAFFC6',
            -- mode_style = 'foreground', -- 'foreground' | 'background'
            user = {
               -- enabled = true,
               -- icon = ' ',
               -- color_icon = ' ',
               name = 'Gabriel',
            },
            ia = {
               supermaven = {
                  enabled = true,
                  icon = ' ',
                  --    color_icon = '#13e2de',
               },
               -- codeium = {
               --    enabled = true,
               --    -- icon = '',
               --    -- color_icon = '',
               -- },
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
         require('bufferline').setup({
            options = {
               offsets = {
                  {
                     filetype = 'NvimTree',
                     text = 'File Explorer',
                     text_align = 'center', -- 'left' | 'center' | 'right',
                     separator = false,
                  },
               },
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
      opts = {
         indent = { highlight = 'IndentBlanklineChar', char = '▏', tab_char = '▏' },
         -- indent = { char = '▏', tab_char = '▏' },
         -- scope = { highlight = 'IndentBlanklineContextChar' },
         scope = { enabled = false },
      },
   },

   {
      'echasnovski/mini.indentscope',
      version = false, -- wait till new 0.7.0 release to put it back on semver
      lazy = false,
      opts = { symbol = '▏' },
      config = function(_, opts)
         vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'help', 'alpha', 'neo-tree', 'NvimTree', 'noice', 'lazy', 'lspinfo', '' },
            callback = function()
               vim.b.miniindentscope_disable = true
            end,
         })
         require('mini.indentscope').setup(opts)
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
