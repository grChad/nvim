return {
   -- icons

   { -- barra de estado

      -- dir = '~/Escritorio/lua/statusStatic',
      'grChad/statusStatic',
      lazy = false,
      dependencies = { 'grChad/icons-nvim' },
      config = function()
         require('status-static').setup()
      end,
   },

   {
      'akinsho/bufferline.nvim',
      version = '*',
      lazy = false,
      config = function()
         vim.opt.termguicolors = true
         require('bufferline').setup()
      end,
   },

   -- FIXME: problemas con Flutter: buffers para debugs
   {
      'grChad/bufferSplitSimple',
      lazy = false,
      config = function()
         require('buffer-split-simple').setup()
      end,
   },

   {
      'lukas-reineke/indent-blankline.nvim',
      lazy = false,
      main = 'ibl',
      opts = {
         indent = { highlight = 'IndentBlanklineChar', char = '▏', tab_char = '▏' },
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

   {
      'stevearc/dressing.nvim',
      lazy = true,
      init = function()
         ---@diagnostic disable-next-line: duplicate-set-field
         vim.ui.select = function(...)
            require('lazy').load({ plugins = { 'dressing.nvim' } })
            return vim.ui.select(...)
         end
         ---@diagnostic disable-next-line: duplicate-set-field
         vim.ui.input = function(...)
            require('lazy').load({ plugins = { 'dressing.nvim' } })
            return vim.ui.input(...)
         end
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
      dependencies = 'kevinhwang91/promise-async',
      config = function()
         vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
         vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
         vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      end,
   },
}
