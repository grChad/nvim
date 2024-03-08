return {
   { -- barra de estado
      'grChad/statusStatic',
      dev = true,
      lazy = false,
      config = function()
         require('status-static').setup()
      end,
   },

   {
      'akinsho/bufferline.nvim',
      version = '*',
      lazy = false,
      config = function()
         require('bufferline').setup()
      end,
   },

   -- FIXME: problemas con Flutter: buffers para debugs
   -- {
   --    'grChad/bufferSplitSimple',
   --    dev = true,
   --    lazy = false,
   --    config = function()
   --       require('buffer-split-simple').setup()
   --    end,
   -- },

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

   { -- mini Lsp progress
      'j-hui/fidget.nvim',
      event = 'VeryLazy',
      opts = {},
   },

   -- NOTE: ver su utilidad y tratar de reemplazarlo
   {
      'kevinhwang91/nvim-ufo',
      dependencies = { 'kevinhwang91/promise-async' },
   },
   { -- Para ver los simbolos y la posicion de las variables y funciones en una barra lateral
      'hedyhli/outline.nvim',
      lazy = true,
      cmd = { 'Outline', 'OutlineOpen' },
      keys = { -- Example mapping to toggle outline
         { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
      },
      opts = {
         -- Your setup opts here
      },
   },
}
