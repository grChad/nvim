local cp = require('custom.gr-theme.palette_manager').get_palette()

return {
   CodeBlock = { bg = cp.mantle },
   Quote = { fg = cp.textparam, bg = cp.base },
   Dash = { fg = cp.blue, bg = cp.base },
}
