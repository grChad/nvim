return {
   {
      'kylechui/nvim-surround',
      version = '*',
      event = 'VeryLazy',
      config = function() require('nvim-surround').setup() end,
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
      'akinsho/toggleterm.nvim',
      version = '*',
      cmd = 'ToggleTerm',
      keys = require('core.key_plugins').toggleterm,
      config = function() require('toggleterm').setup({ size = 10 }) end,
   },
}
