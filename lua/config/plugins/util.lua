return {
   -- dependencies
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
                  icon = '󰏣',
                  color = '#9E5351',
                  name = 'PrettierRC',
               },
               ['.prettierrc.js'] = {
                  icon = '󰏣',
                  color = '#9E5351',
                  name = 'PrettierRC',
               },
               ['readme.md'] = {
                  icon = '',
                  color = '#42A5F5',
                  name = 'ReadmePrincipal',
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
            },
            override_by_extension = {
               ['astro'] = {
                  icon = '󰣇',
                  color = '#F76A02',
                  name = 'Astro',
               },
            },
         })
      end,
   },
   { 'nvim-lua/plenary.nvim', lazy = true },
   { 'grChad/icons-nvim', dev = true, lazy = true },
   {
      'stevearc/overseer.nvim',
      ft = { 'lua', 'python', 'go', 'javascript', 'rust' },
      cmd = 'OverseerRun',
      init = function()
         require('core.utils').load_mappings('overseer')
      end,
      config = function()
         require('overseer').setup({
            templates = { 'compile', 'build_love2D' },
         })
      end,
   },
   {
      'HakonHarnes/img-clip.nvim',
      cmd = 'PasteImage',
      ft = { 'markdown', 'text' },
      opts = {
         -- add options here
         -- or leave it empty to use the default settings
      },
      keys = {
         -- suggested keymap
         { '<leader>pi', '<cmd>PasteImage<cr>', desc = 'Paste clipboard image' },
      },
   },
}
