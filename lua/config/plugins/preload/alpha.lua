return {
	{ -- dashboard
		'goolord/alpha-nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		init = function()
			-- Definir colores en una tabla
			local colors = {
				-- Char 'g'
				{ 'char_g_1', '#4040fe' },
				{ 'char_g_2', '#354bfe' },
				{ 'char_g_3', '#255ffa' },
				{ 'char_g_4', '#1a70f4' },
				{ 'char_g_5', '#137def' },

				-- Char 'r'
				{ 'char_r_1', '#255ffa' },
				{ 'char_r_2', '#1a70f4' },
				{ 'char_r_3', '#1578f1' },
				{ 'char_r_4', '#0f85eb' },
				{ 'char_r_5', '#0a92e3' },

				-- Char 'C'
				{ 'char_C_1', '#2b57fc' },
				{ 'char_C_2', '#1f68f7' },
				{ 'char_C_3', '#1d6cf6' },
				{ 'char_C_4', '#1578f1' },
				{ 'char_C_5', '#0f85eb' },
				{ 'char_C_6', '#0a92e3' },
				{ 'char_C_7', '#03a6d5' },
				{ 'char_C_8', '#01b2cb' },

				-- Char 'h'
				{ 'char_h_1', '#1578f1' },
				{ 'char_h_2', '#0f85eb' },
				{ 'char_h_3', '#0a92e3' },
				{ 'char_h_4', '#059edb' },
				{ 'char_h_5', '#01b2cb' },
				{ 'char_h_6', '#01c8b5' },
				{ 'char_h_7', '#03d2a9' },
				{ 'char_h_8', '#06dc9d' },

				-- Char 'a'
				{ 'char_a_1', '#03d2a9' },
				{ 'char_a_2', '#06dc9d' },
				{ 'char_a_3', '#0ae491' },
				{ 'char_a_4', '#11ed80' },

				-- Char 'd'
				{ 'char_d_1', '#04d6a5' },
				{ 'char_d_2', '#07de99' },
				{ 'char_d_3', '#0ce68d' },
				{ 'char_d_4', '#11ed80' },
				{ 'char_d_5', '#14ef7c' },
				{ 'char_d_6', '#1bf56f' },
				{ 'char_d_7', '#23f962' },
				{ 'char_d_8', '#2cfc56' },

				{ 'FirstColor', '#51afef' },
				{ 'SecondColor', '#FF875F' },
				{ 'ThirdColor', '#FF5F5F' },
				{ 'ButtonColor', '#181818', '#51afef' },
				{ 'popOsColor', '#46b3c1' },
				{ 'fedoraColor', '#283f6e', '#1a70f4' },
				{ 'manjaroColor', '#159b81', '#06dc9d' },
				{ 'debianColor', '#d0074e', '#01b2cb' },
				{ 'archColor', '#198cc4' },
				{ 'ubuntuColor', '#e86e1f' },
				{ 'linuxMintColor', '#66af3d' },
				{ 'suseColor', '#6fb424', '#0ce68d' },
			}

			-- Definir y establecer los 'highlight groups' con los colores definidos
			local api_hl = vim.api.nvim_set_hl

			for _, color in ipairs(colors) do
				local group, opts = color[1], { fg = color[2] }
				if color[3] then
					opts.bg = color[3]
				end
				api_hl(0, group, opts)
			end

			local group_custom = function(valor, table_hl)
				return {
					type = 'group',
					val = {
						{
							type = 'text',
							val = valor,
							opts = { position = 'center', hl = table_hl },
						},
					},
				}
			end
		end,
		config = function()
			local alpha = require('alpha')
			local redraw = alpha.redraw

			require('alpha.term')
			local dashboard = require('alpha.themes.dashboard')

			dashboard.opts.opts.noautocmd = true

			local width = 57 -- 104
			local height = 8 -- 28

			dashboard.section.terminal.command = 'sh '
				.. os.getenv('HOME')
				.. '/.config/nvim/lua/config/static/logo-grChad.sh'
			dashboard.section.terminal.width = width
			dashboard.section.terminal.height = height
			-- dashboard.section.terminal.opts.redraw = true

			-- +--------------------------------------------------------------------+
			local group_custom = function(valor, table_hl)
				return {
					type = 'group',
					val = {
						{
							type = 'text',
							val = valor,
							opts = { position = 'center', hl = table_hl },
						},
					},
				}
			end

			-- Información de la fecha:
			-- en lugar de usar 'date' del sistema, 'os.date' de Lua formatea directamente el código.
			local capitalized = function(my_string)
				return string.upper(string.sub(my_string, 1, 1)) .. string.sub(my_string, 2)
			end

			local day = capitalized(tostring(os.date('%A')))
			local month = capitalized(tostring(os.date('%B')))

			local fecha = ' ' .. day .. os.date(' %d de ') .. month .. os.date('  -   %R')

			local fecha_actual = group_custom(fecha, {
				{ 'SecondColor', 0, 4 },
				{ 'Text', 4, 50 },
			})

			-- +--------------------------------------------------------------------+
			vim.api.nvim_set_hl(0, 'AlphaButtonHL', { fg = '#01B2CB', italic = true })
			vim.api.nvim_set_hl(0, 'AlphaButtonKey', { fg = '#01B2CB', bold = true })

			local function button(key, txt, cmd)
				local opts = {
					position = 'center',
					text = txt,
					shortcut = key,
					cursor = 4,
					width = 25,
					align_shortcut = 'right',
					hl_shortcut = 'AlphaButtonKey',
					hl = 'AlphaButtonHL',
				}

				if cmd then
					opts.keymap = { 'n', key, cmd, { noremap = true, silent = true } }
				end

				return {
					type = 'button',
					val = txt,
					on_press = function()
						local _key = vim.api.nvim_replace_termcodes(key, true, false, true)
						vim.api.nvim_feedkeys(_key, 'normal', false)
					end,
					opts = opts,
				}
			end

			local buttons = {
				type = 'group',
				val = {
					-- button('e ', '  New', '<cmd>ene<cr>'),
					button('w', '󰈭  Find Word', '<cmd>Telescope live_grep<CR>'),
					button('f', '󰱼  Find File', '<cmd>Telescope find_files<cr>'),
					button('r', '  Recent File', '<cmd>Telescope oldfiles<cr>'),
					button('b', '  Bookmarks', '<cmd>Telescope marks<CR>'),
					-- button('u', '  Update', '<cmd>Lazy sync<cr>'),
					-- button('s', '  Abrir session reciente', '<cmd>SessionManager load_current_dir_session<CR>'),
					button('q', '󰗼  Quit!', '<cmd>qall!<cr>'),
				},
				opts = { spacing = 1 },
			}

			-- +--------------------------------------------------------------------+

			-- datos de la version de Nvim
			local function footer()
				local v = vim.version()
				local plugins_lazy = require('lazy').plugins()
				local value_str = 'NeoVim v%d.%d.%d -  %d Plugins'

				return string.format(value_str, v.major, v.minor, v.patch, #plugins_lazy)
					.. ' | by · @grchad 󰊤'
			end

			local the_footer = group_custom(footer(), {
				{ 'char_C_5', 0, 3 },
				{ 'linuxMintColor', 3, 6 },
				{ 'Text', 7, 60 },
			})

			local layout = function()
				local R = {}

				R.pid = vim.loop.getpid()
				R.width = vim.api.nvim_win_get_width(0)
				R.height = vim.api.nvim_win_get_height(0)

				local padding_resize
				if R.height <= 25 then
					padding_resize = math.floor((R.height - 14) / 2)

					R.display = {
						{ type = 'padding', val = padding_resize },
						fecha_actual,
						{ type = 'padding', val = 2 },
						buttons,
						{ type = 'padding', val = 1 },
						the_footer,
					}
				else
					padding_resize = math.floor((R.height - 24) / 2)

					R.display = {
						{ type = 'padding', val = padding_resize },
						dashboard.section.terminal,
						{ type = 'padding', val = 1 },
						fecha_actual,
						{ type = 'padding', val = 2 },
						buttons,
						{ type = 'padding', val = 1 },
						the_footer,
					}
				end

				return R
			end

			local config = function()
				vim.api.nvim_create_augroup('alpha_tabline', { clear = true })

				vim.api.nvim_create_autocmd('FileType', {
					group = 'alpha_tabline',
					pattern = 'alpha',
					callback = function()
						vim.opt_local.laststatus = 0
					end,
				})

				vim.api.nvim_create_autocmd('FileType', {
					group = 'alpha_tabline',
					pattern = 'alpha',
					callback = function()
						vim.api.nvim_create_autocmd('BufUnload', {
							group = 'alpha_tabline',
							buffer = 0,
							callback = function()
								vim.defer_fn(function()
									vim.opt.laststatus = 3
								end, 100)
							end,
						})
					end,
				})

				vim.api.nvim_create_autocmd('User', {
					pattern = 'AlphaReady',
					callback = function()
						vim.o.stal = 0
						vim.b.miniindentscope_disable = true

						local buf = vim.api.nvim_get_current_buf()
						local win = vim.api.nvim_get_current_win()

						vim.keymap.set('n', '<c-l>', function()
							package.loaded.alpha.default_config.layout = layout().display
							redraw()
						end, { noremap = true, silent = true, buffer = buf, desc = 'Refresh dashboard' })

						local augroup = vim.api.nvim_create_augroup('alpha_recalc', { clear = true })

						vim.api.nvim_create_autocmd('VimResized', {
							group = augroup,
							buffer = buf,
							callback = function()
								package.loaded.alpha.default_config.layout = layout().display
								if vim.api.nvim_get_current_win() == win then
									redraw()
								end
							end,
						})

						vim.api.nvim_create_autocmd({ 'WinEnter' }, {
							group = augroup,
							buffer = buf,
							callback = function()
								vim.defer_fn(function()
									if vim.api.nvim_get_current_win() == win then
										redraw()
									end
								end, 5)
							end,
						})

						vim.api.nvim_create_autocmd('User', {
							pattern = 'AlphaClosed',
							callback = function()
								vim.o.stal = 2
								vim.api.nvim_del_augroup_by_id(augroup)
							end,
						})
					end,
				})
			end

			alpha.setup({
				layout = layout().display,
				opts = {
					margin = 0,
					redraw_on_resize = false,
					setup = config(),
				},
			})
		end,
	},
}
