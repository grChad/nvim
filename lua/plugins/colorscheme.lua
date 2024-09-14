return {
   { -- NOTE: Tema para la aplicación de nvim
      'grChad/theme-custom',
      dev = true,
      lazy = false,
      priority = 1000, -- el tema tiene la prioridad mas alta.
      config = function()
         require('theme-nvim').load_theme()
      end,
   },

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

   { 'KabbAmine/vCoolor.vim', lazy = false, priority = 800 },
}
