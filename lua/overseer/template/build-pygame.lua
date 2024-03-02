return {
   name = 'Run Pygame',
   builder = function()
      -- Full path to current file (see :help expand())
      local file = vim.fn.expand('%:p')
      return {
         cmd = { 'python' },
         args = { file },
         components = {
            { 'on_output_quickfix', set_diagnostics = true, open = false },
            'on_result_diagnostics',
            'default',
         },
      }
   end,
   condition = { filetype = { 'python' } },
}
