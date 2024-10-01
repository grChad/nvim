-- :20 'LuaSnip'
--     'friendly-snippets'
-- :52 'nvim-cmp'
--     'cmp-nvim-lsp',
--     'cmp-buffer',
--     'cmp-path',
--     'cmp_luasnip',
--     'cmp-emoji',
-- :141 'nvim-autopairs',
-- :170 'nvim-ts-autotag'
-- :176 'mini.surround',
-- :195 'nvim-ts-context-commentstring',
-- :203 'Comment.nvim',

return {
   {
      'windwp/nvim-ts-autotag',
      event = { 'BufReadPre', 'BufNewFile' },
      opts = true,
   },

   {
      'echasnovski/mini.surround',
      event = 'VeryLazy',
      opts = {
         mappings = {
            add = 'as', -- Add surrounding in Normal and Visual modes
            delete = 'ds', -- Delete surrounding
            replace = 'cs', -- Change surrounding
            find = '',
            find_left = '',
            highlight = '',
            update_n_lines = '',

            suffix_last = '',
            suffix_next = '',
         },
      },
   },

   {
      'JoosepAlviste/nvim-ts-context-commentstring',
      opts = { enable_autocmd = false },
   },

   {
      'numToStr/Comment.nvim',
      keys = require('core.key_plugins').comment,
      config = function()
         -- NOTE: Ignorar los warings de las opciones que faltal.
         require('Comment').setup({
            toggler = { line = '', block = '' },
            opleader = { line = '', block = '' },
            extra = { above = '', below = '', eol = '' },
            mappings = { basic = false, extra = false },
            pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
         })
      end,
   },

   {
      'folke/lazydev.nvim',
      ft = 'lua',
      cmd = 'LazyDev',
      opts = {
         library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            { path = 'LazyVim', words = { 'LazyVim' } },
            { path = 'lazy.nvim', words = { 'LazyVim' } },
         },
      },
   },
   -- Manage libuv types with lazy. Plugin will never be loaded
   { 'Bilal2453/luvit-meta' },

   {
      'akinsho/toggleterm.nvim',
      version = '*',
      cmd = 'ToggleTerm',
      keys = require('core.key_plugins').toggleterm,
      config = function()
         require('toggleterm').setup({ size = 10 })
      end,
   },
}
