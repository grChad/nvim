-------------------------------------------------------------------------------
--                           by grChad 󰊤

require('core.settings')
require('core.autocmds')
require('core.utils').load_mappings()

--------------------[ init Lazy ]-------------------------
local lazyPath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazyPath) then
   require('core.bootstrap').lazy(lazyPath)
end

vim.opt.rtp:prepend(lazyPath)
require('plugins')
--------------------[ end Lazy ]--------------------------

require('core.fixs_formats')
