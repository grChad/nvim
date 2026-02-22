local cp = require('custom.gr-theme.palette_manager').get_palette()

return {
   LazyButton = { bg = cp.surface0 },
   LazyButtonActive = { fg = cp.crust, bg = cp.blue, style = { 'bold' } },
   LazyH1 = { fg = cp.crust, bg = cp.blue, style = { 'bold' } },
   LazyH2 = { fg = cp.red, bg = cp.mantle, style = { 'bold' } },

   LazyDir = { fg = cp.gold },
   LazyUrl = { fg = cp.blue, style = { 'underline' } },
   LazyValue = { fg = cp.red },
}
