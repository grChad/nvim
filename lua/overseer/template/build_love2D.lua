return {
   name = 'Lua: Build with Love2D',
   builder = function()
      return {
         cmd = { 'love' },
         args = { '.' },
         components = { { 'on_output_quickfix' }, 'default' },
      }
   end,
   condition = {
      filetype = { 'lua' },
   },
}
