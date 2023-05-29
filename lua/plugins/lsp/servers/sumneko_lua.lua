local M = {}

M.settings = {
	Lua = {
		runtime = {
			version = 'LuaJIT',
		},
		diagnostics = {
			globals = { 'vim' },
		},
		workspace = {
			library = {
				[vim.fn.expand('$VIMRUNTIME/lua')] = true,
				[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
				[vim.fn.stdpath('data') .. '/lazy/lazy.nvim/lua/lazy'] = true,
			},
			maxPreload = 100000,
			preloadFileSize = 10000,
		},
		telemetry = {
			enable = false,
		},
	},
}

local root_dir = require('lspconfig').util.root_pattern(
	'.luarc.json',
	'.luacheckrc',
	'.stylua.toml',
	'stylua.toml',
	'selene.toml',
	'.git'
)

M.root_dir = root_dir

return M
