-- Configuración general de los Diagnosticos con Lsp
vim.diagnostic.config({
   underline = true,
   virtual_text = false,
   virtual_lines = { current_line = true },
   update_in_insert = false,
   float = { border = 'single', title = ' Diagnostic ', header = '', max_width = 90, source = true },
   jump = { float = { border = 'single' } },
   severity_sort = true,
   signs = {
      text = {
         [vim.diagnostic.severity.ERROR] = ' ',
         [vim.diagnostic.severity.WARN] = ' ',
         [vim.diagnostic.severity.HINT] = '󰌵 ',
         [vim.diagnostic.severity.INFO] = ' ',
      },
   },
})

-- disable diagnostics 'vim.diagnostic.open_float()'
vim.keymap.del('n', '<C-W>d')
vim.keymap.del('n', '<C-W><C-D>')

-- set keymaps for floating diagnostics
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
