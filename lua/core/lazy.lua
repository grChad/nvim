local colorscheme = require('config.plugins.preload.colorscheme')
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
   -- bootstrap lazy.nvim
   -- stylua: ignore
   vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
      lazypath
   })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup('config.plugins', {
   defaults = {
      lazy = true,
      version = false, -- always use the latest git commit
   },
   dev = {
      path = '~/Escritorio/lua', -- directorio de desarrollo
   },
   ui = {
      size = { width = 0.7, height = 0.8 },
      border = { ' ', '▁', ' ', '▏', ' ', '▔', ' ', '▕' },
   },
   install = { colorscheme = { 'default' } },
   checker = { enabled = false }, -- automatically check for plugin updates
   change_detection = { notify = false },
   performance = {
      rtp = {
         disabled_plugins = {
            'gzip',
            -- "matchit",
            -- "matchparen",
            -- "netrwPlugin",
            'tarPlugin',
            'tohtml',
            'tutor',
            'zipPlugin',
            'gzip',
         },
      },
   },
})
