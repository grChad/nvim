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
   {
      'nvim-tree/nvim-web-devicons',
      lazy = true,
      config = function()
         require('nvim-web-devicons').setup({
            override_by_filename = {
               ['.gitignore'] = { icon = '󰊢', color = '#f1502f', name = 'Gitignore' },
               ['.prettierrc.json'] = { icon = '', color = '#BF85BF', name = 'PrettierRC' },
               ['.prettierrc.js'] = { icon = '', color = '#BF85BF', name = 'PrettierRC' },
               ['package.json'] = { icon = '', color = '#8bc34a', name = 'Package' },
               ['package-lock.json'] = { icon = '', color = '#85BD44', name = 'FileLock' },
               ['lazy-lock.json'] = { icon = '', color = '#c0b13a', name = 'FileLock' },
               ['biome.json'] = { icon = '󰔶', color = '#60A5FA', name = 'Biome' },
            },
            override_by_extension = {
               ['astro'] = { icon = '', color = '#F76A02', name = 'Astro' },
               ['toml'] = { icon = '', color = '#9C4221', name = 'Toms' },
               ['gd'] = { icon = '', color = '#478cbf', name = 'Godot' },
               ['tsx'] = { icon = '󰜈', color = '#0E83C6', name = 'Typescriptreact' },
               ['jsx'] = { icon = '󰜈', color = '#cbcb41', name = 'Javascriptreact' },
               ['json'] = { icon = '', color = '#df9828', name = 'Json' },
               ['sh'] = { icon = '', color = '#A98383', name = 'Shell' },
            },
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

   {
      'folke/snacks.nvim',
      priority = 800,
      lazy = false,
      opts = {
         picker = { enabled = true },
      },
   },
}
