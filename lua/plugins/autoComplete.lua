return {
   {
      'L3MON4D3/LuaSnip',
      build = (not jit.os:find('Windows'))
            and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
         or nil,
      dependencies = { 'grChad/snippets.nvim', dev = true },
      config = function()
         require('luasnip').setup({
            history = true,
            delete_check_events = 'TextChanged',
         })

         require('luasnip.loaders.from_vscode').lazy_load()
      end,
   },

   {
      'hrsh7th/nvim-cmp',
      version = false, -- last release is way too old
      event = 'InsertEnter',
      dependencies = {
         'hrsh7th/cmp-nvim-lsp',
         'hrsh7th/cmp-buffer',
         'hrsh7th/cmp-path',
         'saadparwaiz1/cmp_luasnip',
         'hrsh7th/cmp-emoji',
      },
      opts = function()
         local cmp = require('cmp')
         local defaults = require('cmp.config.default')()

         return {
            completion = {
               completeopt = 'menu,menuone,noselect',
            },
            window = {
               completion = {
                  -- border = grvim.ui.border_rounded,
                  border = 'rounded',
                  col_offset = 1,
                  side_padding = 0,
                  winhighlight = 'Normal:NormalFloat,CursorLine:NormalFloatSelect,Search:None',
               },
               documentation = {
                  border = grvim.ui.border_rounded,
                  winhighlight = 'Normal:NormalFloat,Search:None',
                  max_width = 150,
               },
            },
            snippet = {
               expand = function(args)
                  require('luasnip').lsp_expand(args.body)
               end,
            },
            mapping = cmp.mapping.preset.insert({
               ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
               ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
               ['<C-b>'] = cmp.mapping.scroll_docs(-4),
               ['<C-f>'] = cmp.mapping.scroll_docs(4),
               ['<C-Space>'] = cmp.mapping.complete(),
               ['<C-e>'] = cmp.mapping.abort(),
               ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
               ['<S-CR>'] = cmp.mapping.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
               }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
               ['<C-CR>'] = function()
                  cmp.abort()
               end,
               ['<Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                     cmp.select_next_item()
                  elseif require('luasnip').expand_or_jumpable() then
                     require('luasnip').expand_or_jump()
                  else
                     fallback()
                  end
               end, { 'i', 's' }),

               ['<S-Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                     cmp.select_prev_item()
                  elseif require('luasnip').jumpable(-1) then
                     require('luasnip').jump(-1)
                  else
                     fallback()
                  end
               end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
               { name = 'nvim_lsp' },
               { name = 'luasnip' },
               { name = 'path' },
               { name = 'emoji', option = { insert = true } },
               { name = 'lazydev', group_index = 0 },
            }, {
               { name = 'buffer' },
            }),
            formatting = { format = require('gr-utils').cmp_format },
            experimental = {
               ghost_text = false,
            },
            sorting = defaults.sorting,
         }
      end,

      ---@param opts cmp.ConfigSchema
      config = function(_, opts)
         for _, source in ipairs(opts.sources) do
            source.group_index = source.group_index or 1
         end
         require('cmp').setup(opts)
      end,
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

         local cmp_autopairs = require('nvim-autopairs.completion.cmp')
         local cmp = require('cmp')
         cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end,
   },
}
