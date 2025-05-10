return {
   {
      'folke/snacks.nvim',
      priority = 1000,
      lazy = false,
      opts = {
         picker = { enabled = true },
         image = { enabled = false },
         styles = {
            snacks_image = { border = 'none' },
         },
      },
      keys = require('core.key_plugins').snacks,
   },
}
