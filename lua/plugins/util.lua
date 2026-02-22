return {
   { 'j-hui/fidget.nvim', opts = {} }, -- $progress and notify

   {
      'grChad/utils.nvim',
      dev = true,
      lazy = false,
      config = function()
         local gr_utils = require('gr-utils')

         gr_utils.statuscolumn.setup({
            without_fold = { 'text', 'markdown', 'mdx' },
            -- disabled = {},
            -- add_with_fold = {},
         })
      end,
   },
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
