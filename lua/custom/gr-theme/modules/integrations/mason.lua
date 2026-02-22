local cp = require('custom.gr-theme.palette_manager').get_palette()

return {
   MasonHeader = { fg = cp.mantle, bg = cp.blue, style = { 'bold' } },
   MasonHeaderSecondary = { fg = cp.blue, bg = 'NONE', style = { 'bold' } },

   MasonHighlight = { fg = cp.green },
   MasonHighlightBlock = { bg = cp.green, fg = cp.mantle },
   MasonHighlightBlockBold = { fg = cp.mantle, bg = cp.teal, style = { 'bold' } },

   MasonHighlightSecondary = { fg = cp.mauve },
   -- MasonHighlightBlockSecondary = { fg = secondary_fg, bg = secondary_bg },
   -- MasonHighlightBlockBoldSecondary = { fg = fg, bg = bg, bold = true },

   MasonMuted = { fg = cp.overlay0 },
   MasonMutedBlock = { fg = cp.mantle, bg = cp.overlay2 },
   -- MasonMutedBlockBold = { fg = cp.mantle, bg = cp.yellow, style = { 'bold' } },

   MasonError = { fg = cp.red },

   MasonHeading = { fg = cp.lavender, bg = cp.mantle, style = { 'bold' } }, -- h2,
}
