return {
   name = 'Compile default',
   builder = function()
      local file = vim.fn.expand('%:p')
      local cmd = { file }
      if vim.bo.filetype == 'python' then
         cmd = { 'python', file }
      end
      if vim.bo.filetype == 'javascript' then
         cmd = { 'node', file }
      end
      if vim.bo.filetype == 'lua' then
         cmd = { 'lua', file }
      end
      if vim.bo.filetype == 'rust' then
         cmd = { 'cargo', 'run' }
         -- cmd = { 'rustc', file }
      end
      return {
         cmd = cmd,
         components = {
            {
               'on_output_quickfix',
               set_diagnostics = true,
               open = true,
               open_height = 7,
            },
            'on_result_diagnostics',
            'default',
         },
      }
   end,
   condition = {
      filetype = { 'python', 'javascript', 'lua', 'rust' },
   },
}
