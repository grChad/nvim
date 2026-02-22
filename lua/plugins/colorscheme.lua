return {
   { 'KabbAmine/vCoolor.vim', lazy = false, priority = 800 },

   { -- NOTE: Highlight Colors
      'brenoprata10/nvim-highlight-colors',
      lazy = false,
      priority = 900,
      cmd = 'HighlightColors Toggle',
      keys = require('core.key_plugins').highlight_colors,
      config = function()
         require('nvim-highlight-colors').setup({
            render = grvim.ui.hig_colors.style,
            enable_tailwind = grvim.ui.hig_colors.tailwind,
            exclude_filetypes = { 'cmp_menu', 'cmp_docs' },
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
               ['readme.md'] = { icon = '', color = '#37A2AB', name = 'Markdown' },
            },
            override_by_extension = {
               ['astro'] = { icon = '', color = '#F76A02', name = 'Astro' },
               ['toml'] = { icon = '', color = '#9C4221', name = 'Toms' },
               ['gd'] = { icon = '', color = '#478cbf', name = 'Godot' },
               ['tsx'] = { icon = '󰜈', color = '#0E83C6', name = 'Typescriptreact' },
               ['jsx'] = { icon = '󰜈', color = '#cbcb41', name = 'Javascriptreact' },
               ['json'] = { icon = '', color = '#df9828', name = 'Json' },
               ['sh'] = { icon = '', color = '#A98383', name = 'Shell' },
               ['md'] = { icon = '', color = '#7CC7FC', name = 'Markdown' },
            },
         })
      end,
   },
}
