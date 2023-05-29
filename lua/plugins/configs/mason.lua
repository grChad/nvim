local options = {
	ensure_installed = {
		'lua-language-server',
		'html-lsp',
		'emmet-ls',
		'css-lsp',
		'stylelint-lsp',
		'tailwindcss-language-server',
		'typescript-language-server',
		'svelte-language-server',
		'json-lsp',
		'pyright',
		'rust-analyzer',
		'marksman',
		'yaml-language-server',

		-- formatter & Linter
		'stylua',
		'prettierd',
		'eslint_d',
	},

	PATH = 'skip',

	ui = {
		icons = {
			package_pending = ' ',
			package_installed = '󰄳 ',
			package_uninstalled = ' 󰚌',
		},

		keymaps = {
			toggle_server_expand = '<CR>',
			install_server = 'i',
			update_server = 'u',
			check_server_version = 'c',
			update_all_servers = 'U',
			check_outdated_servers = 'C',
			uninstall_server = 'X',
			cancel_installation = '<C-c>',
		},
	},

	max_concurrent_installers = 10,
}

return options
