local function border(hl_name)
	return {
		{ ' ', hl_name },
		{ '▁', hl_name },
		{ ' ', hl_name },
		{ '▏', hl_name },
		{ ' ', hl_name },
		{ '▔', hl_name },
		{ ' ', hl_name },
		{ '▕', hl_name },
	}
end

return {
	defaults = { lazy = true },
	install = { colorscheme = { 'catppuccin' } },

	ui = {
		size = { width = 0.7, height = 0.8 },
		border = border('FloatBorder'),

		icons = {
			ft = '',
			lazy = '󰂠 ',
			loaded = '',
			not_loaded = '',
		},
	},

	performance = {
		rtp = {
			reset = false,
			disabled_plugins = {
				'2html_plugin',
				'tohtml',
				'getscript',
				'getscriptPlugin',
				'gzip',
				'logipat',
				-- "netrw",
				-- "netrwPlugin",
				-- "netrwSettings",
				-- "netrwFileHandlers",
				'matchit',
				'tar',
				'tarPlugin',
				'rrhelper',
				-- "spellfile_plugin",
				'vimball',
				'vimballPlugin',
				'zip',
				'zipPlugin',
				'tutor',
				'rplugin',
				'syntax',
				'synmenu',
				'optwin',
				'compiler',
				'bugreport',
				'ftplugin',
			},
		},
	},
}
