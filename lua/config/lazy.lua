local print_echo = function(msg)
   vim.cmd('redraw')
   vim.api.nvim_echo({ { msg, 'Bold' } }, true, {})
end
--------------------------------------------------------------------------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
   print_echo('  Instalando lazy.nvim & plugins ...')

   local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
   vim.fn.system({ 'git', 'clone', '--filter=blob:none', lazyrepo, '--branch=stable', lazypath })
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
--------------------------------------------------------------------------------------

require('lazy').setup('plugins', {
   defaults = {
      lazy = true, -- should plugins be lazy-loaded?
      version = nil, -- always use the latest git commit
   },
   dev = { path = '~/Escritorio/lua' },
   ui = {
      size = { width = 0.7, height = 0.8 },
      border = grvim.ui.border_inset,
   },
   checker = { enabled = false }, -- automatically check for plugin updates
   change_detection = { enabled = false, notify = false },
})
