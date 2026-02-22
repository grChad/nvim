local cp = require('custom.gr-theme.palette_manager').get_palette()

return {
   GitSignsAdd = { fg = cp.green, bg = cp.base }, -- diff mode: Added line |diff.txt|
   GitSignsChange = { fg = cp.yellow, bg = cp.base }, -- diff mode: Changed line |diff.txt|
   GitSignsDelete = { fg = cp.red, bg = cp.base }, -- diff mode: Deleted line |diff.txt|
}
