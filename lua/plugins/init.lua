local default_plugins = {
	{ 'nvim-lua/plenary.nvim' },

	{
		'goolord/alpha-nvim', -- dashboard
		lazy = false,
		config = function()
			require('plugins.configs.alpha')
		end,
	},
	{
		-- dir = '~/Escritorio/lua/theme-custom',
		'grChad/theme-custom',
		lazy = false,
		priority = 1000, -- el tema tiene la prioridad mas alta.
		config = function()
			require('theme-nvim').load_theme()
		end,
	},

	{
		'romgrk/barbar.nvim', -- barra del buffer
		lazy = false,
		init = function()
			require('core.utils').load_mappings('barbar')
			vim.g.barbar_auto_setup = false
		end,
		opts = require('plugins.configs.barbar'),
	},

	{
		'grChad/statusStatic', -- barra de estado
		lazy = false,
		config = function()
			require('status-static').setup()
		end,
	},

	-- FIXME: problemas con Flutter: buffers para debugs
	-- {
	-- 	'gr92/bufferSplitSimple',
	-- 	config = function()
	-- 		require('buffer-split-simple').setup()
	-- 	end,
	-- },

	{
		'NvChad/nvterm',
		init = function()
			require('core.utils').load_mappings('nvterm')
		end,
		config = function(_, opts)
			require('nvterm').setup(opts)
		end,
	},

	{
		'NvChad/nvim-colorizer.lua',
		init = function()
			require('core.utils').lazy_load('nvim-colorizer.lua')
		end,
		config = function()
			require('plugins.configs.others').colorizer()
		end,
	},

	{
		'themaxmarchuk/tailwindcss-colors.nvim',
		priority = 900,
		config = function()
			require('tailwindcss-colors').setup()
		end,
	},

	{ 'KabbAmine/vCoolor.vim', priority = 800, lazy = false },
	{ 'ggandor/lightspeed.nvim', keys = 's' },

	{ 'nvim-tree/nvim-web-devicons', lazy = true },

	{
		'lukas-reineke/indent-blankline.nvim',
		init = function()
			require('core.utils').lazy_load('indent-blankline.nvim')
			require('core.utils').load_mappings('blankline')
			vim.cmd([[let g:indent_blankline_context_char='▎']])
		end,
		opts = function()
			return require('plugins.configs.others').blankline
		end,
		config = function(_, opts)
			require('indent_blankline').setup(opts)
		end,
	},

	{
		'nvim-treesitter/nvim-treesitter',
		init = function()
			require('core.utils').lazy_load('nvim-treesitter')
		end,
		cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
		build = ':TSUpdate',
		dependencies = {
			{ 'JoosepAlviste/nvim-ts-context-commentstring' },
			{ 'windwp/nvim-ts-autotag' },
			{ 'nvim-treesitter/playground' },
			{
				'm-demare/hlargs.nvim',
				config = function()
					require('hlargs').setup({
						highlight = { fg = '#FFFFFF', italic = true },
					})
				end,
			},
		},
		opts = function()
			return require('plugins.configs.treesitter')
		end,
		config = function(_, opts)
			require('nvim-treesitter.configs').setup(opts)
		end,
	},

	-- git stuff
	{
		'lewis6991/gitsigns.nvim',
		ft = { 'gitcommit', 'diff' },
		init = function()
			require('core.utils').lazy_load('gitsigns.nvim')
		end,
		opts = function()
			return require('plugins.configs.others').gitsigns
		end,
		config = function(_, opts)
			require('gitsigns').setup(opts)
		end,
	},

	-- lsp stuff
	{
		'williamboman/mason.nvim',
		cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
		opts = function()
			return require('plugins.configs.mason')
		end,
		config = function(_, opts)
			require('mason').setup(opts)

			-- custom nvchad cmd to install all mason binaries listed
			vim.api.nvim_create_user_command('MasonInstallAll', function()
				vim.cmd('MasonInstall ' .. table.concat(opts.ensure_installed, ' '))
			end, {})

			vim.g.mason_binaries_list = opts.ensure_installed
		end,
	},

	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{
				'jose-elias-alvarez/null-ls.nvim',
				config = function()
					require('plugins.lsp.null')
				end,
			},
		},
		init = function()
			require('core.utils').lazy_load('nvim-lspconfig')
		end,
		config = function()
			require('plugins.lsp.setup')
		end,
	},

	{ 'jose-elias-alvarez/typescript.nvim' }, -- for tsserver
	{
		'lvimuser/lsp-inlayhints.nvim',
		branch = 'main', -- or "anticonceal"
		opts = {
			inlay_hints = { highlight = 'LspCodeLens' },
			debug_mode = false,
		},
	},
	-- Lsp para dart
	{
		'dart-lang/dart-vim-plugin',
		ft = 'dart',
		config = function()
			vim.cmd([[
         let dart_html_in_string=v:true
         let g:dart_style_guide = 2
         let g:dart_format_on_save = 1
         let g:dart_trailing_comma_indent = v:true
         ]])
		end,
	},

	{
		'akinsho/flutter-tools.nvim',
		ft = 'dart',
		config = function()
			require('plugins.configs.flutterTools')
		end,
	},

	-- load luasnips + cmp related in insert mode only
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			{
				'L3MON4D3/LuaSnip', -- snippet plugin
				dependencies = 'rafamadriz/friendly-snippets',
				opts = { history = true, updateevents = 'TextChanged,TextChangedI' },
				config = function(_, opts)
					require('plugins.configs.others').luasnip(opts)
				end,
			},

			{
				'windwp/nvim-autopairs', -- autopairing of (){}[] etc
				config = function()
					require('plugins.configs.others').autopairs()
				end,
			},

			{
				'saadparwaiz1/cmp_luasnip',
				'hrsh7th/cmp-nvim-lua',
				'hrsh7th/cmp-nvim-lsp',
				'hrsh7th/cmp-buffer',
				'FelipeLema/cmp-async-path',
				'hrsh7th/cmp-emoji',
			},
		},
		config = function()
			require('plugins.configs.cmp')
		end,
	},

	{
		'jcdickinson/codeium.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'hrsh7th/nvim-cmp',
		},
		event = 'InsertEnter',
		lazy = false,
		config = function()
			require('codeium').setup({})
		end,
	},

	{
		'Wansmer/treesj',
		lazy = true,
		cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' },
		keys = {
			{ 'gJ', '<cmd>TSJToggle<CR>', desc = 'Toggle Split/Join' },
		},
		config = function()
			require('treesj').setup({
				use_default_keymaps = false,
			})
		end,
	},

	{
		'kevinhwang91/nvim-ufo',
		dependencies = 'kevinhwang91/promise-async',
		config = function()
			vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
			vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
			vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
		end,
	},

	{
		'numToStr/Comment.nvim',
		keys = { 'gcc', 'gbc' },
		init = function()
			require('core.utils').load_mappings('comment')
		end,
		config = function()
			require('plugins.configs.others').comment()
		end,
	},

	-- file managing , picker etc
	{
		'nvim-tree/nvim-tree.lua',
		cmd = 'NvimTreeToggle',
		init = function()
			require('core.utils').load_mappings('nvimtree')
		end,
		config = function()
			require('plugins.configs.nvimtree')
		end,
	},

	{
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		init = function()
			require('core.utils').load_mappings('telescope')
		end,
		opts = function()
			return require('plugins.configs.telescope')
		end,
		config = function(_, opts)
			require('telescope').setup(opts)
		end,
	},

	-- para markdown
	{
		'iamcco/markdown-preview.nvim',
		build = 'cd app && npm install',
		ft = 'markdown',
		config = function()
			vim.keymap.set('n', '<leader>mp', ':MarkdownPreviewToggle<CR>')
		end,
	},
	{
		'gaoDean/autolist.nvim',
		commit = '8d4a26f4f1750641b840fc50b0d867b5c9441aee',
		ft = 'markdown',
		config = function()
			require('autolist').setup()
		end,
	},

	-- for latex
	-- {
	-- 	'lervag/vimtex',
	-- 	ft = { 'latex', 'tex' },
	-- 	config = function()
	-- 		vim.cmd([[
	--            let g:vimtex_view_method = 'zathura'
	--            let g:vimtex_compiler_method = 'latexmk'
	--            let maplocalleader = ' '
	--            let g:vimtex_view_general_viewer = 'okular'
	--            let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
	--         ]])
	-- 	end,
	-- },
}

local opts_lazy = require('plugins.configs.lazy_nvim')

require('lazy').setup(default_plugins, opts_lazy)
