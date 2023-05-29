require('core.settings')
require('core.autocmds')
require('core.utils').load_mappings()

--------------------[ init Lazy ]-------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
	require('core.bootstrap').lazy(lazypath)
end

vim.opt.rtp:prepend(lazypath)
require('plugins')
--------------------[ end Lazy ]--------------------------

require('core.fixs_formats')
