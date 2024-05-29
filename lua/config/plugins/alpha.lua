return {
   { -- dashboard
      'goolord/alpha-nvim',
      event = 'VimEnter',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      init = function()
         local def_highlight = vim.api.nvim_set_hl

         def_highlight(0, 'CalendaryColor', { fg = '#FF875F' })
         def_highlight(0, 'BlueColor', { fg = '#0F85EF' })
         def_highlight(0, 'GreenColor', { fg = '#66AF3D' })
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
            .. '/.config/nvim/lua/config/util/logo-grChad.sh'
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
            { 'CalendaryColor', 0, 4 },
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
            { 'BlueColor', 0, 3 },
            { 'GreenColor', 3, 6 },
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
                        vim.opt.laststatus = 3
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
                  end, {
                     noremap = true,
                     silent = true,
                     buffer = buf,
                     desc = 'Refresh dashboard',
                  })

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
