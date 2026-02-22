-------------------------------------------------------------------------------
--                           by grChad 󰊤

-- config user Global 'grvim'
require('core.user')

require('core.settings')

-- theme custom
require('custom.gr-theme').load()

require('core.mappings')
require('core.diagnostic')
require('core.autocmds')

-- Plugin manager for NeoVim
require('core.lazy')
