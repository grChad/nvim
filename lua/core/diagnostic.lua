-- disable diagnostics 'vim.diagnostic.open_float()'
vim.keymap.del('n', '<C-W>d')
vim.keymap.del('n', '<C-W><C-D>')

local map = vim.keymap.set

map('n', ']d', function()
   vim.diagnostic.jump({ count = 1, float = true, border = 'single' })
end, { desc = 'Go to next [D]iagnostic message' })
map('n', '[d', function()
   vim.diagnostic.jump({ count = -1, float = true, border = 'single' })
end, { desc = 'Go to previous [D]iagnostic message' })
map('n', '<leader>d', function()
   vim.diagnostic.open_float({ border = 'single' })
end, { desc = 'Show diagnostic [E]rror messages' })

-- Configuración general de los Diagnosticos con Lsp
vim.diagnostic.config({
   underline = true,
   virtual_text = { spacing = 4, source = 'if_many', prefix = '●' },
   update_in_insert = false,
   float = { border = 'single', max_width = 90, source = true, title = ' Diagnostic ' },
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
