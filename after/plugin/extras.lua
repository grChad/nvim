vim.filetype.add({
   extension = {
      mdx = 'mdx',
   },
})

-- Solucion temporal para reanudar el pluign 'nvim-autopairs'
vim.api.nvim_create_user_command('ToggleAutopairs', function() require('nvim-autopairs').toggle() end, {})
