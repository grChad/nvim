local options = {
	ensure_installed = {
		'lua',
		'luadoc',
		'vim',
		'vimdoc',
		'bash',
		'rust',
		'c',
		'cpp',
		'dart',
		'python',
		'htmldjango',
		'html',
		'css',
		'scss',
		'javascript',
		'jsdoc',
		'typescript',
		'tsx',
		'svelte',
		'vue',
		'markdown',
		'markdown_inline',
		'json',
		'yaml',
		'toml',
		'comment',
		'regex',
		'gitignore',
		'git_config',
	},

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = { enable = true },

	-- del plugin nvim-ts-autotag
	autotag = {
		enable = true,
	},

	-- modulo para context_commentstring
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},

	-- modulo de prueva de grupos highlight
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = 'o',
			toggle_hl_groups = 'i',
			toggle_injected_languages = 't',
			toggle_anonymous_nodes = 'a',
			toggle_language_display = 'I',
			focus_language = 'f',
			unfocus_language = 'F',
			update = 'R',
			goto_node = '<cr>',
			show_help = '?',
		},
	},
}

return options
