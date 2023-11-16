if vim.fn.has('nvim-0.9.0') == 0 then
   vim.api.nvim_echo({
      { ' LazyVim requiere de Neovim 0.9.0 como minino \n', 'ErrorMsg' },
      { '\n Presione cualquier tecla para Salir',           'MoreMsg' },
   }, true, {})
   vim.fn.getchar()
   vim.cmd([[quit]])
   return {}
end

return {
   { 'folke/lazy.nvim',                version = '*' },
   { import = 'config.plugins.preload' },

   -- recomendado para otros usuarios
   -- { import = 'config.plugins.custom.nimi_animate' },
}
