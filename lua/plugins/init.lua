local default_plugins = {
   { 'nvim-lua/plenary.nvim' },

   { -- dashboard
      'goolord/alpha-nvim',
      lazy = false,
      config = function()
         require('plugins.configs.alpha_config').setup()
      end,
   },
   { -- Theme
      'grChad/theme-custom',
      -- dir = '~/Escritorio/lua/theme-custom',
      lazy = false,
      priority = 1000, -- el tema tiene la prioridad mas alta.
      config = function()
         require('theme-nvim').load_theme()
      end,
   },

   {
      'grChad/icons-nvim',
      -- dir = '~/Escritorio/lua/icons-nvim',
      lazy = true,
   },

   { -- barra del buffer
      'romgrk/barbar.nvim',
      lazy = false,
      init = function()
         require('core.utils').load_mappings('barbar')
         vim.g.barbar_auto_setup = false
      end,
      opts = require('plugins.configs.barbar'),
   },

   { -- barra de estado
      'grChad/statusStatic',
      -- dir = '~/Escritorio/lua/statusStatic',
      lazy = false,
      config = function()
         require('status-static').setup()
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
      'NvChad/nvterm',
      init = function()
         require('core.utils').load_mappings('nvterm')
      end,
      config = true,
   },

   {
      'NvChad/nvim-colorizer.lua',
      init = function()
         require('core.utils').lazy_load('nvim-colorizer.lua')
      end,
      config = function()
         require('plugins.configs.others').colorizer()
      end,
   },

   {
      'themaxmarchuk/tailwindcss-colors.nvim',
      priority = 900,
      config = function()
         require('tailwindcss-colors').setup()
      end,
   },

   { 'KabbAmine/vCoolor.vim',       priority = 800, lazy = false }, -- color picker
   { 'ggandor/lightspeed.nvim',     lazy = false },         -- search words

   { 'nvim-tree/nvim-web-devicons', lazy = true },

   {
      'echasnovski/mini.surround',
      version = '*',
      lazy = false,
      opts = require('plugins.configs.others').mini_surround,
   },

   { -- se complementa con indent_blankline
      'echasnovski/mini.indentscope',
      event = 'BufReadPost',
      config = function()
         require('plugins.configs.others').indent_mini()
      end,
   },

   {
      'lukas-reineke/indent-blankline.nvim',
      lazy = false,
      init = function()
         require('core.utils').lazy_load('indent-blankline.nvim')
         require('core.utils').load_mappings('blankline')
         vim.cmd([[let g:indent_blankline_context_char='▏']])
      end,
      opts = require('plugins.configs.others').blankline,
   },

   {
      'nvim-treesitter/nvim-treesitter',
      init = function()
         require('core.utils').lazy_load('nvim-treesitter')
      end,
      cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
      build = ':TSUpdate',
      dependencies = {
         { 'JoosepAlviste/nvim-ts-context-commentstring' },
         { 'windwp/nvim-ts-autotag' },
         { 'nvim-treesitter/playground' },
         {
            'm-demare/hlargs.nvim',
            config = function()
               require('hlargs').setup({
                  highlight = { fg = '#EEFFFF', italic = true },
               })
            end,
         },
      },
      opts = function()
         return require('plugins.configs.treesitter')
      end,
      config = function(_, opts)
         require('nvim-treesitter.configs').setup(opts)
      end,
   },

   -- git stuff
   {
      'lewis6991/gitsigns.nvim',
      ft = { 'gitcommit', 'diff' },
      init = function()
         require('core.utils').lazy_load('gitsigns.nvim')
      end,
      opts = require('plugins.configs.others').gitsigns,
      config = true,
   },

   -- lsp stuff
   {
      'williamboman/mason.nvim',
      cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
      opts = function()
         return require('plugins.configs.mason')
      end,
      config = function(_, opts)
         require('mason').setup(opts)

         vim.api.nvim_create_user_command('MasonInstallAll', function()
            vim.cmd('MasonInstall ' .. table.concat(opts.ensure_installed, ' '))
         end, {})

         vim.g.mason_binaries_list = opts.ensure_installed
      end,
   },

   {
      'neovim/nvim-lspconfig',
      dependencies = {
         {
            'jose-elias-alvarez/null-ls.nvim',
            config = function()
               require('plugins.lsp.null')
            end,
         },
      },
      init = function()
         require('core.utils').lazy_load('nvim-lspconfig')
      end,
      config = function()
         require('plugins.lsp.setup')
      end,
   },

   { 'jose-elias-alvarez/typescript.nvim' }, -- for tsserver
   {
      'dart-lang/dart-vim-plugin',
      ft = 'dart',
      config = function()
         vim.cmd([[
         let dart_html_in_string=v:true
         let g:dart_style_guide = 2
         let g:dart_format_on_save = 1
         let g:dart_trailing_comma_indent = v:true
         ]])
      end,
   },

   {
      'akinsho/flutter-tools.nvim',
      ft = 'dart',
      config = function()
         require('plugins.configs.flutterTools')
      end,
   },

   -- load luasnips + cmp related in insert mode only
   {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
         {
            'L3MON4D3/LuaSnip', -- snippet plugin
            dependencies = 'rafamadriz/friendly-snippets',
            opts = { history = true, updateevents = 'TextChanged,TextChangedI' },
            config = function(_, opts)
               require('plugins.configs.others').luasnip(opts)
            end,
         },

         {
            'windwp/nvim-autopairs', -- autopairing of (){}[] etc
            lazy = true,
            event = 'InsertEnter',
            config = function()
               require('plugins.configs.others').autopairs()
            end,
         },

         {
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'FelipeLema/cmp-async-path',
            'hrsh7th/cmp-emoji',
         },
      },
      config = function()
         require('plugins.configs.cmp')
      end,
   },

   {
      'Exafunction/codeium.vim',
      lazy = false,
      config = function()
         -- Change '<C-g>' here to any keycode you like.
         vim.keymap.set('i', '<C-i>', function()
            return vim.fn['codeium#Accept']()
         end, { expr = true })
         vim.keymap.set('i', '<c-;>', function()
            return vim.fn['codeium#CycleCompletions'](1)
         end, { expr = true })
         vim.keymap.set('i', '<c-,>', function()
            return vim.fn['codeium#CycleCompletions'](-1)
         end, { expr = true })
         vim.keymap.set('i', '<C-c>', function()
            return vim.fn['codeium#Clear']()
         end, { expr = true })
      end,
   },

   {
      'Wansmer/treesj',
      lazy = true,
      cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' },
      keys = {
         { 'gJ', '<cmd>TSJToggle<CR>', desc = 'Toggle Split/Join' },
      },
      config = function()
         require('treesj').setup({
            use_default_keymaps = false,
         })
      end,
   },

   {
      'kevinhwang91/nvim-ufo',
      dependencies = 'kevinhwang91/promise-async',
      config = function()
         vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
         vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
         vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      end,
   },

   {
      'numToStr/Comment.nvim',
      keys = { 'gcc', 'gbc' },
      init = function()
         require('core.utils').load_mappings('comment')
      end,
      config = function()
         require('plugins.configs.others').comment()
      end,
   },

   -- file managing , picker etc
   {
      'nvim-tree/nvim-tree.lua',
      cmd = 'NvimTreeToggle',
      init = function()
         require('core.utils').load_mappings('nvimtree')
      end,
      config = function()
         require('plugins.configs.nvimtree')
      end,
   },

   {
      'nvim-telescope/telescope.nvim',
      cmd = 'Telescope',
      init = function()
         require('core.utils').load_mappings('telescope')
      end,
      opts = function()
         return require('plugins.configs.telescope')
      end,
      config = function(_, opts)
         require('telescope').setup(opts)
      end,
   },

   -- para markdown
   {
      'iamcco/markdown-preview.nvim',
      build = 'cd app && npm install',
      ft = 'markdown',
      config = function()
         vim.keymap.set('n', '<leader>mp', ':MarkdownPreviewToggle<CR>')
      end,
   },
   {
      'gaoDean/autolist.nvim',
      commit = '8d4a26f4f1750641b840fc50b0d867b5c9441aee',
      ft = 'markdown',
      config = function()
         require('autolist').setup()
      end,
   },
}

local opts_lazy = require('plugins.configs.lazy_nvim')

require('lazy').setup(default_plugins, opts_lazy)
