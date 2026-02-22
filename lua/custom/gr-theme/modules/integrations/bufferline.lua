local cp = require('custom.gr-theme.palette_manager').get_palette()

return {
   BufferLineFill = { bg = cp.crust },
   BufferLineBackground = { bg = cp.crust },

   BufferLineBufferSelected = { fg = 'NONE', bg = cp.base, style = { 'bold', '!italic' } }, --italic = false
   BufferLineBufferVisible = { fg = 'NONE', bg = cp.base },

   BufferLineCloseButton = { fg = cp.red },
   BufferLineCloseButtonVisible = { fg = cp.red, bg = cp.base },
   BufferLineCloseButtonSelected = { fg = cp.red, bg = cp.base },

   BufferLinePickSelected = { fg = cp.orange, style = { 'bold', '!italic' } }, -- italic = false
   BufferLinePickVisible = { fg = cp.orange, style = { 'bold', '!italic' } }, -- italic = false
   BufferLinePick = { fg = cp.orange, style = { 'bold', '!italic' } }, -- italic = false

   BufferLineIndicatorSelected = { fg = cp.text, bg = cp.base },
   BufferLineIndicatorVisible = { fg = cp.text, bg = cp.base },

   BufferLineModified = { fg = cp.yellow },
   BufferLineModifiedSelected = { fg = cp.yellow, bg = cp.base },
   BufferLineModifiedVisible = { fg = cp.yellow, bg = cp.base },
}
