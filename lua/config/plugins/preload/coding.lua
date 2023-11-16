local bordered = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }

return {
   {
      'L3MON4D3/LuaSnip',
      build = (not jit.os:find('Windows'))
            and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
         or nil,
      dependencies = {
         'rafamadriz/friendly-snippets',
         config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip.loaders.from_vscode').lazy_load({ paths = './lua/config/snippets/' })
         end,
      },
      opts = {
         history = true,
         delete_check_events = 'TextChanged',
      },
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
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
         local icons = require('i-nvim').lspkind

         return {
            completion = {
               completeopt = 'menu,menuone,noselect',
            },
            window = {
               completion = {
                  border = bordered,
                  col_offset = 1,
                  side_padding = 0,
                  winhighlight = 'Normal:None,CursorLine:PmenuSel,Search:None',
               },
               documentation = {
                  border = bordered,
                  winhighlight = 'Normal:None,Search:None',
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
               ['<C-CR>'] = function(fallback)
                  cmp.abort()
                  fallback()
               end,
            }),
            sources = cmp.config.sources({
               { name = 'nvim_lsp' },
               { name = 'luasnip' },
               { name = 'path' },
               { name = 'emoji', option = { insert = true } },
            }, {
               { name = 'buffer' },
            }),
            formatting = {
               format = function(_, vim_item)
                  vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind)
                  return vim_item
               end,
            },
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
      'Exafunction/codeium.vim',
      event = 'BufEnter',
      init = function()
         vim.cmd([[
         let g:codeium_filetypes = {
           \ "bash": v:false,
           \ "markdown": v:false,
           \ }
         ]])
      end,
      config = function()
         -- Change '<C-g>' here to any keycode you like.
         vim.keymap.set('i', '<C-i>', function()
            return vim.fn['codeium#Accept']()
         end, { expr = true })
         vim.keymap.set('i', '<c-;>', function()
            return vim.fn['codeium#CycleCompletions'](1)
         end, { expr = true })
         vim.keymap.set('i', '<c-,>', function()
            return vim.fn['codeium#CycleCompletions'](-1)
         end, { expr = true })
         vim.keymap.set('i', '<C-c>', function()
            return vim.fn['codeium#Clear']()
         end, { expr = true })
      end,
   },

   {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      opts = {
         fast_wrap = {},
         disable_filetype = { 'TelescopePrompt', 'vim' },
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

   {
      'echasnovski/mini.surround',
      opts = {
         mappings = {
            add = 'as', -- Add surrounding in Normal and Visual modes
            delete = 'ds', -- Delete surrounding
            replace = 'cs', -- Change surrounding
            find = '',
            find_left = '',
            highlight = '',
            update_n_lines = '',

            suffix_last = '',
            suffix_next = '',
         },
      },
   },

   {
      'JoosepAlviste/nvim-ts-context-commentstring',
      lazy = true,
      opts = {
         enable_autocmd = false,
      },
   },

   {
      'echasnovski/mini.comment',
      event = 'VeryLazy',
      opts = {
         options = {
            custom_commentstring = function()
               return require('ts_context_commentstring.internal').calculate_commentstring()
                  or vim.bo.commentstring
            end,
         },
         mappings = {
            comment = 'gc', -- Normal and Visual modes
            comment_line = ' /', -- Toggle comment on current line
            comment_visual = 'gc', -- Toggle comment on visual selection
            textobject = 'gc', -- Define 'comment' textobject (like `dgc` - delete whole comment block)
         },
      },
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
}
