local cp = require('custom.gr-theme.palette_manager').get_palette()

return {
   HlSearchCustom = { fg = cp.base, bg = cp.blue, style = { 'bold' } },

   -- Treesitter context
   TreesitterContext = { bg = cp.crust },
   TreesitterContextBottom = { sp = cp.surface2, style = { 'underline' } },

   -- Alpha-nvim
   AlphaHeaderLogo = { fg = '#7DC8FC' },
   AlphaHeaderCalendary = { fg = '#FF875F' },
   AlphaFooterLetterNeo = { fg = '#2196FF' },
   AlphaFooterLetterVim = { fg = '#6BC439' },
   AlphaButtonHL = { fg = '#20CDE5' },
   AlphaButtonKey = { fg = '#18C2B8', style = { 'bold' } },

   -- plugin utils-nvim
   FoldSignsOpen = { fg = cp.lavender, bg = cp.mantle },
   FoldSignsClosed = { fg = cp.overlay1, bg = cp.base },

   TextYank = { fg = cp.base, bg = cp.sky },

   -- plugin Hlargs
   Hlargs = { fg = cp.textparam, style = { 'italic' } },
}
