return {
   -- dependencies
   { 'grChad/grUtils.nvim', dev = true },
   {
      'nvim-tree/nvim-web-devicons',
      lazy = true,
      config = function()
         require('nvim-web-devicons').setup({
            override_by_filename = {
               ['.gitignore'] = {
                  icon = '󰊢',
                  color = '#f1502f',
                  name = 'Gitignore',
               },
               ['.prettierrc.json'] = {
                  icon = '',
                  color = '#BF85BF',
                  name = 'PrettierRC',
               },
               ['.prettierrc.js'] = {
                  icon = '',
                  color = '#BF85BF',
                  name = 'PrettierRC',
               },
               ['package-lock.json'] = {
                  icon = '',
                  color = '#c0b13a',
                  name = 'FileLock',
               },
               ['lazy-lock.json'] = {
                  icon = '',
                  color = '#c0b13a',
                  name = 'FileLock',
               },
               ['biome.json'] = {
                  icon = '󰔶',
                  color = '#60A5FA',
                  name = 'Biome',
               },
            },
            override_by_extension = {
               ['astro'] = {
                  icon = '',
                  color = '#F76A02',
                  name = 'Astro',
               },
               ['toml'] = {
                  icon = '',
                  color = '#9C4221',
                  name = 'Toms',
               },
               ['gd'] = {
                  icon = '',
                  color = '#478cbf',
                  name = 'Godot',
               },
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
}
