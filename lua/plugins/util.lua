return {
   { 'j-hui/fidget.nvim', lazy = false, opts = {} }, -- $progress and notify
   { 'nvim-lua/plenary.nvim' },
   {
      'stevearc/overseer.nvim',
      ft = { 'lua', 'python', 'go', 'javascript', 'rust' },
      cmd = 'OverseerRun',
      keys = require('core.key_plugins').overseer,
      config = function()
         require('overseer').setup({
            templates = { 'compile', 'build_love2D' },
         })
      end,
   },
}
