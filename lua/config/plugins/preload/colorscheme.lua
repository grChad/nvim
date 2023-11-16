return {
	{
		dir = '~/Escritorio/lua/theme-custom',
		lazy = false,
		priority = 10000, -- el tema tiene la prioridad mas alta.
		config = function()
			require('theme-nvim').load_theme()
		end,
	},

	{
		'NvChad/nvim-colorizer.lua',
		lazy = false,
		opts = {
			filetypes = {
				'*',
				css = { names = true },
				scss = { names = true },
				svelte = { names = true },
			},
			user_default_options = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = false, -- "Name" codes like Blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn

				-- Available modes: foreground, background, virtualtext
				mode = 'background',
				tailwind = true,
			},
		},
	},

	{
		'themaxmarchuk/tailwindcss-colors.nvim',
		priority = 900,
		config = function()
			require('tailwindcss-colors').setup()
		end,
	},

	{ 'KabbAmine/vCoolor.vim', priority = 800, lazy = false }, -- color picker
}
