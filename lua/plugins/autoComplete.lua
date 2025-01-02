return {
   {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      cmd = 'LazyDev',
      opts = {
         library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            -- Para usar typos de 'wezterm' instalar `justinsgithub/wezterm-types`
            -- { path = 'wezterm-types', mods = { 'wezterm' } },
         },
      },
   },

   {
      'saghen/blink.cmp',
      version = 'v0.*',
      lazy = false,
      opts_extend = {
         'sources.completion.enabled_providers',
         'sources.default',
      },
      -- NOTE: Los snippets custom tienen que tener el valor "description": "..."
      dependencies = 'rafamadriz/friendly-snippets',
      event = 'InsertEnter',
      opts = {
         appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
            kind_icons = grvim.ui.icons.kinds,
         },
         keymap = {
            ---@type 'default' | 'none'
            preset = 'none', -- 'none' para desactivar 'default'
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'hide', 'fallback' },
            ['<CR>'] = { 'accept', 'fallback' },

            ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback' },
            ['<C-n>'] = { 'select_next', 'fallback' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
         },
         completion = {
            accept = { auto_brackets = { enabled = true } },
            menu = {
               draw = {
                  treesitter = { 'lsp' },
                  columns = {
                     { 'label', 'label_description', gap = 1 },
                     { 'kind_icon', 'kind' },
                  },
                  components = {
                     kind_icon = {
                        ellipsis = false,
                        text = function(ctx)
                           if ctx.kind == 'Color' then
                              return grvim.ui.icons.kinds.Color
                           end

                           return ctx.kind_icon .. ctx.icon_gap
                        end,
                        highlight = function(ctx)
                           if ctx.kind == 'Color' then
                              return 'BlinkCmpKindColor'
                           end

                           return 'BlinkCmpKind' .. ctx.kind
                        end,
                     },
                     kind = {
                        ellipsis = false,
                        width = { fill = true },
                        text = function(ctx)
                           if ctx.kind == 'Color' then
                              if ctx.kind_icon == '██' then
                                 return '󰝤󰝤󰝤󰝤󰝤󰝤󰝤'
                              else
                                 return 'Color'
                              end
                           end

                           return ctx.kind
                        end,
                     },
                  },
               },
            },
            list = {
               ---@type 'preselect' | 'manual' | 'auto_insert
               selection = 'manual',
            },
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
         },
         sources = {
            default = { 'lazydev', 'lsp', 'snippets', 'path', 'buffer' },
            cmdline = {}, -- disabled
            providers = {
               lazydev = {
                  name = 'LazyDev',
                  module = 'lazydev.integrations.blink',
                  score_offset = 100, -- show at a higher priority than lsp
               },
            },
         },
         signature = { enabled = true },
      },
   },

   {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      opts = {
         fast_wrap = {},
         disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
         enable_check_bracket_line = false,
      },
      config = function(_, opts)
         local autopairs = require('nvim-autopairs')
         local Rule = require('nvim-autopairs.rule')

         autopairs.setup(opts)

         autopairs.add_rules({
            Rule('*', '*', 'markdown'),
            Rule('_', '_', 'markdown'):with_pair(function(options)
               if options.line:match('_.*_$') then
                  -- estamos dentro de un par de _, no agregar otro
                  return false
               end
            end):with_move(),
         })
      end,
   },

   {
      'windwp/nvim-ts-autotag',
      event = { 'BufReadPre', 'BufNewFile' },
      config = function()
         require('nvim-ts-autotag').setup({
            opts = {
               enable_rename = false, -- Auto rename pairs of tags
               enable_close_on_slash = true, -- Auto close on trailing </
            },
            -- per_filetype = {
            --    ['html'] = {
            --       enable_close = false,
            --    },
            -- },
         })
      end,
   },
}
